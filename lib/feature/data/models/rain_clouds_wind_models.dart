import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class RainModels extends RainEntity {
  RainModels({d1h}) : super(d1h: d1h);

  factory RainModels.fromJson(Map<String, dynamic> json) {
    return RainModels(d1h: json['1h']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1h'] = d1h;
    return data;
  }
}

class CloudsModels extends CloudsEntity {
  CloudsModels({all}) : super(all: all);

  factory CloudsModels.fromJson(Map<String, dynamic> json) {
    return CloudsModels(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class WindModels extends WindEntity {
  WindModels({speed, deg, gust}) : super(deg: deg, speed: speed, gust: gust);

  factory WindModels.fromJson(Map<String, dynamic> json) {
    return WindModels(speed: json['speed'], deg: json['deg'], gust: json['gust']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}
