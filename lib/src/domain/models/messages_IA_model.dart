class IMessagesIAModel {
  final String role;
  final String content;

  IMessagesIAModel({required this.role, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
