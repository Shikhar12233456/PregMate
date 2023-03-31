class ChatRoom {
  final String uid;
  final String peerId;
  final String peerName;
  final String time;
  final String peerImageUrl;
  ChatRoom(
      {required this.uid,
      required this.peerId,
      required this.peerName,
      required this.time,
      required this.peerImageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'peerId': peerId,
      'peerName': peerName,
      'time': time,
      'peerImageUrl': peerImageUrl
    };
  }
}
