import 'package:get_it/get_it.dart';
import 'package:lekki_proj_demo/repositories/app_repository.dart';
import 'package:lekki_proj_demo/repositories/property_repository.dart';


final getIt = GetIt.instance;

Future<void> getItSetup() async {
  // repositories
  getIt.registerLazySingleton(() => AppRepository());
  getIt.registerLazySingleton(() => PropertyRepository());
}
