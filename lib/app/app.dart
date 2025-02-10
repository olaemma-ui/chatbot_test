import 'package:get_it/get_it.dart';
import 'package:chatbot_test/core/service/localstorage_service/local_storage_impl.dart';
import 'package:chatbot_test/core/service/localstorage_service/local_storage_service.dart';
import 'package:chatbot_test/core/service/network_service/network_service.dart';
import 'package:chatbot_test/core/service/network_service/network_service_impl.dart';

final locator = GetIt.I;
// Logger logger = Logger();

setupLocator() async {
  await LocalStorageService.init();

  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(),
  );

  // Ensure NetworkServiceImpl has the correct constructor and dependencies
  locator.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(),
  );
}
