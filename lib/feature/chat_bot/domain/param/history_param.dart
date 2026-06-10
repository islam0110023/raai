class HistoryParam {
  const HistoryParam({required this.role, required this.text});
  final String role;
  final String text;
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': [
        {'text': text},
      ],
    };
  }
}
