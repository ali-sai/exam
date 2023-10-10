import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/add_post.dart';
import '../view/widgets/feed_widget.dart';
import '../view/widgets/progress_overlay.dart';
import '../view/widgets/progress_widget.dart';

import '../controller/controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Controller>();
    OverlayEntry? _overlayEntry;

    void _showOverlay() {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return ProgressOverlay();
        },
      );

      Overlay.of(context)?.insert(_overlayEntry!);
    }

    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                snap: true,
                title: Text('Task'),
                centerTitle: false,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddPost(),
                        ));
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
              SliverList.list(
                children: [
                  if (controller.refreshLoading.value)
                    Center(child: CircularProgressIndicator()),
                  if (controller.addPostController.isPosting.value) ProgressWidget(),
                  ...controller.posts.map((e) {
                    if (e.hasMedia || e.content != null) {
                      return FeedWidget(
                        post: e,
                      );
                    }
                    return Container();
                  }),
                  if (controller.moreLoading.value)
                    Center(child: CircularProgressIndicator())
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
