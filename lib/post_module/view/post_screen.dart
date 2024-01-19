import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/post_module/view/comments_screen.dart';
import 'package:post_app/post_module/viewModel/post_viewModel.dart';
import 'package:post_app/util/util_functions.dart';
import 'package:provider/provider.dart';

import '../widgets/helper_widgets.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late PostViewModel postViewModel;
  var _mainHeight;
  var _mainWidth;

  @override
  void initState() {
    super.initState();
    postViewModel = Provider.of<PostViewModel>(context, listen: false);
    postViewModel.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    _mainHeight = getScreenSize(context).height;
    _mainWidth = getScreenSize(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Consumer<PostViewModel>(
        builder: (context, value, child) {
          return Container(
            height: _mainHeight,
            width: _mainWidth,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: _mainHeight * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                value.postsList == null
                    ? const CircularProgressIndicator()
                    : value.postsList != null && value.postsList!.isNotEmpty
                        ? SizedBox(
                            height: _mainHeight * 0.83,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var data = value.postsList![index];
                                  return Container(
                                    height: _mainHeight * 0.4,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title?.capitalize() ?? '',
                                          style: const TextStyle(
                                              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: _mainHeight * 0.01,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ChangeNotifierProvider.value(
                                                value: value,
                                                builder: (context, child) => CommentsScreen(
                                                  postModel: data,
                                                ),
                                              ),
                                            ));
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
                                        getActionButtons(onTapComment:  () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ChangeNotifierProvider.value(
                                              value: value,
                                              builder: (context, child) => CommentsScreen(
                                                postModel: data,
                                              ),
                                            ),
                                          ));
                                        },showCommentIcon: true),
                                        SizedBox(
                                          height: _mainHeight * 0.01,
                                        ),
                                        Text(
                                          data.body?.trim().capitalize().replaceAll("\n", " ") ?? '',
                                          maxLines: 2,
                                          //overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 14,overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const Divider(),
                                itemCount: value.postsList?.length ?? 0))
                        : const Text('No Post Found...')
              ],
            ),
          );
        },
      ),
    );
  }
}
