import 'package:flutter/material.dart';
import 'package:pr301/const/Myconsts/colours.dart';

class UserInfoTile extends StatefulWidget {
  const UserInfoTile({Key? key, required this.icon, required this.info})
      : super(key: key);
  final IconData icon;
  final String info;
  @override
  State<UserInfoTile> createState() => _UserInfoTileState();
}

class _UserInfoTileState extends State<UserInfoTile> {
  Mycolours mycolours = Mycolours();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration:
            BoxDecoration(border: Border.all(color: mycolours.lightblack, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Padding(
              padding: const EdgeInsets.fromLTRB(8,0,5,0),
              child: Icon(widget.icon,color: mycolours.lb,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              child: Text(":",style: TextStyle(color: mycolours.lb),),
            ),
            Text(widget.info)],
          ),
        ),
      ),
    );
  }
}
