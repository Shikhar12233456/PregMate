
class CommentModel {
  final Map<String,dynamic> userr;
  final String time;
  final String data;

  CommentModel({required this.time, required this.data, required this.userr});

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'time': time,
      'data': data,
      'userr': userr,
    };
  }
}
