import 'package:equatable/equatable.dart';

import '../../../../core/network/repository_base.dart';

/// Flat trip row for the history list. Built tolerantly from the backend trip
/// shape returned by GET /api/trips/history.
class TripModel extends Equatable {
  final String id;
  final String date;
  final String time;
  final String pickup;
  final String dropoff;
  final double price;
  final String status;

  const TripModel({
    required this.id,
    required this.date,
    required this.time,
    required this.pickup,
    required this.dropoff,
    required this.price,
    required this.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final map = json.mapField(['data', 'trip']) ?? json;

    // origin/destination may be nested objects with an address.
    String addr(List<String> keys, String fallback) {
      final v = map.pick(keys);
      if (v is Map) {
        final m = Map<String, dynamic>.from(v);
        return m.str(['address', 'name', 'label']) ?? fallback;
      }
      return v?.toString() ?? fallback;
    }

    // Parse a timestamp into date + time, if present.
    String date = '';
    String time = '';
    final ts = map.str(['createdAt', 'created_at', 'date', 'requestedAt']);
    if (ts != null) {
      final parsed = DateTime.tryParse(ts);
      if (parsed != null) {
        final l = parsed.toLocal();
        date = '${l.year}-${_pad(l.month)}-${_pad(l.day)}';
        time = '${_pad(l.hour)}:${_pad(l.minute)}';
      } else {
        date = ts;
      }
    }

    return TripModel(
      id: map.str(['id', '_id', 'tripId']) ?? '',
      date: date,
      time: time,
      pickup: addr(['origin', 'pickup', 'from'], 'Pickup'),
      dropoff: addr(['destination', 'dropoff', 'to'], 'Destination'),
      price: map.dbl(['fare', 'price', 'cost', 'amount']) ?? 0,
      status: map.str(['status', 'state']) ?? '',
    );
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  List<Object?> get props => [id, date, time, pickup, dropoff, price, status];
}
