// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
part 'location_model.g.dart';

@HiveType(typeId: 0)
class Location extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
