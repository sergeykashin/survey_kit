import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/views/instruction_view.dart';

import '../../views/media_view.dart';
import 'step_content.dart';

part 'media_step.g.dart';

@JsonSerializable(explicitToJson: true)
class MediaStep extends Step {
  final String title;
  final List<StepContent> elements;


  MediaStep({
    required this.title,
    required this.elements,
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier? stepIdentifier,
    bool? canGoBack,
    bool? showProgress,
    bool showAppBar = true,
  }) : super(
          stepIdentifier: stepIdentifier,
          isOptional: isOptional,
          buttonText: buttonText,
          canGoBack: canGoBack ?? false,
          showProgress: showProgress ?? false,
          showAppBar: showAppBar,
        );

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return MediaView(
      mediaStep: this,
    );
  }

  factory MediaStep.fromJson(Map<String, dynamic> json) =>
      _$MediaStepFromJson(json);
  Map<String, dynamic> toJson() => _$MediaStepToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is MediaStep &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          elements == other.elements;

  @override
  int get hashCode => super.hashCode ^ title.hashCode ^ elements.hashCode;
}
