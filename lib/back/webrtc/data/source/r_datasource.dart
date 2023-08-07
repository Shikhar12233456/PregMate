import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _recentcalls = 'recentcalls';
  static const ongoingcall = 'ongoingcall';
  String? userId;
  
}
