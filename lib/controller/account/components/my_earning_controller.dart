import 'package:foodfestadeliverymen/data/models/get_deliverymen_earning_model.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:get/get.dart';

class MyEarningController extends GetxController {
  RxBool isLoader = true.obs;

  Rx<GetDeliveryManEarningModel> myEarningData =
      GetDeliveryManEarningModel().obs;

  @override
  Future<void> onReady() async {
    await DesktopRepository().getEarningApiCall(isLoader: isLoader);
    super.onReady();
  }
}
