class QuestionResponse {
  final bool success;
  final String message;

  QuestionResponse({required this.success, required this.message});

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
