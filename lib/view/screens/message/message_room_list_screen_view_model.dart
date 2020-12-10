import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/message_room_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/auth/firebase_auth_service.dart';
import '../../../core/services/firestore/message_room_service.dart';
import '../../../core/services/firestore/user_service.dart';
import '../../../locator.dart';

class MessageRoomListScreenViewModel
    extends StreamViewModel<List<DocumentReference>> {
  final User auth = getIt<FirebaseAuthService>().user;
  List<MessageRoomModel> messageRooms;
  Map<String, List<UserModel>> messageRoomUsers = Map();
  Map<String, UserModel> messageRoomOpponents = Map();

  @override
  Stream<List<DocumentReference>> get stream =>
      getIt<UserService>().getUserMessageRoomRefsAsStreamById(auth.uid);

  @override
  void initialise() {
    //초기 로딩
    setBusy(true);
    super.initialise();
  }

  @override
  List<DocumentReference> transformData(List<DocumentReference> roomRefs) {
    getMessageRooms(roomRefs);
    return super.transformData(roomRefs);
  }

  void getMessageRooms(List<DocumentReference> roomRefs) async {
    List<MessageRoomModel> rooms = List();
    for (final roomRef in roomRefs) {
      final room =
          await getIt<MessageRoomService>().getMessageRoomByRef(roomRef);
      rooms.add(room);
      await getUsers(room);
    }
    messageRooms = rooms;
    setBusy(false);
  }

  Future<void> getUsers(MessageRoomModel messageRoom) async {
    messageRoomUsers[messageRoom.id] =
        await getIt<UserService>().getUsersByRefs(messageRoom.users);
    setOpponent(messageRoom);
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
