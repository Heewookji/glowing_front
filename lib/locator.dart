import 'package:get_it/get_it.dart';
import 'package:glowing_front/core/services/firestore_api.dart';
import 'core/viewmodels/message_crud_model.dart';
import 'core/viewmodels/user_crud_model.dart';


GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => MessageCRUDModel(FirestoreApi('messages')));
  getIt.registerLazySingleton(() => UserCRUDModel(FirestoreApi('users')));
}