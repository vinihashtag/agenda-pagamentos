import 'package:agenda_pagamentos/core/models/client_model.dart';
import 'package:agenda_pagamentos/core/services/local_storage/local_storage_service.dart';
import 'package:uuid/uuid.dart';

import 'i_client_repository.dart';

class ClientRepository implements IClientRepository {
  final ILocalStorageService _storageService;

  ClientRepository(this._storageService);

  @override
  Future<List<ClientModel>> getClients() async {
    final response = await _storageService.getStringList('clients') ?? [];
    return response.map((c) => ClientModel.fromJson(c)).toList();
  }

  @override
  Future<ClientModel> saveClient(ClientModel client) async {
    final List<ClientModel> clients = await getClients();

    if (client.id.isEmpty) {
      const Uuid uuid = Uuid();
      client = client.copyWith(id: uuid.v1());
      clients.add(client);
    } else {
      final int index = clients.indexWhere((c) => c.id == client.id);
      clients[index] = client;
    }

    _storageService.setValue<List<String>>('clients', clients.map((c) => c.toJson()).toList());

    return client;
  }

  @override
  Future<void> deleteClient(String id) async {
    final List<ClientModel> clients = await getClients();

    final int index = clients.indexWhere((c) => c.id == id);

    clients.removeAt(index);

    _storageService.setValue<List<String>>('clients', clients.map((c) => c.toJson()).toList());
  }
}
