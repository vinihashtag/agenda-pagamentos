import 'dart:convert';

import 'package:agenda_pagamentos/core/extensions/date_extension.dart';

class PaymentModel {
  final DateTime datePayment;
  final num value;
  final bool paid;

  PaymentModel({
    required this.datePayment,
    required this.value,
    required this.paid,
  });

  PaymentModel copyWith({
    DateTime? datePayment,
    num? value,
    bool? paid,
  }) {
    return PaymentModel(
      datePayment: datePayment ?? this.datePayment,
      value: value ?? this.value,
      paid: paid ?? this.paid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'datePayment': datePayment.millisecondsSinceEpoch});
    result.addAll({'value': value});
    result.addAll({'paid': paid});

    return result;
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      datePayment: DateTime.fromMillisecondsSinceEpoch(map['datePayment']),
      value: map['value'] ?? 0,
      paid: map['paid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) => PaymentModel.fromMap(json.decode(source));

  @override
  String toString() => 'PaymentModel(datePayment: $datePayment, value: $value, paid: $paid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentModel &&
        other.datePayment.isSameDate(datePayment) &&
        other.value == value &&
        other.paid == paid;
  }

  @override
  int get hashCode => datePayment.hashCode ^ value.hashCode ^ paid.hashCode;
}
