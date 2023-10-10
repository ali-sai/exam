import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Post {
    @HiveField(1)
    final int? id;
    @HiveField(2)
    final int? userId;
    @HiveField(3)
    final dynamic parentId;
    @HiveField(4)
    final String? modelType;
    @HiveField(5)
    final int? modelId;
    @HiveField(6)
    final String? content;
    @HiveField(7)
    final int? index;
    @HiveField(8)
    final int? status;
    @HiveField(9)
    final int? type;
    @HiveField(10)
    final DateTime createdAt;
    @HiveField(11)
    final DateTime updatedAt;
    @HiveField(12)
    final int? interactionsCount;
    @HiveField(13)
    final InteractionsCountTypes interactionsCountTypes;
    @HiveField(14)
    final int? commentsCount;
    @HiveField(15)
    final int? sharesCount;
    @HiveField(16)
    final int? tagsCount;
    @HiveField(17)
    final bool sharingPost;
    @HiveField(18)
    final bool hasMedia;
    @HiveField(19)
    final bool? saved;
    @HiveField(20)
    final bool? taged;
    @HiveField(21)
    final Model model;
    @HiveField(22)
    final List<Media>? media;
    @HiveField(23)
    final List<dynamic> tags;
    @HiveField(24)
    final dynamic interacted;
    @HiveField(25)
    final dynamic parent;

    Post({
        required this.id,
        required this.userId,
        required this.parentId,
        required this.modelType,
        required this.modelId,
        required this.content,
        required this.index,
        required this.status,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
        required this.interactionsCount,
        required this.interactionsCountTypes,
        required this.commentsCount,
        required this.sharesCount,
        required this.tagsCount,
        required this.sharingPost,
        required this.hasMedia,
        required this.saved,
        required this.taged,
        required this.model,
        required this.media,
        required this.tags,
        required this.interacted,
        required this.parent,
    });
factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      parentId: json['parent_id'],
      modelType: json['model_type'] ,
      modelId: json['model_id'] as int?,
      content: json['content'] ,
      index: json['index'] as int?,
      status: json['status'] as int?,
      type: json['type'] as int?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      interactionsCount: json['interactions_count'] as int?,
      interactionsCountTypes: InteractionsCountTypes.fromJson(json['interactions_count_types']),
      commentsCount: json['comments_count'] as int?,
      sharesCount: json['shares_count'] as int?,
      tagsCount: json['tags_count'] as int?,
      sharingPost: json['sharing_post'] as bool,
      hasMedia: json['has_media'] as bool,
      saved: json['saved'] as bool?,
      taged: json['taged'] as bool?,
      model: Model.fromJson(json['model']),
      media: json['media'].isNotEmpty? List<Media>.from(json['media'].map((e)=>Media.fromJson(e))):null,
      tags: List<dynamic>.from(json['tags']),
      interacted: json['interacted'],
      parent: json['parent'],
    );
  }

}

@HiveType(typeId: 2)
class InteractionsCountTypes {
    @HiveField(1)
    final int? like;
    @HiveField(2)
    final int? love;
    @HiveField(3)
    final int? care;
    @HiveField(4)
    final int? haha;
    @HiveField(5)
    final int? wow;
    @HiveField(6)
    final int? sad;
    @HiveField(7)
    final int? angry;

    InteractionsCountTypes({
        required this.like,
        required this.love,
        required this.care,
        required this.haha,
        required this.wow,
        required this.sad,
        required this.angry,
    });
factory InteractionsCountTypes.fromJson(Map<String, dynamic> json) {
    return InteractionsCountTypes(
      like: json['like'] as int?,
      love: json['love'] as int?,
      care: json['care'] as int?,
      haha: json['haha'] as int?,
      wow: json['wow'] as int?,
      sad: json['sad'] as int?,
      angry: json['angry'] as int?,
    );
  }

}

@HiveType(typeId: 3)
class Model {
    @HiveField(1)
    final int? id;
    @HiveField(2)
    final int? userId;
    @HiveField(3)
    final String? sn;
    @HiveField(4)
    final String? firstName;
    @HiveField(5)
    final dynamic middleName;
    @HiveField(6)
    final String? lastName;
    @HiveField(7)
    final int? gender;
    @HiveField(8)
    final bool isBlocked;
    @HiveField(9)
    final dynamic blockedUntil;
    @HiveField(10)
    final DateTime createdAt;
    @HiveField(11)
    final DateTime updatedAt;
    @HiveField(12)
    final DateTime? lastSeen;
    @HiveField(13)
    final String? name;
    @HiveField(14)
    final int? isFriend;
    @HiveField(15)
    final int? mutualfriendsCount;
    @HiveField(16)
    final bool? screenBlock;
    @HiveField(17)
    final bool hasMediaProfile;
    @HiveField(18)
    final bool hasMediaCover;
    @HiveField(19)
    final List<dynamic> media;

    Model({
        required this.id,
        required this.userId,
        required this.sn,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.gender,
        required this.isBlocked,
        required this.blockedUntil,
        required this.createdAt,
        required this.updatedAt,
        required this.lastSeen,
        required this.name,
        required this.isFriend,
        required this.mutualfriendsCount,
        required this.screenBlock,
        required this.hasMediaProfile,
        required this.hasMediaCover,
        required this.media,
    });
factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      sn: json['sn'] ,
      firstName: json['first_name'] ,
      middleName: json['middle_name'],
      lastName: json['last_name'] ,
      gender: json['gender'] as int?,
      isBlocked: json['isBlocked'] as bool,
      blockedUntil: json['blocked_until'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lastSeen: json['last_seen'] !=null? DateTime.parse(json['last_seen']):null,
      name: json['name'] ,
      isFriend: json['is_friend'] as int?,
      mutualfriendsCount: json['mutualfriends_count'] as int?,
      screenBlock: json['screen_block'] as bool?,
      hasMediaProfile: json['has_media_profile'] as bool,
      hasMediaCover: json['has_media_cover'] as bool,
      media: List<dynamic>.from(json['media']),
    );
  }
}
@HiveType(typeId: 4)
class Media {
    @HiveField(1)
    final int? id;
    @HiveField(2)
    final String? modelType;
    @HiveField(3)
    final int? modelId;
    @HiveField(4)
    final String? srcUrl;
    @HiveField(5)
    final dynamic srcIcon;
    @HiveField(6)
    final dynamic srcThum;
    @HiveField(7)
    final String? collectionName;
    @HiveField(8)
    final String? fullPath;
    @HiveField(9)
    final String? mediaType;
    @HiveField(10)
    final String? mimeType;
    @HiveField(11)
    final int? size;
    @HiveField(12)
    final int? width;
    @HiveField(13)
    final int? height;
    @HiveField(14)
    final String? createdAt;
    @HiveField(15)
    final String? updatedAt;
    @HiveField(16)
    final bool? saved;

    Media({
         this.id,
         this.modelType,
         this.modelId,
         this.srcUrl,
         this.srcIcon,
         this.srcThum,
         this.collectionName,
         this.fullPath,
         this.mediaType,
         this.mimeType,
         this.size,
         this.width,
         this.height,
         this.createdAt,
         this.updatedAt,
         this.saved,
    });
factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] as int?,
      modelType: json['model_type'] as String?,
      modelId: json['model_id'] as int?,
      srcUrl: json['src_url'] as String?,
      srcIcon: json['src_icon'],
      srcThum: json['src_thum'],
      collectionName: json['collection_name'] as String?,
      fullPath: json['full_path'] as String?,
      mediaType: json['media_type'] as String?,
      mimeType: json['mimeType'] as String?,
      size: json['size'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      saved: json['saved'] as bool?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'src_url': srcUrl,
      'src_thum': srcThum,
      'src_icon': srcIcon,
      'media_type': mediaType,
      'mime_type': mimeType,
      'fullPath': fullPath,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'size': size,
    };
  }
}
