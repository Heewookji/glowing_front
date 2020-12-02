import 'package:get_it/get_it.dart';
import 'core/viewmodels/message_crud_model.dart';
import 'core/viewmodels/user_crud_model.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => MessageCRUDModel());
  locator.registerLazySingleton(() => UserCRUDModel());
}