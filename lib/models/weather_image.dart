import 'package:weather_app/constants/colors.dart';

String imagePath({required int id}) {
  if (id >= 200 && id <= 232) {
    return cloudZap;
  } else if (id >= 300 && id <= 321) {
    return sunCloudMidRain;
  } else if (id >= 500 && id <= 531) {
    return bigRainDrops;
  } else if (id >= 600 && id <= 622) {
    if (id >= 620) {
      return bigSnow;
    }
    return moonCloudFastWind;
  } else if (id >= 701 && id <= 781) {
    if (id >= 762) {
      return tornado;
    }
    return moonFastWind;
  } else if (id == 800) {
    return sunCloudAngledRain;
  }
  return sunCloudLittleRain;
}

Map<String, double> homeImagePath({required int id}) {
  if (id >= 200 && id <= 232) {
    return {cloudZap: 1};
  } else if (id >= 300 && id <= 321) {
    return {sunCloudMidRain: 1};
  } else if (id >= 500 && id <= 531) {
    return {bigRainDrops: 1};
  } else if (id >= 600 && id <= 622) {
    if (id >= 620) {
      return {bigSnow: 1};
    }
    return {moonCloudFastWind: 1};
  } else if (id >= 701 && id <= 781) {
    if (id >= 762) {
      return {tornado: 1};
    }
    return {moonFastWind: 1};
  } else if (id == 800) {
    return {sunClear: 1.5};
  }
  return {sun: 1.5};
}
