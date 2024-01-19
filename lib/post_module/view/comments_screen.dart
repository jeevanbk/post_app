import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/post_module/model/post_model.dart';
import 'package:provider/provider.dart';

import '../../util/util_functions.dart';
import '../viewModel/post_viewModel.dart';
import '../widgets/helper_widgets.dart';

class CommentsScreen extends StatefulWidget {
  final PostModel postModel;
  const CommentsScreen({super.key,required this.postModel});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late PostViewModel postViewModel;
  var _mainHeight;
  var _mainWidth;

  @override
  void initState() {
    super.initState();
    postViewModel = Provider.of<PostViewModel>(context, listen: false);
    postViewModel.getCommentsOfPost(postId: widget.postModel.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    _mainHeight = getScreenSize(context).height;
    _mainWidth = getScreenSize(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Consumer<PostViewModel>(
        builder: (context, value, child) {
          return Container(
            height: _mainHeight,
            width: _mainWidth,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: _mainHeight*0.02),
            child: value.commentsList == null
                ? const Center(child: CircularProgressIndicator())
                : value.commentsList != null && value.commentsList!.isNotEmpty
                ? Container(
              height: _mainHeight * 0.4,
              padding: const EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.title?.capitalize() ?? '',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.01,
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        height: _mainHeight * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.01,
                    ),
                    getActionButtons(onTapComment: () {},showCommentIcon: false),
                    SizedBox(
                      height: _mainHeight * 0.01,
                    ),
                    Text(
                      widget.postModel.body?.capitalize().replaceAll("\n", " ") ?? '',
                      //overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    Text('Comments',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    Divider(),
                    getCommentsView(value),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),

                  ],
                ),
              ),
            ): const Text('No Comments Found...'),
          );
        },

      ),
    );
  }

  Widget getCommentsView(PostViewModel postViewModel){
    return ListView.separated(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var data = postViewModel.commentsList![index];
          return Container(

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.arrow_down_square_fill),
                SizedBox(width: _mainWidth*0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.email ?? '',style: TextStyle(fontSize: 18,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
                    Container(
                        width: _mainWidth*0.83,
                        child: Text(data.body?.capitalize().replaceAll("\n", " ") ?? '',style:TextStyle(fontSize: 14,color: Colors.black45,fontWeight: FontWeight.w500) ,)),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10,),
        itemCount: postViewModel.commentsList?.length ?? 0);
  }
}
