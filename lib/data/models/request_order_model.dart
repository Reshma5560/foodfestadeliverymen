// To parse this JSON data, do
//
//     final requestOrderModel = requestOrderModelFromJson(jsonString);

import 'dart:convert';

RequestOrderModel requestOrderModelFromJson(String str) =>
    RequestOrderModel.fromJson(json.decode(str));

class RequestOrderModel {
  final bool? status;
  final RequestOrderData? data;

  RequestOrderModel({
    this.status,
    this.data,
  });

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) =>
      RequestOrderModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : RequestOrderData.fromJson(json["data"]),
      );
}

class RequestOrderData {
  final int? currentPage;
  final List<RequestOrderDatum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  RequestOrderData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory RequestOrderData.fromJson(Map<String, dynamic> json) =>
      RequestOrderData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<RequestOrderDatum>.from(
                json["data"]!.map((x) => RequestOrderDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class RequestOrderDatum {
  final String? id;
  final String? invoiceNumber;
  final String? userId;
  final String? orderStatusId;
  final String? paymentStatusId;
  final String? paymentTypeId;
  final int? orderAmount;
  final String? totalDiscount;
  final int? totalTaxAmount;
  final int? deliveryCharge;
  final int? restaurantDiscountAmount;
  final int? originalDeliveryCharge;
  final dynamic transactionReference;
  final String? deliveryAddressId;
  final String? deliveryManId;
  final dynamic deliveryManRemarks;
  final dynamic couponCode;
  final dynamic orderNote;
  final dynamic deliveryDate;
  final String? orderType;
  final int? checked;
  final String? restaurantId;
  final String? adjustment;
  final String? discountTotal;
  final int? edited;
  final dynamic otp;
  final dynamic pending;
  final dynamic accepted;
  final dynamic confirmed;
  final dynamic processing;
  final dynamic handover;
  final dynamic pickedUp;
  final dynamic delivered;
  final dynamic canceled;
  final dynamic refundRequested;
  final dynamic refunded;
  final dynamic failed;
  final dynamic cancellationNote;
  final dynamic cancellationReason;
  final dynamic canceledBy;
  final dynamic refundRequestCanceled;
  final dynamic taxPercentage;
  final dynamic deliveryInstruction;
  final dynamic unavailableItemNote;
  final bool? cutlery;
  final int? distance;
  final bool? isGuest;
  final dynamic deliveryAddress;
  final dynamic zoneId;
  final int? dmTips;
  final dynamic taxStatus;
  final dynamic vehicleId;
  final dynamic scheduleAt;
  final int? scheduled;
  final dynamic processingTime;
  final dynamic callback;
  final int? additionalCharge;
  final int? partiallyPaidAmount;
  final dynamic orderProof;
  final dynamic couponCreatedBy;
  final dynamic freeDeliveryBy;
  final int? orderSubscriptionActive;
  final int? isActive;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? discountOnProductBy;
  final dynamic subscriptionId;
  final User? user;
  final Status? orderStatus;
  final Status? paymentStatus;
  final PaymentType? paymentType;
  final Restaurant? restaurant;
  final List<OrderDetail>? orderDetail;

  RequestOrderDatum({
    this.id,
    this.invoiceNumber,
    this.userId,
    this.orderStatusId,
    this.paymentStatusId,
    this.paymentTypeId,
    this.orderAmount,
    this.totalDiscount,
    this.totalTaxAmount,
    this.deliveryCharge,
    this.restaurantDiscountAmount,
    this.originalDeliveryCharge,
    this.transactionReference,
    this.deliveryAddressId,
    this.deliveryManId,
    this.deliveryManRemarks,
    this.couponCode,
    this.orderNote,
    this.deliveryDate,
    this.orderType,
    this.checked,
    this.restaurantId,
    this.adjustment,
    this.discountTotal,
    this.edited,
    this.otp,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.failed,
    this.cancellationNote,
    this.cancellationReason,
    this.canceledBy,
    this.refundRequestCanceled,
    this.taxPercentage,
    this.deliveryInstruction,
    this.unavailableItemNote,
    this.cutlery,
    this.distance,
    this.isGuest,
    this.deliveryAddress,
    this.zoneId,
    this.dmTips,
    this.taxStatus,
    this.vehicleId,
    this.scheduleAt,
    this.scheduled,
    this.processingTime,
    this.callback,
    this.additionalCharge,
    this.partiallyPaidAmount,
    this.orderProof,
    this.couponCreatedBy,
    this.freeDeliveryBy,
    this.orderSubscriptionActive,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.discountOnProductBy,
    this.subscriptionId,
    this.user,
    this.orderStatus,
    this.paymentStatus,
    this.paymentType,
    this.restaurant,
    this.orderDetail,
  });

  factory RequestOrderDatum.fromJson(Map<String, dynamic> json) =>
      RequestOrderDatum(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        userId: json["user_id"],
        orderStatusId: json["order_status_id"],
        paymentStatusId: json["payment_status_id"],
        paymentTypeId: json["payment_type_id"],
        orderAmount: json["order_amount"],
        totalDiscount: json["total_discount"],
        totalTaxAmount: json["total_tax_amount"],
        deliveryCharge: json["delivery_charge"],
        restaurantDiscountAmount: json["restaurant_discount_amount"],
        originalDeliveryCharge: json["original_delivery_charge"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        deliveryManId: json["delivery_man_id"],
        deliveryManRemarks: json["delivery_man_remarks"],
        couponCode: json["coupon_code"],
        orderNote: json["order_note"],
        deliveryDate: json["delivery_date"],
        orderType: json["order_type"],
        checked: json["checked"],
        restaurantId: json["restaurant_id"],
        adjustment: json["adjustment"],
        discountTotal: json["discount_total"],
        edited: json["edited"],
        otp: json["otp"],
        pending: json["pending"],
        accepted: json["accepted"],
        confirmed: json["confirmed"],
        processing: json["processing"],
        handover: json["handover"],
        pickedUp: json["picked_up"],
        delivered: json["delivered"],
        canceled: json["canceled"],
        refundRequested: json["refund_requested"],
        refunded: json["refunded"],
        failed: json["failed"],
        cancellationNote: json["cancellation_note"],
        cancellationReason: json["cancellation_reason"],
        canceledBy: json["canceled_by"],
        refundRequestCanceled: json["refund_request_canceled"],
        taxPercentage: json["tax_percentage"],
        deliveryInstruction: json["delivery_instruction"],
        unavailableItemNote: json["unavailable_item_note"],
        cutlery: json["cutlery"],
        distance: json["distance"],
        isGuest: json["is_guest"],
        deliveryAddress: json["delivery_address"],
        zoneId: json["zone_id"],
        dmTips: json["dm_tips"],
        taxStatus: json["tax_status"],
        vehicleId: json["vehicle_id"],
        scheduleAt: json["schedule_at"],
        scheduled: json["scheduled"],
        processingTime: json["processing_time"],
        callback: json["callback"],
        additionalCharge: json["additional_charge"],
        partiallyPaidAmount: json["partially_paid_amount"],
        orderProof: json["order_proof"],
        couponCreatedBy: json["coupon_created_by"],
        freeDeliveryBy: json["free_delivery_by"],
        orderSubscriptionActive: json["order_subscription_active"],
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
        discountOnProductBy: json["discount_on_product_by"],
        subscriptionId: json["subscription_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        orderStatus: json["order_status"] == null
            ? null
            : Status.fromJson(json["order_status"]),
        paymentStatus: json["payment_status"] == null
            ? null
            : Status.fromJson(json["payment_status"]),
        paymentType: json["payment_type"] == null
            ? null
            : PaymentType.fromJson(json["payment_type"]),
        restaurant: json["restaurant"] == null
            ? null
            : Restaurant.fromJson(json["restaurant"]),
        orderDetail: json["order_detail"] == null
            ? []
            : List<OrderDetail>.from(
                json["order_detail"]!.map((x) => OrderDetail.fromJson(x))),
      );
}

class OrderDetail {
  final String? id;
  final String? orderId;
  final String? foodId;
  final int? price;
  final String? totalAmount;
  final dynamic tax;
  final dynamic discount;
  final String? variant;
  final String? addon;
  final int? quantity;
  final dynamic foodDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Food? food;

  OrderDetail({
    this.id,
    this.orderId,
    this.foodId,
    this.price,
    this.totalAmount,
    this.tax,
    this.discount,
    this.variant,
    this.addon,
    this.quantity,
    this.foodDetails,
    this.createdAt,
    this.updatedAt,
    this.food,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        foodId: json["food_id"],
        price: json["price"],
        totalAmount: json["total_amount"],
        tax: json["tax"],
        discount: json["discount"],
        variant: json["variant"],
        addon: json["addon"],
        quantity: json["quantity"],
        foodDetails: json["food_details"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        food: json["food"] == null ? null : Food.fromJson(json["food"]),
      );
}

class Food {
  final String? id;
  final String? foodName;
  final String? description;
  final String? image;
  final String? categoryId;
  final dynamic categoryIds;
  final dynamic variations;
  final dynamic addOns;
  final dynamic attributes;
  final dynamic choiceOptions;
  final String? basePrice;
  final int? price;
  final int? tax;
  final String? taxType;
  final int? discount;
  final String? discountType;
  final String? availableTimeStarts;
  final String? availableTimeEnds;
  final int? veg;
  final int? status;
  final String? restaurantId;
  final int? avgRating;
  final String? ratingCount;
  final dynamic rating;
  final String? slug;
  final int? recommended;
  final int? orderCount;
  final int? minimumCartQuantity;
  final int? maximumCartQuantity;
  final int? isActive;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? commentsCount;
  final List<dynamic>? translations;

  Food({
    this.id,
    this.foodName,
    this.description,
    this.image,
    this.categoryId,
    this.categoryIds,
    this.variations,
    this.addOns,
    this.attributes,
    this.choiceOptions,
    this.basePrice,
    this.price,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.veg,
    this.status,
    this.restaurantId,
    this.avgRating,
    this.ratingCount,
    this.rating,
    this.slug,
    this.recommended,
    this.orderCount,
    this.minimumCartQuantity,
    this.maximumCartQuantity,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.commentsCount,
    this.translations,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        foodName: json["food_name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        variations: json["variations"],
        addOns: json["add_ons"],
        attributes: json["attributes"],
        choiceOptions: json["choice_options"],
        basePrice: json["base_price"],
        price: json["price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        availableTimeStarts: json["available_time_starts"],
        availableTimeEnds: json["available_time_ends"],
        veg: json["veg"],
        status: json["status"],
        restaurantId: json["restaurant_id"],
        avgRating: json["avg_rating"],
        ratingCount: json["rating_count"],
        rating: json["rating"],
        slug: json["slug"],
        recommended: json["recommended"],
        orderCount: json["order_count"],
        minimumCartQuantity: json["minimum_cart_quantity"],
        maximumCartQuantity: json["maximum_cart_quantity"],
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
        commentsCount: json["comments_count"],
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
      );
}

class Status {
  final String? id;
  final String? status;
  final String? statusName;
  final int? isActive;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Status({
    this.id,
    this.status,
    this.statusName,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        status: json["status"],
        statusName: json["status_name"],
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
      );
}

class PaymentType {
  final String? id;
  final String? paymentTypeName;
  final String? description;
  final String? value;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentType({
    this.id,
    this.paymentTypeName,
    this.description,
    this.value,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        id: json["id"],
        paymentTypeName: json["payment_type_name"],
        description: json["description"],
        value: json["value"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class Restaurant {
  final String? id;
  final String? restaurantName;
  final String? phone;
  final String? email;
  final String? logo;
  final String? minimumDeliveryTime;
  final String? maximumDeliveryTime;
  final String? tinNumber;
  final DateTime? date;
  final String? tags;
  final String? licenseDocument;
  final String? latitude;
  final String? longitude;
  final String? address;
  final dynamic footerText;
  final String? minimumOrderAmount;
  final int? minimumShippingCharge;
  final dynamic perKmShippingCharge;
  final bool? freeDelivery;
  final String? userId;
  final List<int>? rating;
  final int? homeDelivery;
  final bool? takeAway;
  final bool? cutlery;
  final dynamic metaTitle;
  final dynamic metaDescription;
  final dynamic metaImage;
  final int? tax;
  final dynamic commission;
  final String? coverPhoto;
  final String? slug;
  final dynamic qrCode;
  final String? offDay;
  final DateTime? openingTime;
  final String? closingTime;
  final String? zoneId;
  final int? announcement;
  final dynamic announcementMessage;
  final int? veg;
  final int? nonVeg;
  final int? selfDeliverySystem;
  final bool? posSystem;
  final dynamic deliveryTime;
  final int? scheduleDelivery;
  final bool? foodSection;
  final bool? reviewsSection;
  final String? restaurantModel;
  final int? orderCount;
  final int? totalOrder;
  final dynamic maximumShippingCharge;
  final dynamic additionalData;
  final dynamic additionalDocuments;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final int? isActive;
  final int? isVerify;
  final int? closeTemporarily;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? orderSubscriptionActive;
  final bool? gstStatus;
  final String? gstCode;
  final bool? freeDeliveryDistanceStatus;
  final String? freeDeliveryDistanceValue;
  final List<dynamic>? translations;

  Restaurant({
    this.id,
    this.restaurantName,
    this.phone,
    this.email,
    this.logo,
    this.minimumDeliveryTime,
    this.maximumDeliveryTime,
    this.tinNumber,
    this.date,
    this.tags,
    this.licenseDocument,
    this.latitude,
    this.longitude,
    this.address,
    this.footerText,
    this.minimumOrderAmount,
    this.minimumShippingCharge,
    this.perKmShippingCharge,
    this.freeDelivery,
    this.userId,
    this.rating,
    this.homeDelivery,
    this.takeAway,
    this.cutlery,
    this.metaTitle,
    this.metaDescription,
    this.metaImage,
    this.tax,
    this.commission,
    this.coverPhoto,
    this.slug,
    this.qrCode,
    this.offDay,
    this.openingTime,
    this.closingTime,
    this.zoneId,
    this.announcement,
    this.announcementMessage,
    this.veg,
    this.nonVeg,
    this.selfDeliverySystem,
    this.posSystem,
    this.deliveryTime,
    this.scheduleDelivery,
    this.foodSection,
    this.reviewsSection,
    this.restaurantModel,
    this.orderCount,
    this.totalOrder,
    this.maximumShippingCharge,
    this.additionalData,
    this.additionalDocuments,
    this.countryId,
    this.stateId,
    this.cityId,
    this.isActive,
    this.isVerify,
    this.closeTemporarily,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.orderSubscriptionActive,
    this.gstStatus,
    this.gstCode,
    this.freeDeliveryDistanceStatus,
    this.freeDeliveryDistanceValue,
    this.translations,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        restaurantName: json["restaurant_name"],
        phone: json["phone"],
        email: json["email"],
        logo: json["logo"],
        minimumDeliveryTime: json["minimum_delivery_time"],
        maximumDeliveryTime: json["maximum_delivery_time"],
        tinNumber: json["tin_number"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        tags: json["tags"],
        licenseDocument: json["license_document"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        footerText: json["footer_text"],
        minimumOrderAmount: json["minimum_order_amount"],
        minimumShippingCharge: json["minimum_shipping_charge"],
        perKmShippingCharge: json["per_km_shipping_charge"],
        freeDelivery: json["free_delivery"],
        userId: json["user_id"],
        rating: json["rating"] == null
            ? []
            : List<int>.from(json["rating"]!.map((x) => x)),
        homeDelivery: json["home_delivery"],
        takeAway: json["take_away"],
        cutlery: json["cutlery"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        tax: json["tax"],
        commission: json["commission"],
        coverPhoto: json["cover_photo"],
        slug: json["slug"],
        qrCode: json["qr_code"],
        offDay: json["off_day"],
        openingTime: json["opening_time"] == null
            ? null
            : DateTime.parse(json["opening_time"]),
        closingTime: json["closing_time"],
        zoneId: json["zone_id"],
        announcement: json["announcement"],
        announcementMessage: json["announcement_message"],
        veg: json["veg"],
        nonVeg: json["non_veg"],
        selfDeliverySystem: json["self_delivery_system"],
        posSystem: json["pos_system"],
        deliveryTime: json["delivery_time"],
        scheduleDelivery: json["schedule_delivery"],
        foodSection: json["food_section"],
        reviewsSection: json["reviews_section"],
        restaurantModel: json["restaurant_model"],
        orderCount: json["order_count"],
        totalOrder: json["total_order"],
        maximumShippingCharge: json["maximum_shipping_charge"],
        additionalData: json["additional_data"],
        additionalDocuments: json["additional_documents"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        isActive: json["is_active"],
        isVerify: json["is_verify"],
        closeTemporarily: json["close_temporarily"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderSubscriptionActive: json["order_subscription_active"],
        gstStatus: json["gst_status"],
        gstCode: json["gst_code"],
        freeDeliveryDistanceStatus: json["free_delivery_distance_status"],
        freeDeliveryDistanceValue: json["free_delivery_distance_value"],
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
      );
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final dynamic image;
  final int? isPhoneVerified;
  final dynamic emailVerifiedAt;
  final dynamic emailVerificationToken;
  final dynamic cmFirebaseToken;
  final int? isActive;
  final int? newsletterSubscribe;
  final int? isVerified;
  final dynamic verifyCode;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? status;
  final int? orderCount;
  final dynamic loginMedium;
  final dynamic socialId;
  final dynamic zoneId;
  final int? walletBalance;
  final int? loyaltyPoint;
  final dynamic refCode;
  final dynamic refBy;
  final dynamic tempToken;
  final String? currentLanguageKey;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.image,
    this.isPhoneVerified,
    this.emailVerifiedAt,
    this.emailVerificationToken,
    this.cmFirebaseToken,
    this.isActive,
    this.newsletterSubscribe,
    this.isVerified,
    this.verifyCode,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.orderCount,
    this.loginMedium,
    this.socialId,
    this.zoneId,
    this.walletBalance,
    this.loyaltyPoint,
    this.refCode,
    this.refBy,
    this.tempToken,
    this.currentLanguageKey,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        isPhoneVerified: json["is_phone_verified"],
        emailVerifiedAt: json["email_verified_at"],
        emailVerificationToken: json["email_verification_token"],
        cmFirebaseToken: json["cm_firebase_token"],
        isActive: json["is_active"],
        newsletterSubscribe: json["newsletter_subscribe"],
        isVerified: json["is_verified"],
        verifyCode: json["verify_code"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        orderCount: json["order_count"],
        loginMedium: json["login_medium"],
        socialId: json["social_id"],
        zoneId: json["zone_id"],
        walletBalance: json["wallet_balance"],
        loyaltyPoint: json["loyalty_point"],
        refCode: json["ref_code"],
        refBy: json["ref_by"],
        tempToken: json["temp_token"],
        currentLanguageKey: json["current_language_key"],
      );
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
