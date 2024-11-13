import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'payment_model.dart';

class ClientModel {
  final String id;
  final String name;
  final DateTime dateIni;
  final DateTime dateEnd;
  final DateTime dateAvaliable;
  final List<PaymentModel> datesPayment;
  final num total;
  final String observation;
  final bool active;

  ClientModel({
    required this.id,
    required this.name,
    required this.dateIni,
    required this.dateEnd,
    required this.dateAvaliable,
    this.datesPayment = const [],
    this.total = 0,
    this.observation = '',
    this.active = true,
  });

  factory ClientModel.empty() => ClientModel(
        id: '',
        name: '',
        dateIni: DateTime.now(),
        dateEnd: DateTime.now().add(const Duration(days: 90)),
        dateAvaliable: DateTime.now(),
      );

  ClientModel copyWith({
    String? id,
    String? name,
    DateTime? dateIni,
    DateTime? dateEnd,
    DateTime? dateAvaliable,
    List<PaymentModel>? datesPayment,
    num? total,
    String? observation,
    bool? active,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateIni: dateIni ?? this.dateIni,
      dateEnd: dateEnd ?? this.dateEnd,
      dateAvaliable: dateAvaliable ?? this.dateAvaliable,
      datesPayment: datesPayment ?? this.datesPayment,
      total: total ?? this.total,
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
    result.addAll({'datesPayment': datesPayment.map((x) => x.toMap()).toList()});
    result.addAll({'total': total});
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
      datesPayment: List<PaymentModel>.from(map['datesPayment']?.map((x) => PaymentModel.fromMap(x))),
      total: map['total'] ?? 0,
      observation: map['observation'] ?? '',
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, dateIni: $dateIni, dateEnd: $dateEnd, dateAvaliable: $dateAvaliable, datesPayment: $datesPayment, total: $total, observation: $observation, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClientModel &&
        other.id == id &&
        other.name == name &&
        other.dateIni == dateIni &&
        other.dateEnd == dateEnd &&
        other.dateAvaliable == dateAvaliable &&
        listEquals(other.datesPayment, datesPayment) &&
        other.total == total &&
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
        datesPayment.hashCode ^
        total.hashCode ^
        observation.hashCode ^
        active.hashCode;
  }
}
