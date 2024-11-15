import 'dart:convert';

import 'package:agenda_pagamentos/core/extensions/date_extension.dart';
import 'package:flutter/foundation.dart';

import 'payment_model.dart';

class ClientModel {
  final String id;
  final String name;
  final DateTime dateIni;
  final DateTime dateEnd;
  final DateTime dateAvaliable;
  final DateTime? dateBirthday;
  final List<PaymentModel> datesPayment;
  final String observation;
  final bool active;

  ClientModel({
    required this.id,
    required this.name,
    required this.dateIni,
    required this.dateEnd,
    required this.dateAvaliable,
    this.dateBirthday,
    this.datesPayment = const [],
    this.observation = '',
    this.active = true,
  });

  factory ClientModel.empty() => ClientModel(
        id: '',
        name: '',
        dateIni: DateTime.now(),
        dateEnd: DateTime.now(),
        dateAvaliable: DateTime.now(),
      );

  ClientModel copyWith({
    String? id,
    String? name,
    DateTime? dateIni,
    DateTime? dateEnd,
    DateTime? dateAvaliable,
    DateTime? dateBirthday,
    List<PaymentModel>? datesPayment,
    String? observation,
    bool? active,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateIni: dateIni ?? this.dateIni,
      dateEnd: dateEnd ?? this.dateEnd,
      dateAvaliable: dateAvaliable ?? this.dateAvaliable,
      dateBirthday: dateBirthday ?? this.dateBirthday,
      datesPayment: datesPayment ?? this.datesPayment,
      observation: observation ?? this.observation,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'dateIni': dateIni.millisecondsSinceEpoch});
    result.addAll({'dateEnd': dateEnd.millisecondsSinceEpoch});
    result.addAll({'dateAvaliable': dateAvaliable.millisecondsSinceEpoch});
    if (dateBirthday != null) {
      result.addAll({'dateBirthday': dateBirthday!.millisecondsSinceEpoch});
    }
    result.addAll({'datesPayment': datesPayment.map((x) => x.toMap()).toList()});
    result.addAll({'observation': observation});
    result.addAll({'active': active});

    return result;
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dateIni: DateTime.fromMillisecondsSinceEpoch(map['dateIni']),
      dateEnd: DateTime.fromMillisecondsSinceEpoch(map['dateEnd']),
      dateAvaliable: DateTime.fromMillisecondsSinceEpoch(map['dateAvaliable']),
      dateBirthday: map['dateBirthday'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateBirthday']) : null,
      datesPayment: List<PaymentModel>.from(map['datesPayment']?.map((x) => PaymentModel.fromMap(x))),
      observation: map['observation'] ?? '',
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, dateIni: $dateIni, dateEnd: $dateEnd, dateAvaliable: $dateAvaliable, dateBirthday: $dateBirthday, datesPayment: $datesPayment, observation: $observation, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClientModel &&
        other.id == id &&
        other.name == name &&
        other.dateEnd.isSameDate(dateEnd) &&
        other.dateAvaliable.isSameDate(dateAvaliable) &&
        (dateBirthday?.isSameDate(other.dateBirthday ?? DateTime.now()) ?? true) &&
        listEquals(other.datesPayment, datesPayment) &&
        other.observation == observation &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dateIni.hashCode ^
        dateEnd.hashCode ^
        dateAvaliable.hashCode ^
        dateBirthday.hashCode ^
        datesPayment.hashCode ^
        observation.hashCode ^
        active.hashCode;
  }
}
