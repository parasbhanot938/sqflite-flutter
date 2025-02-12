import 'dart:convert';

import 'package:flutter_assignment/constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/model/post_data_model.dart';

class PostsRepo {
  static Future<List<PostDataModel>> fetchPostsApi() async {
    try {
      var response = await http.get(Uri.parse(ApiUrl.url));

      if (response.statusCode == 200) {
        List<PostDataModel> data = [];
        var decodedResponse = jsonDecode(response.body.toString());
        decodedResponse.forEach((v) {
          data.add(PostDataModel.fromJson(v));
        });

        return data;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("e $e");
    }
    return [];
  }
}
