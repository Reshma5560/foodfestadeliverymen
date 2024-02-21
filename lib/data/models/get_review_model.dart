// To parse this JSON data, do
//
//     final getReviewModel = getReviewModelFromJson(jsonString);

import 'dart:convert';

GetReviewModel getReviewModelFromJson(String str) =>
    GetReviewModel.fromJson(json.decode(str));

String getReviewModelToJson(GetReviewModel data) => json.encode(data.toJson());

class GetReviewModel {
  final bool? status;
  final GetReviewData? data;

  GetReviewModel({
    this.status,
    this.data,
  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) => GetReviewModel(
        status: json["status"],
        data:
            json["data"] == null ? null : GetReviewData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class GetReviewData {
  final String? id;
  final String? userId;
  final String? identityNumber;
  final String? identityType;
  final String? identityImage;
  final dynamic image;
  final int? earning;
  final String? zoneId;
  final int? orderCount;
  final int? assignedOrderCount;
  final int? available;
  final String? vehicleId;
  final String? shiftId;
  final int? currentOrders;
  final dynamic additionalData;
  final dynamic additionalDocuments;
  final String? applicationStatus;
  final String? type;
  final dynamic restaurantId;
  final String? paymentType;
  final String? paymentAmount;
  final int? isActive;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ratingCount;
  final int? commentsCount;
  final dynamic comments;

  GetReviewData({
    this.id,
    this.userId,
    this.identityNumber,
    this.identityType,
    this.identityImage,
    this.image,
    this.earning,
    this.zoneId,
    this.orderCount,
    this.assignedOrderCount,
    this.available,
    this.vehicleId,
    this.shiftId,
    this.currentOrders,
    this.additionalData,
    this.additionalDocuments,
    this.applicationStatus,
    this.type,
    this.restaurantId,
    this.paymentType,
    this.paymentAmount,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.ratingCount,
    this.commentsCount,
    this.comments,
  });

  factory GetReviewData.fromJson(Map<String, dynamic> json) => GetReviewData(
        id: json["id"],
        userId: json["user_id"],
        identityNumber: json["identity_number"],
        identityType: json["identity_type"],
        identityImage: json["identity_image"],
        image: json["image"],
        earning: json["earning"],
        zoneId: json["zone_id"],
        orderCount: json["order_count"],
        assignedOrderCount: json["assigned_order_count"],
        available: json["available"],
        vehicleId: json["vehicle_id"],
        shiftId: json["shift_id"],
        currentOrders: json["current_orders"],
        additionalData: json["additional_data"],
        additionalDocuments: json["additional_documents"],
        applicationStatus: json["application_status"],
        type: json["type"],
        restaurantId: json["restaurant_id"],
        paymentType: json["payment_type"],
        paymentAmount: json["payment_amount"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        ratingCount: json["rating_count"],
        commentsCount: json["comments_count"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "identity_number": identityNumber,
        "identity_type": identityType,
        "identity_image": identityImage,
        "image": image,
        "earning": earning,
        "zone_id": zoneId,
        "order_count": orderCount,
        "assigned_order_count": assignedOrderCount,
        "available": available,
        "vehicle_id": vehicleId,
        "shift_id": shiftId,
        "current_orders": currentOrders,
        "additional_data": additionalData,
        "additional_documents": additionalDocuments,
        "application_status": applicationStatus,
        "type": type,
        "restaurant_id": restaurantId,
        "payment_type": paymentType,
        "payment_amount": paymentAmount,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rating_count": ratingCount,
        "comments_count": commentsCount,
        "comments": comments,
      };
}
