import 'dart:convert';

import '../model/post.dart';

class PostRequest {
  String content;
  List<Media> media;
  List<String> friendsIds;

  PostRequest({
    required this.content,
    required this.media,
    this.friendsIds = const [],
  });

  String toJson() {
    return jsonEncode({
      'content': content,
      'media': media.map((m) => m.toJson()).toList(),
      'friends_ids': friendsIds,
    });
  }
}



