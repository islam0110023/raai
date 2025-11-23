

import 'package:get_it/get_it.dart';
import 'package:raai/core/services/internet_services.dart';

final getIt = GetIt.instance;
void setUpServices() {
  getIt.registerLazySingleton<InternetService>(() => InternetService());

  //Data Source


  //Repo


  //UseCase

}
