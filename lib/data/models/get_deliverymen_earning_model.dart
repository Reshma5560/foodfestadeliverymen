// To parse this JSON data, do
//
//     final getDeliveryManEarningModel = getDeliveryManEarningModelFromJson(jsonString);

import 'dart:convert';

GetDeliveryManEarningModel getDeliveryManEarningModelFromJson(String str) =>
    GetDeliveryManEarningModel.fromJson(json.decode(str));

String getDeliveryManEarningModelToJson(GetDeliveryManEarningModel data) =>
    json.encode(data.toJson());

class GetDeliveryManEarningModel {
  final bool? status;
  final List<DeliveryManEarningDatum>? data;
  final Wallet? wallet;

  GetDeliveryManEarningModel({
    this.status,
    this.data,
    this.wallet,
  });

  factory GetDeliveryManEarningModel.fromJson(Map<String, dynamic> json) =>
      GetDeliveryManEarningModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DeliveryManEarningDatum>.from(
                json["data"]!.map((x) => DeliveryManEarningDatum.fromJson(x))),
        wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "wallet": wallet?.toJson(),
      };
}

class DeliveryManEarningDatum {
  final String? id;
  final dynamic disbursementId;
  final dynamic restaurantId;
  final String? deliveryManId;
  final int? disbursementAmount;
  final String? paymentMethod;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PaymentType? paymentType;

  DeliveryManEarningDatum({
    this.id,
    this.disbursementId,
    this.restaurantId,
    this.deliveryManId,
    this.disbursementAmount,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentType,
  });

  factory DeliveryManEarningDatum.fromJson(Map<String, dynamic> json) =>
      DeliveryManEarningDatum(
        id: json["id"],
        disbursementId: json["disbursement_id"],
        restaurantId: json["restaurant_id"],
        deliveryManId: json["delivery_man_id"],
        disbursementAmount: json["disbursement_amount"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        paymentType: json["payment_type"] == null
            ? null
            : PaymentType.fromJson(json["payment_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disbursement_id": disbursementId,
        "restaurant_id": restaurantId,
        "delivery_man_id": deliveryManId,
        "disbursement_amount": disbursementAmount,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "payment_type": paymentType?.toJson(),
      };
}

class PaymentType {
  final String? id;
  final String? paymentTypeName;
  final String? description;
  final String? value;
  final String? providerKey;
  final String? providerSecret;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentType({
    this.id,
    this.paymentTypeName,
    this.description,
    this.value,
    this.providerKey,
    this.providerSecret,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        id: json["id"],
        paymentTypeName: json["payment_type_name"],
        description: json["description"],
        value: json["value"],
        providerKey: json["provider_key"],
        providerSecret: json["provider_secret"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_type_name": paymentTypeName,
        "description": description,
        "value": value,
        "provider_key": providerKey,
        "provider_secret": providerSecret,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Wallet {
  final int? id;
  final String? deliveryManId;
  final int? collectedCash;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? totalEarning;
  final int? totalWithdrawn;
  final double? pendingWithdraw;

  Wallet({
    this.id,
    this.deliveryManId,
    this.collectedCash,
    this.createdAt,
    this.updatedAt,
    this.totalEarning,
    this.totalWithdrawn,
    this.pendingWithdraw,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        deliveryManId: json["delivery_man_id"],
        collectedCash: json["collected_cash"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalEarning: json["total_earning"]?.toDouble(),
        totalWithdrawn: json["total_withdrawn"],
        pendingWithdraw: json["pending_withdraw"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_man_id": deliveryManId,
        "collected_cash": collectedCash,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_earning": totalEarning,
        "total_withdrawn": totalWithdrawn,
        "pending_withdraw": pendingWithdraw,
      };
}
