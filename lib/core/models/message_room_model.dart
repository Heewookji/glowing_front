import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:glowing_front/core/models/model.dart';
import 'package:glowing_front/core/utils/convert_helper.dart';

class MessageRoomUserInfoModel implements Model {
  final String userId;
  final Timestamp lastViewedAt;

  MessageRoomUserInfoModel({
    this.userId,
    @required this.lastViewedAt,
  });

  factory MessageRoomUserInfoModel.fromMap(Map json, String id) {
    return MessageRoomUserInfoModel(
      userId: id ?? '',
      lastViewedAt: json['lastViewedAt'] ?? null,
    );
  }
  toJson() {
    return {
      'lastViewedAt': lastViewedAt,
    };
  }
}

class MessageRoomModel implements Model {
  final String id;
  final bool isGroup;
  final Timestamp lastMessagedAt;
  final String lastMessagedText;
  final List<String> userIds;
  final Map<String, MessageRoomUserInfoModel> userInfos;

  MessageRoomModel({
    this.id,
    @required this.isGroup,
    @required this.lastMessagedAt,
    @required this.lastMessagedText,
    @required this.userIds,
    @required this.userInfos,
  });

  factory MessageRoomModel.fromMap(Map json, String id) {
    return MessageRoomModel(
      id: id ?? '',
      isGroup: json['isGroup'] ?? false,
      lastMessagedAt:
          json['lastMessagedAt'] ?? Timestamp.fromDate(DateTime(1900)),
      lastMessagedText: json['lastMessagedText'] ?? '',
      userIds: json['userIds'] == null
          ? List()
          : ConvertHelper.mapToStringList(json['userIds']),
      userInfos: json['userInfos'] == null
          ? Map()
          : ConvertHelper.mapToIdModelMap<MessageRoomUserInfoModel>(
              json['userInfos'],
            ),
    );
  }

  toJson() {
    return {
      'isGroup': isGroup,
      'userIds': userIds,
      'userInfos':
          ConvertHelper.idModelMapToJson<MessageRoomUserInfoModel>(userInfos),
      'lastMessagedAt': lastMessagedAt,
      'lastMessagedText': lastMessagedText,
    };
  }
}
