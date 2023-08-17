import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

extension TrackballBehaviorExt on TrackballBehavior {
  InteractiveTooltip setTooltipColor(Color color) {
    final currentTooltipSettings = tooltipSettings;

    return InteractiveTooltip(
      decimalPlaces: currentTooltipSettings.decimalPlaces,
      color: color,
      enable: true,
      arrowLength: 0,
      arrowWidth: 0,
      format: currentTooltipSettings.format,
    );
  }
}
