import 'package:flutter/cupertino.dart';

/// There are currently 15 weather types
enum SpecialEffect {
  sunnyNight,

  // The following types do not show any special effects
  sunny,
  cloudy,
  cloudyNight,
  overcast,
  hazy,
  foggy,
  dusty,

  // New weather types

  // Thunderstorm
  thunderWithLightRainy,
  thunderWithMiddleRainy,
  thunderWithHeavyRainy,

  thunder,

  // Drizzle & Rain
  heavyRainy,
  middleRainy,
  lightRainy,

  // Show
  heavySnow,
  middleSnow,
  lightSnow,

  none,
}

/// Data loading status
enum WeatherDataState {
  init,
  loading,
  finish,
}

/// Weather related tools
class WeatherUtil {
  static bool isSnowRain(SpecialEffect weatherType) {
    return isRainy(weatherType) || isSnow(weatherType);
  }

  /// Determine whether it is raining. Small, medium and large, including thunderstorms, are all types of rain.
  static bool isRainy(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.lightRainy ||
        weatherType == SpecialEffect.middleRainy ||
        weatherType == SpecialEffect.heavyRainy ||
        weatherType == SpecialEffect.thunder;
  }

  static bool isSnow(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.lightSnow ||
        weatherType == SpecialEffect.middleSnow ||
        weatherType == SpecialEffect.heavySnow;
  }

  static bool isThunder(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.thunderWithLightRainy ||
        weatherType == SpecialEffect.thunderWithMiddleRainy ||
        weatherType == SpecialEffect.thunderWithHeavyRainy ||
        weatherType == SpecialEffect.thunder;
  }

  static bool isHeavyRainy(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.heavyRainy ||
        weatherType == SpecialEffect.thunderWithHeavyRainy;
  }

  static bool isMiddleRainy(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.middleRainy ||
        weatherType == SpecialEffect.thunderWithMiddleRainy;
  }

  static bool isLightRainy(SpecialEffect weatherType) {
    return weatherType == SpecialEffect.lightRainy ||
        weatherType == SpecialEffect.thunderWithLightRainy;
  }

  // Get the color value of the background based on the weather type
  static List<Color> getColor(SpecialEffect weatherType) {
    switch (weatherType) {
      case SpecialEffect.sunnyNight:
        return [Color(0xFF061E74), Color(0xFF275E9A)];
      case SpecialEffect.cloudyNight:
        return [Color(0xFF2C3A60), Color(0xFF4B6685)];
      case SpecialEffect.overcast:
        return [Color(0xFF8FA3C0), Color(0xFF8C9FB1)];
      case SpecialEffect.hazy:
        return [Color(0xFF989898), Color(0xFF4B4B4B)];
//Added
      case SpecialEffect.sunny:
        return [Color(0xFF0071D1), Color(0xFF6DA6E4)];

      case SpecialEffect.cloudy:
        return [Color(0xFF5C82C1), Color(0xFF95B1DB)];
      case SpecialEffect.lightRainy:
        return [Color(0xFF556782), Color(0xFF7c8b99)];
      case SpecialEffect.middleRainy:
        return [Color(0xFF3A4B65), Color(0xFF495764)];
      case SpecialEffect.heavyRainy:
      case SpecialEffect.thunder:
        return [Color(0xFF3B434E), Color(0xFF565D66)];

      case SpecialEffect.foggy:
        return [Color(0xFFA6B3C2), Color(0xFF737F88)];
      case SpecialEffect.lightSnow:
        return [Color(0xFF6989BA), Color(0xFF9DB0CE)];
      case SpecialEffect.middleSnow:
        return [Color(0xFF8595AD), Color(0xFF95A4BF)];
      case SpecialEffect.heavySnow:
        return [Color(0xFF98A2BC), Color(0xFFA7ADBF)];
      case SpecialEffect.dusty:
        return [Color(0xFFB99D79), Color(0xFF6C5635)];

      default:
        return [Color(0xFF0071D1), Color(0xFF6DA6E4)];
    }
  }

  // Get weather description information based on weather type
  static String getWeatherDesc(SpecialEffect weatherType) {
    switch (weatherType) {
      case SpecialEffect.sunny:
      case SpecialEffect.sunnyNight:
        return "晴";
      case SpecialEffect.cloudy:
      case SpecialEffect.cloudyNight:
        return "多云";
      case SpecialEffect.overcast:
        return "阴";
      case SpecialEffect.lightRainy:
        return "小雨";
      case SpecialEffect.middleRainy:
        return "中雨";
      case SpecialEffect.heavyRainy:
        return "大雨";
      case SpecialEffect.thunder:
        return "雷阵雨";
      case SpecialEffect.hazy:
        return "雾";
      case SpecialEffect.foggy:
        return "霾";
      case SpecialEffect.lightSnow:
        return "小雪";
      case SpecialEffect.middleSnow:
        return "中雪";
      case SpecialEffect.heavySnow:
        return "大雪";
      case SpecialEffect.dusty:
        return "浮尘";
      default:
        return "晴";
    }
  }
}
