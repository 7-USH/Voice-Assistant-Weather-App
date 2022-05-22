class WeatherModel {
  Main? main;
  String? name;
  Weather? weather;
  Wind? wind;

  WeatherModel({this.main, this.name, this.weather, this.wind});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    name = json['name'];
    if (json['weather'] != null) {
      List<dynamic> data = json['weather'];
      weather = data[0] != null ? Weather.fromJson(data[0]) : null;
    }
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['name'] = name;
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    return data;
  }
}

class Main {
  num? feelsLike;
  num? grndLevel;
  num? humidity;
  num? pressure;
  num? seaLevel;
  num? temp;
  num? tempMax;
  num? tempMin;

  Main(
      {this.feelsLike,
      this.grndLevel,
      this.humidity,
      this.pressure,
      this.seaLevel,
      this.temp,
      this.tempMax,
      this.tempMin});

  Main.fromJson(Map<String, dynamic> json) {
    feelsLike = json['feels_like'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    temp = json['temp'];
    tempMax = json['temp_max'];
    tempMin = json['temp_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feels_like'] = feelsLike;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['temp'] = temp;
    data['temp_max'] = tempMax;
    data['temp_min'] = tempMin;
    return data;
  }
}

class Weather {
  String? description;
  String? icon;
  num? id;
  String? main;

  Weather({this.description, this.icon, this.id, this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
    id = json['id'];
    main = json['main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['icon'] = icon;
    data['id'] = id;
    data['main'] = main;
    return data;
  }
}

class Wind {
  int? deg;
  num? gust;
  num? speed;

  Wind({this.deg, this.gust, this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    deg = json['deg'];
    gust = json['gust'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deg'] = deg;
    data['gust'] = gust;
    data['speed'] = speed;
    return data;
  }
}
