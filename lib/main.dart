import 'package:flutter/material.dart';
import 'package:post_app/post_module/view/post_screen.dart';
import 'package:post_app/post_module/viewModel/post_viewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<PostViewModel>(
        create: (context) => PostViewModel(),
        child: const PostScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
