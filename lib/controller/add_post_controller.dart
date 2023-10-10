import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart' as http;
import '../controller/controller.dart';

import '../model/post.dart';
import '../model/post_request.dart';

class AddPostController extends GetxController {
  RxBool isPosting = false.obs;
  RxDouble postingProgress = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    _getImages().then((value) {
    });
  }

  RxList<File?> imagesList = <File?>[].obs;
  RxList<File> media = <File>[].obs;


  Future<void> _getImages() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.hasAccess) {
      // Handle permission denied.
      return;
    }

    final result = await PhotoManager.getAssetPathList(onlyAll: true);
    if (result.isEmpty) {
      // Handle no photos found.
      return;
    }

    final allImages = result[0];
    final images = await allImages.getAssetListPaged(page: 0, size: 40);


    List _inImage = images.map((e) async {
      File? file = await e.file;
      return file;
    }).toList();
    for (var image in _inImage) {
      imagesList!.add(await image);
    }
  }

  addMedia(File file) {
    if (media.contains(file)) {
      media.remove(file);
    } else {
      media.add(file);
    }
    update();
  }
  bool checkIsAdded(File file){
    return media.value.contains(file);
  }

Future<void> uploadImages(String content) async {
  isPosting.value = true;
  final _storageRef = FirebaseStorage.instance.ref();
  final uploadTasks = <UploadTask>[];

for (final file in media) {
  final _mountainsRef =
      _storageRef.child("image${DateTime.now()}.${file!.path.split('.').last}");
  final uploadTask = _mountainsRef.putFile(file!);
  uploadTasks.add(uploadTask);

  // Use StreamTransformer to handle progress updates
  final transformer = StreamTransformer<TaskSnapshot, double>.fromHandlers(
    handleData: (snapshot, sink) {
      final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 0.8;
      sink.add(progress);
    },
  );

  uploadTask.snapshotEvents
      .transform(transformer)
      .listen((progress) {
        // Calculate total progress across all tasks
        final totalProgress = uploadTasks
            .map((task) => task.snapshot.bytesTransferred / task.snapshot.totalBytes)
            .reduce((a, b) => a + b) *
            0.8;

        // Update the overall progress
        postingProgress.value = totalProgress;
      });
}

await Future.wait(uploadTasks);

  List<Media> _media = [];
  for (final task in uploadTasks) {
    if (task.snapshot.state == TaskState.success) {
      final downloadUrl = await task.snapshot.ref.getDownloadURL();
      final mimeData = await lookupMimeType( task.snapshot.ref.fullPath);

      // Check if mimeData is not null before assigning
      final mimeType = mimeData ?? 'application/octet-stream';

      // Determine media type based on the MIME type
      final mediaType = mimeType.startsWith('image/') ? 'Image' : 'Video';

      // Create a Media object directly from the download URL
      _media.add(Media(
        srcUrl: downloadUrl,
        mediaType: mediaType,
        mimeType: mimeType,
        fullPath: task.snapshot.ref.fullPath,
        width: 3434,
        height: 3434,
        size: task.snapshot.totalBytes,
      ));
    }
  }

  _sharePost(PostRequest(content: content, media: _media));
  isPosting.value = false;
}

  _sharePost(PostRequest postRequest) async {
print(postRequest.media[0].mediaType);

    try {
      http.Response _res = await http.post(
          Uri.parse('http://api.media-nas.net/api/posts/v1/add'),
          body: postRequest.toJson(),
          headers: {
            "Authorization":
                "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpLm1lZGlhLW5hcy5uZXQvYXBpL3VzZXJzL3YxL2xvZ2luIiwiaWF0IjoxNjk1MTAzMjc1LCJleHAiOjE2OTc1MTUyNzUsIm5iZiI6MTY5NTEwMzI3NSwianRpIjoiMEFlUHJYbHdhYzVldFRucCIsInN1YiI6Ijg2MCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.3MArC7a18eeOQ0IRXjpXjD8DvCiYTtI7CmRa0CzmM08",
                'Accept':'application/json',
                "Content-Type":'application/json'


          });
              media.clear();
    postingProgress.value = 0.0;
    isPosting.value = false;
    Get.find<Controller>().refresh();
    } catch (e) {
   
    }
  }

  
}
