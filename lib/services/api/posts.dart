// import 'main.dart' show Api;
// import 'dart:core';
// import '../models/post.model.dart';
// import 'package:flutter/foundation.dart';

// class _PostApi extends Api {
//   _PostApi() : super(baseUrl: '/posts');

//   getPosts() {
//     final Map<String, dynamic> b = {
//       'title': 'foo',
//       'body': 'bar',
//       'userId': 1,
//     };

//     get().then((res) {
//       var posts = PostModel.fromJson<List<PostModel>>(res.body);
//       if (kDebugMode) {
//         print(posts);
//       }
//     }).catchError((e) => print(e));
//   }
// }

// final postApi = _PostApi();
