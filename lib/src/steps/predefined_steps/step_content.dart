import 'package:json_annotation/json_annotation.dart';

part 'step_content.g.dart';

@JsonSerializable(explicitToJson: true)
class StepContent {
  final Type type;
  final String content;


  StepContent({required this.type, required this.content});
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     "type": this.type,
  //     "content": this.content,
  //   };
  // }
  //
  // factory StepContent.fromJson(Map<String, dynamic> json) {
  //   return StepContent(
  //     type: Type.values.byName(json["type"]),
  //     content: json["content"],
  //   );
  // }
  factory StepContent.fromJson(Map<String, dynamic> json) =>
      _$StepContentFromJson(json);
  Map<String, dynamic> toJson() => _$StepContentToJson(this);


  @override
  String toString() {
    return 'StepContent{type: $type, content: $content}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepContent &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          content == other.content;

  @override
  int get hashCode => type.hashCode ^ content.hashCode;

//
}
enum Type { text, html, image,video, youtube }

