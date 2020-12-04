import 'package:get_it/get_it.dart';
import 'core/services/auth/firebase_auth_service.dart';
import 'core/services/firestore/message_room_service.dart';
import 'core/services/firestore/user_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => MessageRoomService());
  getIt.registerLazySingleton(() => UserService());
}
