import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class SysModels extends SysEntity {
  SysModels({type, id, country, sunrise, sunset})
      : super(country: country, type: type, id: id, sunrise: sunrise, sunset: sunset);

  factory SysModels.fromJson(Map<String, dynamic> json) {
    return SysModels(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
