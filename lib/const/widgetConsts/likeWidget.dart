import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr301/firebase/upload/like.dart';

class LikeWidget {
  Widget likeandcout(String docId, String currentUserId) {
    return SizedBox(
      child: Row(
        children: [
          FutureBuilder(
              future: heartIcon(docId, currentUserId),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    child: Row(
                      children: const [Icon(CupertinoIcons.add), Text("0")],
                    ),
                  );
                } else {
                  if (snapshot.data!.contains(currentUserId)) {
                    return SizedBox(
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.heart_circle_fill),
                          Text(snapshot.data!.length.toString())
                        ],
                      ),
                    );
                  } else {
                    SizedBox(
                      child: Row(
                        children: const [Icon(CupertinoIcons.heart), Text("0")],
                      ),
                    );
                  }
                }
                return Card();
              })),
        ],
      ),
    );
  }

  Future<List> heartIcon(String docId, String currUserId) async {
    List likeList = await Like().get(docId);
    return likeList;
  }
}
