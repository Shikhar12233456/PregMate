class ChatRoom {
  final String uid;
  final String peerId;
  final String peerName;
  final String time;
  final String peerImageUrl;
  final String recentChat;
  ChatRoom(
      {required this.uid,
      required this.peerId,
      required this.peerName,
      required this.time,
      required this.peerImageUrl,
      required this.recentChat});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'peerId': peerId,
      'peerName': peerName,
      'time': time,
      'peerImageUrl': peerImageUrl,
      'recentChat': recentChat
    };
  }
}
