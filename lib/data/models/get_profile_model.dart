// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) =>
    GetProfileModel.fromJson(json.decode(str));

class GetProfileModel {
  bool status;
  Data data;

  GetProfileModel({
    required this.status,
    required this.data,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) =>
      GetProfileModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String image;
  int isPhoneVerified;
  dynamic emailVerifiedAt;
  dynamic emailVerificationToken;
  dynamic cmFirebaseToken;
  int isActive;
  int newsletterSubscribe;
  int isVerified;
  String verifyCode;
  dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  int status;
  int orderCount;
  dynamic loginMedium;
  dynamic socialId;
  dynamic zoneId;
  int walletBalance;
  int loyaltyPoint;
  dynamic refCode;
  dynamic refBy;
  String tempToken;
  String currentLanguageKey;
  List<Role> roles;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
    required this.isPhoneVerified,
    required this.emailVerifiedAt,
    required this.emailVerificationToken,
    required this.cmFirebaseToken,
    required this.isActive,
    required this.newsletterSubscribe,
    required this.isVerified,
    required this.verifyCode,
    required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    required this.status,
    required this.orderCount,
    required this.loginMedium,
    required this.socialId,
    required this.zoneId,
    required this.walletBalance,
    required this.loyaltyPoint,
    required this.refCode,
    required this.refBy,
    required this.tempToken,
    required this.currentLanguageKey,
    required this.roles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"] ?? "",
        isPhoneVerified: json["is_phone_verified"],
        emailVerifiedAt: json["email_verified_at"],
        emailVerificationToken: json["email_verification_token"],
        cmFirebaseToken: json["cm_firebase_token"],
        isActive: json["is_active"],
        newsletterSubscribe: json["newsletter_subscribe"],
        isVerified: json["is_verified"],
        verifyCode: json["verify_code"],
        deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        orderCount: json["order_count"] ?? 0,
        loginMedium: json["login_medium"],
        socialId: json["social_id"],
        zoneId: json["zone_id"],
        walletBalance: json["wallet_balance"],
        loyaltyPoint: json["loyalty_point"],
        refCode: json["ref_code"],
        refBy: json["ref_by"],
        tempToken: json["temp_token"],
        currentLanguageKey: json["current_language_key"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );
}

class Role {
  String id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );
}

class Pivot {
  String modelType;
  String modelUuid;
  String roleId;

  Pivot({
    required this.modelType,
    required this.modelUuid,
    required this.roleId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelType: json["model_type"],
        modelUuid: json["model_uuid"],
        roleId: json["role_id"],
      );
}
