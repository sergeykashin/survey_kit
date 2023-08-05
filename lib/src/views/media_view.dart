import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/step/instruction_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/step_content.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../steps/predefined_steps/media_step.dart';

class MediaView extends StatefulWidget {
  final MediaStep mediaStep;
  final DateTime _startDate = DateTime.now();

  MediaView({required this.mediaStep});

  @override
  _MediaViewState createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> {
  VideoPlayerController? _controller;
  YoutubePlayerController? youController;

  void  _initController(String link) {
    _controller = VideoPlayerController.network(link)
      ..initialize().then((_) {
        setState(() {});
      });
  }
  Future<void> _onControllerChange(String link) async {
    if (_controller == null) {
      // If there was no controller, just create a new one
      _initController(link);
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _controller;

      // Registering a callback for the end of next frame
      // to dispose of an old controller
      // (which won't be used anymore after calling setState)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController!.dispose();

        // Initing new controller
        _initController(link);
      });

      // Making sure that controller is not used by setting it to null
      setState(() {
        //_controller = null;
      });
    }
  }


  @override
  void initState() {
    //_onControllerChange('assets/test.mp4');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.mediaStep,
      title: Text(
        widget.mediaStep.title,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
      resultFunction: () => InstructionStepResult(//TODO may be add own result
        widget.mediaStep.stepIdentifier,
        widget._startDate,
        DateTime.now(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:getContentElements(widget.mediaStep.elements,context)
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
          if(_controller==null)
            _onControllerChange(element.content);

          result.add(
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ));
          result.add(
            Container( //duration of video
              child: Text("Total Duration: " + _controller!.value.duration.toString()),
            ));
          result.add(
            Container(
                child: VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors:VideoProgressColors(
                      backgroundColor: Colors.redAccent,
                      playedColor: Colors.green,
                      bufferedColor: Colors.purple,
                    )
                )
            ));
          result.add(Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: (){
                      if(_controller!.value.isPlaying){
                        _controller!.pause();
                      }else{
                        _controller!.play();
                      }
                      // setState(() {
                      // });
                    },
                    icon:Icon(_controller!.value.isPlaying?Icons.pause:Icons.play_arrow)
                ),

                IconButton(
                    onPressed: (){
                      _controller!.seekTo(Duration(seconds: 0));

                      setState(() {

                      });
                    },
                    icon:Icon(Icons.stop)
                ),
              ],
            ),
          ));
          break;
        case Type.youtube:
          if(youController==null){
            youController = YoutubePlayerController(
                  initialVideoId: element.content,
                  flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                  captionLanguage:'ru'
                )
            );
          }

          result.add(
            Container(
              child: YoutubePlayer(
                controller: youController!,
                showVideoProgressIndicator: true,
              ),
            ),
          );
          break;
      }

    });

    return result;
  }

  //
  // void loadVideoPlayer(String url) {
  //   controller = VideoPlayerController.network(url);
  //
  //   controller.addListener(() {
  //     setState(() {});
  //   });
  //   controller.initialize().then((value) {
  //     setState(() {});
  //   });
  // }

  @override
  void dispose() {
    if (_controller!.value.isPlaying) _controller!.pause();
      _controller!.dispose();
    if (youController!.value.isPlaying) youController!.pause();
      youController!.dispose();
    super.dispose();
  }
}
