import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [id, date, time, pickup, dropoff, price, status];
}
