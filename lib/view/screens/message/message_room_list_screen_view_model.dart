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
    for (final room in rooms) getUsers(room);
    return super.transformData(rooms);
  }

  Future<void> getUsers(MessageRoomModel messageRoom) async {
    if (!messageRoomOpponents.containsKey(messageRoom.id))
      setBusyForObject(messageRoom, true);
    messageRoomUsers[messageRoom.id] =
        await getIt<UserService>().getUsersByRefs(messageRoom.users);
    setOpponent(messageRoom);
    setBusy(false);
    setBusyForObject(messageRoom, false);
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
