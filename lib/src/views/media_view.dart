import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/step/instruction_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/step_content.dart';
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
      resultFunction: () => InstructionStepResult(//TODO may be add own result
        mediaStep.stepIdentifier,
        _startDate,
        DateTime.now(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:getContentElements(mediaStep.elements,context)
          )
        )
      ),
    );
  }

  List<Widget> getContentElements(List<StepContent> elements, BuildContext context,) {
    List<Widget> result = [];

    elements.forEach((element) {
      switch(element.type){
        case Type.text:
          result.add(
            Text(
              element.content,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center
            )
          );
          break;
        case Type.html:
          result.add(
              Text(
                  element.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center
              )
          );
          break;
        case Type.image:
          result.add(
            Image.network(element.content)
          );
          break;
        case Type.video:
          result.add(
              Text(
                  element.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center
              )
          );
          break;
        case Type.youtube:
          result.add(
              Text(
                  element.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center
              )
          );
          break;
      }

    });

    return result;
  }
}
