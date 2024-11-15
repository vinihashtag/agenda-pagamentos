import 'package:agenda_pagamentos/core/extensions/date_extension.dart';
import 'package:agenda_pagamentos/core/extensions/num_extension.dart';
import 'package:agenda_pagamentos/core/extensions/strings_extension.dart';
import 'package:agenda_pagamentos/core/theme/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/components/custom_text_field.dart';
import '../../core/theme/app_typography.dart';
import 'client_controller.dart';

class ClientPage extends GetWidget<ClientController> {
  const ClientPage({super.key});

  void _getRangeDate(BuildContext context) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2999),
      currentDate: DateTime.now(),
      initialDateRange: controller.dateIniController.text.toDateNullable != null &&
              controller.dateEndController.text.toDateNullable != null
          ? DateTimeRange(
              start: controller.dateIniController.text.toDate,
              end: controller.dateEndController.text.toDate,
            )
          : null,
    ).then((range) {
      if (range != null) {
        controller.dateIniController.text = range.start.formatddMMyyyy;

        controller.dateEndController.text = range.end.formatddMMyyyy;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.copyClient();
          if (controller.isEditing) {
            Get.defaultDialog(
                title: 'Confirmação',
                middleText: controller.isNew
                    ? 'Deseja realmente descartar este novo cadastro?'
                    : 'Deseja realmente descartar estas alterações?',
                actions: [
                  TextButton.icon(
                    onPressed: Get.back,
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: const Text('NÃO', style: TextStyle(color: Colors.black54)),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    onPressed: () => Get.close(2),
                    icon: const Icon(Icons.check, color: Colors.green),
                    label: const Text('SIM', style: TextStyle(color: Colors.black54)),
                  )
                ]);
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Detalhes do Cliente')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Name
              CustomTextFormField(
                labelText: 'Nome',
                controller: controller.nameController,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    // * Date Ini
                    Expanded(
                      child: CustomTextFormField(
                        labelText: 'Data Início',
                        controller: controller.dateIniController,
                        textAlign: TextAlign.center,
                        readOnly: true,
                        onTap: () => _getRangeDate(context),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // * Date End
                    Expanded(
                      child: CustomTextFormField(
                        labelText: 'Data Término',
                        controller: controller.dateEndController,
                        textAlign: TextAlign.center,
                        readOnly: true,
                        onTap: () => _getRangeDate(context),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // * Date Avaliable
                  Expanded(
                    child: CustomTextFormField(
                      labelText: 'Data Avaliação',
                      controller: controller.dateAvaliableController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      onTap: () => showDatePicker(
                        context: context,
                        currentDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2999),
                        initialDate: controller.dateAvaliableController.text.toDateNullable,
                        locale: const Locale('pt', 'BR'),
                      ).then((date) {
                        if (date != null) {
                          controller.dateAvaliableController.text = date.formatddMMyyyy;
                        }
                      }),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // * Data Nascimento
                  Expanded(
                    child: CustomTextFormField(
                      labelText: 'Data Nascimento',
                      controller: controller.dateBirthdayController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      onTap: () => showDatePicker(
                        context: context,
                        currentDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDate: controller.dateBirthdayController.text.toDateNullable,
                        locale: const Locale('pt', 'BR'),
                      ).then((date) {
                        if (date != null) {
                          controller.dateBirthdayController.text = date.formatddMMyyyy;
                        }
                      }),
                    ),
                  ),
                ],
              ),

              // * List of payments
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 4),
                child: Text(
                  'Lançamento de pagamentos',
                  style: AppTypography.bodyText1.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Obx(() {
                  return Table(
                    border: TableBorder.all(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(2.5),
                      2: FlexColumnWidth(1.2),
                      3: FlexColumnWidth(0.8),
                    },
                    children: [
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Text(
                              'Data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Theme.of(context).primaryColor,
                            child: const Text(
                              'Valor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Theme.of(context).primaryColor,
                            child: const Text(
                              'Pago',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Text(
                              '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      for (final payment in controller.payments)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                payment.datePayment.formatddMMyyyy,
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                payment.value.formattedMoneyBR,
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AbsorbPointer(
                                child: Checkbox(
                                  value: payment.paid,
                                  onChanged: (bool? value) {},
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () => controller.removePayment(payment),
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[400],
                                )),
                          ],
                        ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.datePaymentController,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              onTap: () => showDatePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2999),
                                initialDate: controller.datePaymentController.text.toDateNullable,
                                locale: const Locale('pt', 'BR'),
                              ).then((date) {
                                if (date != null) {
                                  controller.datePaymentController.text = date.formatddMMyyyy;
                                  controller.valueFocus.requestFocus();
                                }
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              focusNode: controller.valueFocus,
                              controller: controller.valuePaymentController,
                              keyboardType: const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(moeda: true),
                              ],
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Checkbox(
                                value: controller.paid.value,
                                onChanged: (bool? value) => controller.paid.toggle(),
                              ),
                            ),
                          ),
                          ListenableBuilder(
                              listenable: Listenable.merge([
                                controller.datePaymentController,
                                controller.valuePaymentController,
                              ]),
                              builder: (context, child) {
                                final bool isValid = controller.datePaymentController.text.trim().isNotEmpty &&
                                    controller.valuePaymentController.text.trim().isNotEmpty;
                                return IconButton(
                                    onPressed: !isValid ? null : controller.addPayment,
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: isValid ? Colors.green : Colors.grey[300],
                                    ));
                              }),
                        ],
                      ),
                    ],
                  );
                }),
              ),

              // * Observation
              CustomTextFormField(
                labelText: 'Observação',
                maxLines: 3,
                controller: controller.observationController,
                textInputAction: TextInputAction.newline,
              ),

              // * CheckButton
              Obx(
                () => ListTile(
                  horizontalTitleGap: 4,
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  trailing: Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: controller.active.value,
                      onChanged: (v) => controller.onClickDisabledCheck(v),
                    ),
                  ),
                  title: const Text(
                    'Cliente Ativo',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // * Buttons
              ListenableBuilder(
                  listenable: Listenable.merge([
                    controller.nameController,
                    controller.dateIniController,
                    controller.dateEndController,
                    controller.dateBirthdayController,
                  ]),
                  builder: (_, __) {
                    final bool isValid = controller.nameController.text.trim().isNotEmpty &&
                        controller.dateIniController.text.trim().isNotEmpty &&
                        controller.dateEndController.text.trim().isNotEmpty &&
                        controller.dateBirthdayController.text.trim().toMoneyDB >= 0;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Offstage(
                              offstage: Get.arguments == null,
                              child: ElevatedButton.icon(
                                onPressed: isValid ? controller.deleteClient : null,
                                icon: const Icon(Icons.delete),
                                label: const Text('Deletar'),
                                style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor: AppColors.disabled,
                                  disabledForegroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: isValid ? controller.saveClient : null,
                              icon: const Icon(Icons.save),
                              label: const Text('Salvar'),
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: AppColors.disabled,
                                disabledForegroundColor: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
