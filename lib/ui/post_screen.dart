import 'package:flutter/material.dart';
import 'package:flutter_assignment/controller/posts_controller.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  var postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _appBar(),
          body: _posts(),
        ),
        Obx(() => postsController.loading.value==true?const Center(child: CircularProgressIndicator(),):const SizedBox())
      ],
    );
  }

  /*-----------------------------------App Bar---------------------------------*/

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Posts",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
    );
  }
  /*-----------------------------------Posts---------------------------------*/

  Widget _posts() {
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
            titleAlignment:ListTileTitleAlignment.top ,

                title: Text(postsController.posts[index].title ?? "",style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                leading: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("${postsController.posts[index].id})." ?? "",style: const TextStyle(fontSize: 13.0,fontWeight: FontWeight.w500))),
                subtitle: Text(postsController.posts[index].body ?? "",style: const TextStyle(fontSize: 13.0,fontWeight: FontWeight.normal,)),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
          itemCount: postsController.posts.length ?? 0),
    );
  }
}
