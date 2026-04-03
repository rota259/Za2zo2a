import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../cubit/home_cubit.dart';

class SearchLocationView extends StatefulWidget {
  final String locationType; // 'destination', 'home', 'work'

  const SearchLocationView({super.key, required this.locationType});

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();

  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  // Use OpenStreetMap Nominatim for free place search API
  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'addressdetails': 1,
          'limit': 5,
        },
        options: Options(headers: {'User-Agent': 'Za2zo2a_App/1.0'}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _searchResults = response.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _onLocationSelected(String locationName) {
    if (widget.locationType == 'home') {
      context.read<HomeCubit>().saveHomeAddress(locationName);
    } else if (widget.locationType == 'work') {
      context.read<HomeCubit>().saveWorkAddress(locationName);
    } else {
      context.read<HomeCubit>().selectDestination(locationName);
    }
    context.pop(); // Go back
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
              onChanged: (val) {
                // simple debounce could go here, but doing direct for simplicity
                if (val.length > 2) {
                  _searchPlaces(val);
                } else if (val.isEmpty) {
                  setState(() => _searchResults = []);
                }
              },
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search real places...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchResults = []);
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

          if (_isLoading) LinearProgressIndicator(color: AppColors.primary),

          Expanded(
            child: _searchResults.isEmpty && !_isLoading
                ? Center(
                    child: Text(
                      'Search for a city, street, or landmark.',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.grey500),
                    ),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final place = _searchResults[index];
                      final name = place['display_name'] ?? 'Unknown location';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.grey200,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        title: Text(
                          name.split(',').first, // main name
                          style: AppTextStyles.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall(context),
                        ),
                        onTap: () => _onLocationSelected(name),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
