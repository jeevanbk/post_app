import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:post_app/post_module/model/comments_model.dart';
import 'package:post_app/util/service/api_service.dart';

import '../model/post_model.dart';

class PostViewModel extends ChangeNotifier {
  List<PostModel>? postsList;
  List<CommentsModel>? commentsList;
  ApiService service = ApiService();

  Future<void> getPosts() async {
    final model = await service.getApi(url: '/posts');
    if (model != null) {
      Iterable iterable = model as Iterable;
      postsList = iterable.map((e) => PostModel.fromJson(e)).toList();
      log('post count :: ${postsList?.length}');
    } else {
      postsList = [];
    }
    notifyListeners();
  }

  Future<void> getCommentsOfPost({required int postId}) async {
    commentsList=null;
    final model = await service.getApi(url: '/posts/$postId/comments');
    if (model != null) {
      Iterable iterable = model as Iterable;
      commentsList = iterable.map((e) => CommentsModel.fromJson(e)).toList();
    } else {
      commentsList = [];
    }
    notifyListeners();
  }

}
