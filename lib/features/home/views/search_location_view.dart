import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/home_cubit.dart';

class SearchLocationView extends StatefulWidget {
  final String locationType;

  const SearchLocationView({super.key, required this.locationType});

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  final _searchController = TextEditingController();
  final _dio = Dio();
  Timer? _debounce;

  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;

  Future<void> _search(String query) async {
    if (query.trim().length < 2) {
      setState(() => _results = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final res = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'addressdetails': 1,
          'limit': 15,
          'countrycodes': 'eg',
          'accept-language': 'ar,en',
        },
        options: Options(headers: {'User-Agent': 'Za2zo2a/1.0'}),
      );

      if (!mounted) return;
      if (res.statusCode == 200 && res.data is List) {
        setState(() {
          _results = (res.data as List)
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onChanged(String val) {
    _debounce?.cancel();
    if (val.trim().length < 2) {
      setState(() => _results = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () => _search(val));
  }

  void _onSelected(Map<String, dynamic> place) {
    final name = (place['display_name'] as String?) ?? '';
    final lat = double.tryParse('${place['lat']}');
    final lng = double.tryParse('${place['lon']}');
    final coords = (lat != null && lng != null) ? LatLng(lat, lng) : null;

    final cubit = context.read<HomeCubit>();
    if (widget.locationType == 'home') {
      cubit.saveHomeAddress(name);
    } else if (widget.locationType == 'work') {
      cubit.saveWorkAddress(name);
    } else {
      cubit.selectDestination(name, coords: coords);
    }
    context.pop();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Where to?';
    if (widget.locationType == 'home') title = 'Set Home Address';
    if (widget.locationType == 'work') title = 'Set Work Address';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title, style: AppTextStyles.h2(context)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(context.widthPct(16)),
            child: TextField(
              controller: _searchController,
              onChanged: _onChanged,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search places in Egypt…',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _results = []);
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.grey100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.widthPct(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Pick on map button
          if (widget.locationType == 'destination')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.map_outlined, color: AppColors.primary),
                ),
                title: Text('Pick on map',
                    style: AppTextStyles.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text('Tap to choose a location on the map',
                    style: AppTextStyles.bodySmall(context)),
                onTap: () async {
                  final result = await context.push<LatLng>('/home/pick-on-map');
                  if (result != null && mounted) {
                    context.read<HomeCubit>().selectDestination(
                      '${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}',
                      coords: result,
                    );
                    context.pop();
                  }
                },
              ),
            ),

          if (_isLoading) LinearProgressIndicator(color: AppColors.primary),

          Expanded(
            child: _results.isEmpty && !_isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Search for a city, street, or landmark in Egypt.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(context)
                            .copyWith(color: AppColors.grey500),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, i) {
                      final place = _results[i];
                      final fullName =
                          (place['display_name'] as String?) ?? 'Unknown';
                      final parts = fullName.split(',');
                      final mainName = parts.first.trim();
                      final sub = parts.length > 1
                          ? parts.sublist(1).join(',').trim()
                          : '';
                      final type = (place['type'] as String?) ?? '';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.grey200,
                          child: Icon(
                            _iconForType(type),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        title: Text(mainName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLarge(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                        subtitle: Text(sub,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall(context)),
                        onTap: () => _onSelected(place),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'city':
      case 'town':
      case 'village':
        return Icons.location_city;
      case 'road':
      case 'street':
        return Icons.add_road;
      case 'suburb':
      case 'neighbourhood':
        return Icons.apartment;
      default:
        return Icons.location_on;
    }
  }
}
