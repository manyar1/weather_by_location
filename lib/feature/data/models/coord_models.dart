import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class CoordModels extends CoordEntity {
  CoordModels({lon, lat}) : super(lat: lat, lon: lon);

  factory CoordModels.fromJson(Map<String, dynamic> json) {
    return CoordModels(lon: json['lon'], lat: json['lat']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
