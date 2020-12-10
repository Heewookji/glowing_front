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
  Map<String, List<UserModel>> messageRoomUsers;
  Map<String, UserModel> messageRoomOpponents;

  @override
  Stream<List<MessageRoomModel>> get stream =>
      getIt<MessageRoomService>().getMessageRoomsAsStreamByUserId(auth.uid);

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  List<MessageRoomModel> transformData(List<MessageRoomModel> rooms) {
    messageRoomUsers = Map();
    messageRoomOpponents = Map();
    getUsers(rooms).then((value) {
      if (isBusy) setBusy(false);
    });
    return super.transformData(rooms);
  }

  Future<void> getUsers(List<MessageRoomModel> rooms) async {
    for (final room in rooms) {
      if (!messageRoomOpponents.containsKey(room.id))
        setBusyForObject(room, true);
      messageRoomUsers[room.id] =
          await getIt<UserService>().getUsersByIds(room.users);
      setOpponent(room);
      setBusyForObject(room, false);
    }
  }

  void setOpponent(MessageRoomModel messageRoom) {
    if (messageRoom.isGroup) {
      //group 톡 일경우
    } else {
      for (final user in messageRoomUsers[messageRoom.id]) {
        if (user.id != auth.uid) {
          messageRoomOpponents[messageRoom.id] = user;
          break;
        }
      }
    }
  }
}
