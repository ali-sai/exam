import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../view/widgets/video_widget.dart';

import '../../helper/image.dart';
import '../../model/post.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({
    required this.post,
    super.key,
  });
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn4.vectorstock.com/i/1000x1000/80/88/person-gray-photo-placeholder-man-vector-22808088.jpg'),
              ),
              Container(
                width: 5,
              ),
              Text(
                post.model.name!,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          ),
          if (post.media != null)
            AspectRatio(
              aspectRatio: post.media![0].height! / post.media![0].width!,
              child: Swiper(
                itemCount: post.media!.length,
                autoplay: false,
                loop: false,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: post.media![index].mediaType == 'Image'? NetworkImageChecker(
                      imageUrl: post.media![index].srcUrl!,
                    ):VideoWidget(url: post.media![index].srcUrl!,),
                  );
                }
              ),
            ),
          Container(
            height: 10,
          ),
          if (post.content != null)
            Align(
                alignment: post.media == null
                    ? Alignment.bottomLeft
                    : Alignment.bottomLeft,
                child: Text(
                  post.content!,
                  style: post.media == null
                      ? TextStyle(fontSize: 25, fontWeight: FontWeight.w600)
                      : TextStyle(
                          fontSize: 17, overflow: TextOverflow.ellipsis),
                )),
                Container(height: 10,),
       
          Row(
            children: [
              Icon(
                post.interacted != null
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: post.interacted != null ? Colors.red : null,
              ),
              Container(
                width: 5,
              ),
              Icon(Icons.mode_comment_outlined),
            ],
          ),
          Container(
            height: 4,
          ),
             Row(
            children: [
              Text(
                '${post.interactionsCount} interactions',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
