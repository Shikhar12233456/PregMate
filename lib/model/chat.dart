class Chat {
  final String message;
  final String userId;
  final String time;
  final String peerId;
  Chat(
      {required this.message,
      required this.userId,
      required this.peerId,
      required this.time});

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'message': message,
      'userId': userId,
      'time': time,
      'peerId':peerId
    };
  }
}
