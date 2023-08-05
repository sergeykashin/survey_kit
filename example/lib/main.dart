import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class TabbedPage extends StatefulWidget {
  @override
  Tabscreenstate createState() => new Tabscreenstate();
}

class Tabscreenstate extends State with TickerProviderStateMixin {
  int selectedTabIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedTabIndex = tabController.index;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tabbar(),
        Container(color:selectedTabIndex == 0 ? Colors.red : Colors.green),
      ],
    );
  }

  Widget tabbar() => TabBar(
    controller: tabController,
    onTap: (value) {
      setState(() {
        selectedTabIndex = value;
      });
    },
    tabs: [
      Text("tab one"),
      Text("tab two"),
    ],
  );
}


class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: getContent(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Инструкции',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Обучение',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Задачи',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.black12,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Container getSurvey() {
    return Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),//getJsonTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null)  {
                final task = snapshot.data!;
                return SurveyKit(
                  onResult: (SurveyResult result) {
                    print(result.finishReason);
                    Navigator.pushNamed(context, '/');
                  },
                  task: task,
                  showProgress: true,
                  localizations: {
                    'cancel': 'Cancel',
                    'next': 'Next',
                  },
                  themeData: Theme.of(context).copyWith(
                    primaryColor: Colors.cyan,
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      iconTheme: IconThemeData(
                        color: Colors.cyan,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.cyan,
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Colors.cyan,
                      selectionColor: Colors.cyan,
                      selectionHandleColor: Colors.cyan,
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: Colors.cyan,
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return BorderSide(
                                color: Colors.grey,
                              );
                            }
                            return BorderSide(
                              color: Colors.cyan,
                            );
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textStyle: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.grey,
                                  );
                            }
                            return Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.cyan,
                                );
                          },
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Colors.cyan,
                              ),
                        ),
                      ),
                    ),
                    textTheme: TextTheme(
                      displayMedium: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      ),
                      headlineSmall: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      bodyMedium: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      titleMedium: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.cyan,
                    )
                        .copyWith(
                          onPrimary: Colors.white,
                        )
                        .copyWith(background: Colors.white),
                  ),
                  surveyProgressbarConfiguration: SurveyProgressConfiguration(
                    backgroundColor: Colors.white,
                    label: getLabel()
                  ),
                );
              }
              return CircularProgressIndicator.adaptive();
            },
          ),
        ),
      );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Простой опрос\nQuickBird Studios\nHealth Survey',
          text: 'Get ready for a bunch of super random questions!',
          buttonText: 'Let\'s go!',
        ),
        MediaStep(
          title: 'Медиа шаг',
          showProgress: true,
          elements : [
            StepContent(type: Type.text,content: 'Pinarello dogma'),
            StepContent(type: Type.image,content: 'https://pro-bike.ru/data/images/posts/47/33047/555.jpg'),
            StepContent(type: Type.image,content: 'https://pro-bike.ru/data/images/posts/47/33047/555.jpg'),
            StepContent(type: Type.video,content: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
//            StepContent(type: Type.video,content: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
            //,
            //StepContent(type: Type.video,content: 'assets/test.mp4')
          ],
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'Сколько вам лет?',
//          label: "Возраст",
          answerFormat: IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Введите ваш возраст',
          ),
          isOptional: true,
        ),
        MediaStep(
          title: 'Медиа шаг',
          showProgress: true,
          elements : [
            StepContent(type: Type.text,content: 'Открутите гайку'),
            StepContent(type: Type.image,content: 'http://remcopy.com/generic/uploaded/xerox_3600/6.png'),
//            StepContent(type: Type.video,content: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
            StepContent(type: Type.youtube,content: 'w7oBdLH49S0'),
            //,
            //StepContent(type: Type.video,content: 'assets/test.mp4')
          ],
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'Medication?',
          text: 'Are you using any medication',
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Tell us about you',
          text:
              'Tell us about yourself and why you want to improve your health.',
          answerFormat: TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'На сколько ты толстый?',
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 1,
            maximumValue: 5,
            defaultValue: 3,
            minimumValueDescription: '1',
            maximumValueDescription: '5',
          ),
        ),
        QuestionStep(
          title: 'На что у вас аллергия',
          text: 'Do you have any allergies that we should be aware of?',
          isOptional: false,
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Penicillin', value: 'Penicillin'),
              TextChoice(text: 'Latex', value: 'Latex'),
              TextChoice(text: 'Pet', value: 'Pet'),
              TextChoice(text: 'Pollen', value: 'Pollen'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Done?',
          text: 'We are done, do you mind to tell us more about yourself?',
          isOptional: true,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Y es', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
            ],
            defaultSelection: TextChoice(text: 'No', value: 'No'),
          ),
        ),
        QuestionStep(
          title: 'When did you wake up?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 12,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'When was your last holiday?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            defaultDate: DateTime.now(),
            maxDate: DateTime.now(),
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[7].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }

  getLabel
      () {"a1";"a2";}

  Container getContent(int selectedIndex) {
      switch(selectedIndex){
        case 0:
          return getSurvey();
          //Home
        case 1:
          return Container(
              color: Colors.white,
                child:Text(
                'Инструкции'
                ));
        case 2:
          return Container(
              color: Colors.white,
              child:Text(
                  'Обучение'
              ));
        case 3:
          return Container(
              color: Colors.white,
              child:Text(
                  'Задачи'
              ));
      }
      return Container(
          color: Colors.white);
  }
}
