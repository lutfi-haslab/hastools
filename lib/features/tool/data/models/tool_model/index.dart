import 'package:freezed_annotation/freezed_annotation.dart';

part 'index.freezed.dart';
part 'index.g.dart';

@freezed
class Tool with _$Tool {
  const factory Tool({
    required String name,
    required String imageUrl,
    required int clickCount,
    required String path,
  }) = _Tool;

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);
}
