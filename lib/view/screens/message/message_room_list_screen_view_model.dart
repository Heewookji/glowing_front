import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/message_room_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../core/services/firestore/message_room_service.dart';
import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class MessageRoomListScreenViewModel
    extends StreamViewModel<List<MessageRoomModel>> {
  final User auth = getIt<FirebaseAuthService>().user;
  Map<String, List<UserModel>> messageRoomUsers = Map();
  Map<String, UserModel> messageRoomOpponents = Map();
  Map<String, bool> messageRoomUnread = Map();

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  Stream<List<MessageRoomModel>> get stream =>
      getIt<MessageRoomService>().getMessageRoomsAsStreamByUserId(auth.uid);

  @override
  List<MessageRoomModel> transformData(List<MessageRoomModel> rooms) {
    setUsersOpponentsUnread(rooms).then((value) {
      if (isBusy) setBusy(false);
    });
    return super.transformData(rooms);
  }

  Future<void> setUsersOpponentsUnread(List<MessageRoomModel> rooms) async {
    for (final room in rooms) {
      if (!messageRoomOpponents.containsKey(room.id))
        setBusyForObject(room, true);
      messageRoomUsers[room.id] =
          await getIt<UserService>().getUsersByIds(room.userIds);
      _setUnread(room);
      _setOpponent(room);
      setBusyForObject(room, false);
    }
  }

  void _setOpponent(MessageRoomModel room) {
    if (room.isGroup) {
      //group 톡 일경우
    } else {
      for (final user in messageRoomUsers[room.id]) {
        if (user.id != auth.uid) {
          messageRoomOpponents[room.id] = user;
          break;
        }
      }
    }
  }

  void _setUnread(MessageRoomModel room) {
    messageRoomUnread[room.id] =
        room.userInfos[auth.uid].lastViewedAt == null ||
            room.lastMessagedAt
                .toDate()
                .isAfter(room.userInfos[auth.uid].lastViewedAt.toDate());
  }
}
