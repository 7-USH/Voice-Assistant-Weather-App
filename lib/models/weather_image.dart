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
    return mildSnowFastWinds;
  } else if (id == 800) {
    return sunCloudAngledRain;
  }
  return sunCloudLittleRain;
}

String homeImagePath({required int id}) {
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
    return mildSnowFastWinds;
  } else if (id == 800) {
    return sunClear;
  }
  return sun;
}
