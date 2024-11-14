import 'package:agenda_pagamentos/core/extensions/date_extension.dart';
import 'package:agenda_pagamentos/core/extensions/strings_extension.dart';
import 'package:agenda_pagamentos/core/models/client_model.dart';
import 'package:agenda_pagamentos/core/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/repositories/i_client_repository.dart';

class ClientController extends GetxController {
  final IClientRepository _clientRepository;
  ClientController(this._clientRepository);

  // * Variables
  ClientModel _clientModel = ClientModel.empty();
  ClientModel? _clientModelInitial = ClientModel.empty();
  bool get isEditing => _clientModel != _clientModelInitial;

  // * Observables
  final RxList<PaymentModel> payments = RxList<PaymentModel>();
  final RxBool paid = RxBool(false);
  final RxBool active = RxBool(true);

  // * TextEditControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateIniController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TextEditingController dateAvaliableController = TextEditingController();
  final TextEditingController dateBirthdayController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  final TextEditingController datePaymentController = TextEditingController();
  final TextEditingController valuePaymentController = TextEditingController();

  // * FocusNode
  final FocusNode valueFocus = FocusNode();

  @override
  void onInit() {
    if (Get.arguments != null) {
      _clientModel = Get.arguments;
      _clientModelInitial = Get.arguments;
      nameController.text = _clientModel.name;
      dateIniController.text = _clientModel.dateIni.formatddMMyyyy;
      dateEndController.text = _clientModel.dateEnd.formatddMMyyyy;
      dateAvaliableController.text = _clientModel.dateAvaliable.formatddMMyyyy;
      dateBirthdayController.text = _clientModel.dateBirthday?.formatddMMyyyy ?? '';
      observationController.text = _clientModel.observation;
      payments.addAll(List.from(_clientModel.datesPayment));
      active.value = _clientModel.active;
    }
    super.onInit();
  }

  Future<void> saveClient() async {
    final bool isNewClient = _clientModel.id.trim().isEmpty;

    _clientModel = await _clientRepository.saveClient(_clientModel.copyWith(
      name: nameController.text.trim(),
      dateIni: dateIniController.text.toDate,
      dateEnd: dateEndController.text.toDate,
      dateAvaliable: dateAvaliableController.text.toDate,
      dateBirthday: dateBirthdayController.text.toDateNullable,
      observation: observationController.text.trim(),
      active: active.value,
    ));

    Get.back(result: _clientModel);

    Get.snackbar(
      'Sucesso',
      isNewClient ? 'Cliente adicionado com sucesso' : 'Cliente atualizado com sucesso!',
      colorText: Colors.white,
      backgroundColor: Colors.green,
      isDismissible: true,
      margin: const EdgeInsets.all(12),
      animationDuration: Durations.long3,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> deleteClient() async {
    if (_clientModel.id.trim().isEmpty) return;

    final isConfirmed =
        await Get.defaultDialog(title: 'Confirmação', middleText: 'Deseja realmente remover este cliente?', actions: [
      TextButton.icon(
        onPressed: () => Get.back(result: false),
        icon: const Icon(Icons.close, color: Colors.red),
        label: const Text('NÃO', style: TextStyle(color: Colors.black54)),
      ),
      const SizedBox(width: 16),
      TextButton.icon(
        onPressed: () => Get.back(result: true),
        icon: const Icon(Icons.check, color: Colors.green),
        label: const Text('SIM', style: TextStyle(color: Colors.black54)),
      )
    ]);

    if (!isConfirmed) return;

    await _clientRepository.deleteClient(_clientModel.id);

    Get.back(result: _clientModel);

    Get.snackbar(
      'Sucesso',
      'Cliente removido com sucesso!',
      colorText: Colors.white,
      backgroundColor: Colors.green,
      isDismissible: true,
      margin: const EdgeInsets.all(12),
      animationDuration: Durations.long3,
      duration: const Duration(seconds: 2),
    );
  }

  void addPayment() {
    final payment = PaymentModel(
      datePayment: datePaymentController.text.toDate,
      value: valuePaymentController.text.toMoneyDB,
      paid: paid.value,
    );
    payments.add(payment);
    payments.sort((a, b) => a.datePayment.compareTo(b.datePayment));
    _clientModel = _clientModel.copyWith(datesPayment: [..._clientModel.datesPayment, payment]);
    _clientModel.datesPayment.sort((a, b) => a.datePayment.compareTo(b.datePayment));
    datePaymentController.clear();
    valuePaymentController.clear();
    paid.value = false;
  }

  void removePayment(PaymentModel model) {
    _clientModel.datesPayment.remove(model);
    _clientModel.datesPayment.sort((a, b) => a.datePayment.compareTo(b.datePayment));
    payments.remove(model);
    payments.sort((a, b) => a.datePayment.compareTo(b.datePayment));
  }

  void onClickDisabledCheck(bool value) {
    _clientModel = _clientModel.copyWith(active: value);
    active.value = value;
  }

  @override
  void onClose() {
    nameController.dispose();
    dateIniController.dispose();
    dateEndController.dispose();
    dateAvaliableController.dispose();
    dateBirthdayController.dispose();
    observationController.dispose();
    datePaymentController.dispose();
    valuePaymentController.dispose();
    valueFocus.dispose();
    super.onClose();
  }
}
