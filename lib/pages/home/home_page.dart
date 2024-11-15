import 'package:agenda_pagamentos/core/extensions/date_extension.dart';
import 'package:agenda_pagamentos/core/models/client_model.dart';
import 'package:agenda_pagamentos/pages/client/client_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Clientes',
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Obx(
          () {
            return Column(
              children: [
                TabBar(tabs: [
                  Tab(text: 'Ativos (${controller.totalActiveClients})'),
                  Tab(text: 'Inativos (${controller.totalInactiveClients})')
                ]),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // * Active clients
                      Visibility(
                        visible: controller.activeClients.isNotEmpty,
                        replacement: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Você não poassui nenhum cliente ativo registrado',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        child: ListView.separated(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemCount: controller.totalActiveClients,
                          itemBuilder: (context, index) {
                            final ClientModel client = controller.activeClients[index];
                            return _CardClientWidget(client: client, controller: controller);
                          },
                        ),
                      ),

                      // * Inatived Clients
                      Visibility(
                        visible: controller.inactiveClients.isNotEmpty,
                        replacement: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Você não poassui nenhum cliente inativo registrado',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        child: ListView.separated(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemCount: controller.totalInactiveClients,
                          itemBuilder: (context, index) {
                            final ClientModel client = controller.inactiveClients[index];
                            return _CardClientWidget(client: client, controller: controller);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Get.to(() => const ClientPage());
          if (result != null) controller.getClients();
        },
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }
}

class _CardClientWidget extends StatelessWidget {
  const _CardClientWidget({
    required this.client,
    required this.controller,
  });

  final ClientModel client;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: client.active ? Colors.greenAccent.shade100 : Colors.grey.shade100,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(left: 12, right: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () async {
          final result = await Get.to(() => const ClientPage(), arguments: client);
          if (result != null) controller.getClients();
        },
        title: Text(
          client.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Início'),
                    Text(client.dateIni.formatddMMyyyy),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Final'),
                    Text(client.dateEnd.formatddMMyyyy),
                  ],
                ),
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
