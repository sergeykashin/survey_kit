import 'package:flutter/material.dart';

class SurveyProgressConfiguration {
  /// Color of the progressbar
  final Color progressbarColor;

  /// Color of the value of the progressbar
  final Color? valueProgressbarColor;

  /// Color of the background of the progressbar
  final Color? backgroundColor;

  /// Min height of the progressbar
  final double height;

  /// Padding of the progressbar and text
  final EdgeInsets padding;

  /// If a Label should be shown above the progressbar (You also need to add
  /// the label )
  final bool showLabel;

  /// Label widget which should be shown above the appbar (Also need to
  /// activate via the 'showLabel flag {from currentProgress, to
  /// finishOfProgress})
  final Function(String from, String to)? label;

  /// The corner radius of the progress bar - If not defines
  /// BorderRadius.circular(14.0)
  final BorderRadius? borderRadius;

  SurveyProgressConfiguration({
    this.progressbarColor = Colors.blueGrey,
    this.height = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.showLabel = true,
    this.borderRadius,
    this.label,
    this.backgroundColor,
    this.valueProgressbarColor,
  });
}
