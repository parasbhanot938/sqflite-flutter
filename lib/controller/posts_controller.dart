import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/data/sqflite_database.dart';
import 'package:flutter_assignment/model/post_data_model.dart';
import 'package:flutter_assignment/repo/posts_repo.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  RxList<PostDataModel> posts = <PostDataModel>[].obs;
  RxBool loading = false.obs;
  final sqfliteDatabase = SqfliteDatabase.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPostsFromApi();
  }

/*----------------------------------Fetching data from api-------------------------*/

  fetchPostsFromApi() async {
    loading(true);
    await PostsRepo.fetchPostsApi().then(
      (value) {
        loading(false);

        if (value != null) {
          for (var post in value) {
            addPost(post.title ?? "", post.body ?? "", post.userId ?? 0,
                post.id ?? 0);
          }

          loadPosts();
        }
      },
    );
  }

/*----------------------------------loading posts from sqflite db-------------------------*/
  Future<void> loadPosts() async {
    posts.value = await sqfliteDatabase.getAllPosts();
    posts.refresh();
    debugPrint("data fetched from db $posts");
  }

  /*----------------------------------Adding posts into db-------------------------*/

  Future<void> addPost(String title, String body, int userId, int id) async {
    await sqfliteDatabase.insertPost(
        PostDataModel(title: title, body: body, id: id, userId: userId));
  }
}
