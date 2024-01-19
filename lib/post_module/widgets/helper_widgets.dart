import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/util/util_functions.dart';

Widget getActionButtons({required Function onTapComment,required bool showCommentIcon}) {
  return Row(
    children:  [
      InkWell(
        onTap: (){
          showToast("Upcoming Feature For Like");
        },
        child: Icon(
          CupertinoIcons.heart,
          color: Colors.red,
          size: 24,
        ),
      ),
      SizedBox(
        width:  showCommentIcon ? 25:10,
      ),
      showCommentIcon ? InkWell(
        onTap: ()=>onTapComment(),
        child: Icon(
          Icons.message,
          color: Colors.red,
          size: 24,
        ),
      ):SizedBox.shrink(),
      SizedBox(
        width: showCommentIcon ? 25:0,
      ),
      InkWell(
        onTap: (){
          showToast("Upcoming feature For Share");
        },
        child: Icon(
          Icons.send,
          color: Colors.red,
          size: 24,
        ),
      ),
    ],
  );
}