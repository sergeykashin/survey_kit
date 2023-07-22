import 'package:flutter/material.dart';
import 'package:survey_kit/src/result/step/instruction_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/instruction_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

import '../steps/predefined_steps/media_step.dart';

class MediaView extends StatelessWidget {
  final MediaStep mediaStep;
  final DateTime _startDate = DateTime.now();

  MediaView({required this.mediaStep});

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: mediaStep,
      title: Text(
        mediaStep.title,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
      resultFunction: () => InstructionStepResult(
        mediaStep.stepIdentifier,
        _startDate,
        DateTime.now(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
              mediaStep.text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Image.network(mediaStep.imageUrl),
            ]
          )
        )
      ),
    );
  }
}
