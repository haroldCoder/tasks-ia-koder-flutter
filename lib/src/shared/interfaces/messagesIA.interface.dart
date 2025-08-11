class MessagesIAInterface {
  final String role;
  final String content;

  MessagesIAInterface({required this.role, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
