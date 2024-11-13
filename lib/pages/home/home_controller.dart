import 'package:agenda_pagamentos/core/models/client_model.dart';
import 'package:agenda_pagamentos/core/repositories/i_client_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final IClientRepository _clientRepository;
  HomeController(this._clientRepository);

  // * Observables
  final RxList<ClientModel> _clients = RxList.empty();

  List<ClientModel> get clients => _clients;
  List<ClientModel> get activeClients => _clients.where((c) => c.active).toList();
  List<ClientModel> get inactiveClients => _clients.where((c) => !c.active).toList();
  int get totalActiveClients => activeClients.length;
  int get totalInactiveClients => inactiveClients.length;

  @override
  void onInit() {
    getClients();
    super.onInit();
  }

  Future<void> getClients() async => _clients.value = await _clientRepository.getClients();
}
