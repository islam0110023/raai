import 'package:flutter/foundation.dart';

enum QuestionType { boolean, number, singleChoice }

@immutable
class SurveyQuestion {
  const SurveyQuestion({
    required this.id,
    required this.key,
    required this.question,
    required this.type,
    required this.options,
  });
  final int id;
  final String key;
  final String question;
  final QuestionType type;
  final List<String> options;
}
