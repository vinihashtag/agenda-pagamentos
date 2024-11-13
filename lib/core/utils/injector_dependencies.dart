import 'package:agenda_pagamentos/core/services/local_storage/local_storage_service.dart';
import 'package:agenda_pagamentos/core/services/local_storage/local_storage_service_impl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/client/client_controller.dart';
import '../../pages/home/home_controller.dart';
import '../repositories/client_repository.dart';
import '../repositories/i_client_repository.dart';

final class InjectorDependencies {
  InjectorDependencies._();
  static Future<void> init() async {
    // * Plugins
    await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);

    // * Services
    Get.lazyPut<ILocalStorageService>(() => LocalStorageService(Get.find()), fenix: true);

    // * Repositories
    Get.lazyPut<IClientRepository>(() => ClientRepository(Get.find()), fenix: true);

    // * Controllers
    Get.lazyPut(() => HomeController(Get.find()));
    Get.create(() => ClientController(Get.find()));
  }
}
