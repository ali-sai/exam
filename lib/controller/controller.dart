import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import '../controller/add_post_controller.dart';
import '../model/post_request.dart';

import '../model/post.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  AddPostController addPostController = Get.find<AddPostController>();
  RxList<Post> posts = <Post>[].obs;
  int currentPage = 1;
  int lastPage = 1;
  RxBool isLoading = false.obs;
  RxBool refreshLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool moreLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchData(currentPage);
  }

  Future<void> fetchData(int page) async {
    try {
      if (isLoading.value) return; // Do not fetch if already loading

      isLoading.value = true;

      final apiUrl = 'http://api.media-nas.net/api/posts/v1/all?page=$page';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        lastPage = responseData['data']['last_page'] as int;

        final List<dynamic> items = responseData['data']['items'];
        final List<Post> postsList =
            items.map((item) => Post.fromJson(item)).toList() as List<Post>;

        if (page == 1) {
          posts.value = postsList;
        } else {
          posts.addAll(postsList);
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false; // Reset isLoading state
    }
  }

  void _loadMoreData() async {
    if (!isLoading.value && currentPage < lastPage) {
      moreLoading.value = true;
      currentPage++;
      await fetchData(currentPage);
      moreLoading.value = false;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void refresh() async {
    refreshLoading.value = true;
    currentPage = 1;
    await fetchData(currentPage);
    refreshLoading.value = false;
  }

}
