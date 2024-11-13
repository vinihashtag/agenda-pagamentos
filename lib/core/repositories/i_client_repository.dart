import 'package:agenda_pagamentos/core/models/client_model.dart';

abstract interface class IClientRepository {
  Future<List<ClientModel>> getClients();
  Future<ClientModel> saveClient(ClientModel client);
  Future<void> deleteClient(String id);
}
