import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_cloud_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_color_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_night_star_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_rain_snow_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_thunder_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/special_effect.dart';

enum Background {
  background,
  effect,
  both,
}

/// The most core class, collection background&thunder&rain&snow&sunny&meteor effects
/// 1. Support dynamic size switching
/// 2. Support gradient transition
class WeatherBg extends StatefulWidget {
  final SpecialEffect weatherType;
  final Background background;
  final double width;
  final double height;

  WeatherBg({
    Key? key,
    required this.weatherType,
    this.background = Background.both,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _WeatherBgState createState() => _WeatherBgState();
}

class _WeatherBgState extends State<WeatherBg>
    with SingleTickerProviderStateMixin {
  SpecialEffect? _oldWeatherType;
  bool needChange = false;
  var state = CrossFadeState.showSecond;

  @override
  void didUpdateWidget(WeatherBg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.weatherType != oldWidget.weatherType) {
      // 如果类别发生改变，需要 start 渐变动画
      _oldWeatherType = oldWidget.weatherType;
      needChange = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var oldBgWidget;
    if (_oldWeatherType != null) {
      oldBgWidget = WeatherItemBg(
        weatherType: _oldWeatherType!,
        background: widget.background,
        width: widget.width,
        height: widget.height,
      );
    }
    var currentBgWidget = WeatherItemBg(
      weatherType: widget.weatherType,
      background: widget.background,
      width: widget.width,
      height: widget.height,
    );
    if (oldBgWidget == null) {
      oldBgWidget = currentBgWidget;
    }
    var firstWidget = currentBgWidget;
    var secondWidget = currentBgWidget;
    if (needChange) {
      if (state == CrossFadeState.showSecond) {
        state = CrossFadeState.showFirst;
        firstWidget = currentBgWidget;
        secondWidget = oldBgWidget;
      } else {
        state = CrossFadeState.showSecond;
        secondWidget = currentBgWidget;
        firstWidget = oldBgWidget;
      }
    }
    needChange = false;
    return SizeInherited(
      child: AnimatedCrossFade(
        firstChild: firstWidget,
        secondChild: secondWidget,
        duration: Duration(milliseconds: 300),
        crossFadeState: state,
      ),
      size: Size(widget.width, widget.height),
    );
  }
}

class WeatherItemBg extends StatelessWidget {
  final SpecialEffect weatherType;
  final Background background;
  final width;
  final height;

  WeatherItemBg({
    Key? key,
    required this.weatherType,
    this.background = Background.both,
    this.width,
    this.height,
  }) : super(key: key);

  // /// 构建晴晚背景效果
  // Widget _buildNightStarBg() {
  //   if (weatherType == WeatherType.sunnyNight) {
  //     return WeatherNightStarBg(
  //       weatherType: weatherType,
  //     );
  //   }
  //   return Container();
  // }

  // /// 构建雷暴效果
  // Widget _buildThunderBg() {
  //   if (weatherType == WeatherType.thunder) {
  //     return WeatherThunderBg(
  //       weatherType: weatherType,
  //     );
  //   }
  //   return Container();
  // }

  // /// 构建雨雪背景效果
  // Widget _buildRainSnowBg() {
  //   if (WeatherUtil.isSnowRain(weatherType)) {
  //     return WeatherRainSnowBg(
  //       weatherType: weatherType,
  //       viewWidth: width,
  //       viewHeight: height,
  //     );
  //   }
  //   return Container();
  // }

  _buildThunderBg() {
    if (WeatherUtil.isThunder(weatherType)) {
      // TODO: This does not work
      return WeatherThunderBg(
        weatherType: SpecialEffect.thunder,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildRainBg() {
    SpecialEffect? wt;

    if (WeatherUtil.isHeavyRainy(weatherType)) {
      wt = SpecialEffect.heavyRainy;
    } else if (WeatherUtil.isMiddleRainy(weatherType)) {
      wt = SpecialEffect.middleRainy;
    } else if (WeatherUtil.isLightRainy(weatherType)) {
      wt = SpecialEffect.lightRainy;
    }

    if (wt != null) {
      return WeatherRainSnowBg(
        weatherType: wt,
        viewWidth: width,
        viewHeight: height,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildSnowBg() {
    if (WeatherUtil.isSnow(weatherType)) {
      return WeatherRainSnowBg(
        weatherType: weatherType,
        viewWidth: width,
        viewHeight: height,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildNoneBg() {
    if (weatherType == SpecialEffect.none) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        // child: Center(
        //   child: Text(
        //     'none',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 60,
        //     ),
        //   ),
        // ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    bool showBackground =
        background == Background.background || background == Background.both;
    bool showEffect =
        background == Background.effect || background == Background.both;
    return Container(
      width: width,
      height: height,
      child: ClipRect(
        child: Stack(
          children: [
            // This draws the background color
            // if (showBackground)
            WeatherColorBg(
              weatherType: weatherType,
            ),
            // This draws the clouds
            // WeatherCloudBg(
            //   weatherType: weatherType,
            // ),
            // _buildRainSnowBg(),
            // _buildThunderBg(),
            // _buildNightStarBg(),

            // if (showBackground)
            WeatherCloudBg(
              weatherType: weatherType,
            ),
            // if (showEffect)
            _buildRainBg(),
            // if (showEffect)
            _buildThunderBg(),
            // if (showEffect)
            _buildSnowBg(),
            // if (showEffect)
            _buildNoneBg(),
          ],
        ),
      ),
    );
  }
}

class SizeInherited extends InheritedWidget {
  final Size size;

  const SizeInherited({
    Key? key,
    required Widget child,
    required this.size,
  }) : super(key: key, child: child);

  static SizeInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SizeInherited>();
  }

  @override
  bool updateShouldNotify(SizeInherited old) {
    return old.size != size;
  }
}
