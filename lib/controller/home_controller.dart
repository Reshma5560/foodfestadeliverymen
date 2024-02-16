import 'package:flutter/material.dart';
import 'package:foodfestadeliverymen/data/models/current_order_model.dart';
import 'package:foodfestadeliverymen/data/models/current_order_status_model.dart';
import 'package:foodfestadeliverymen/data/models/request_order_model.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxBool paginationLoading = false.obs;
  RxBool nextPageStop = true.obs;
  RxInt page = 1.obs;

  ScrollController currentOrderScrollController = ScrollController();
  ScrollController requestOrderScrollController = ScrollController();
  // ScrollController pastOrderScrollController = ScrollController();
  TabController? tabController;

  RxList<CurrentOrderDatum> currentOrderListData = <CurrentOrderDatum>[].obs;

  RxList<RequestOrderDatum> requestOrderListData = <RequestOrderDatum>[].obs;

  RxList<CurrentOrderStatusDatum> getCurrentOrderStatusListData = <CurrentOrderStatusDatum>[].obs;
  Rx<CurrentOrderStatusDatum> orderstatusDropDownValue = CurrentOrderStatusDatum(statusName: 'Select order status').obs;

  // RxList<PastOrderDatum> pastOrderListData = <PastOrderDatum>[].obs;

  RxInt tabIndex = 0.obs;
  final List<Tab> orderTabList = <Tab>[
    const Tab(text: 'Current Order'),
    const Tab(text: 'Request Order'),
    // const Tab(text: 'Past Order'),
  ];

  RxBool isAccept = false.obs;
  @override
  void onInit() {
    tabController = TabController(length: orderTabList.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    DesktopRepository().getCurrentOrderListAPI(isInitial: true);
    manageCurrentOrderListScrollController();
    manageRequestOrderListScrollController();
    // managePastOrderListScrollController();
    super.onReady();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  void manageCurrentOrderListScrollController() async {
    currentOrderScrollController.addListener(
      () {
        if (currentOrderScrollController.position.maxScrollExtent ==
                currentOrderScrollController.position.pixels &&
            isLoading.isFalse) {
          if (nextPageStop.isTrue && paginationLoading.isFalse) {
            paginationLoading.value = true;
            DesktopRepository().getCurrentOrderListAPI(isInitial: false);
          }
        }
      },
    );
  }

  void manageRequestOrderListScrollController() async {
    requestOrderScrollController.addListener(
      () {
        if (requestOrderScrollController.position.maxScrollExtent ==
                requestOrderScrollController.position.pixels &&
            isLoading.isFalse) {
          if (nextPageStop.isTrue && paginationLoading.isFalse) {
            paginationLoading.value = true;
            DesktopRepository().getRequestOrderListAPI(isInitial: false);
          }
        }
      },
    );
  }

  // void managePastOrderListScrollController() async {
  //   pastOrderScrollController.addListener(
  //     () {
  //       if (pastOrderScrollController.position.maxScrollExtent ==
  //               pastOrderScrollController.position.pixels &&
  //           isLoading.isFalse) {
  //         if (nextPageStop.isTrue && paginationLoading.isFalse) {
  //           paginationLoading.value = true;
  //           DesktopRepository().getPastOrderListAPI(isInitial: false);
  //         }
  //       }
  //     },
  //   );
  // }
}
