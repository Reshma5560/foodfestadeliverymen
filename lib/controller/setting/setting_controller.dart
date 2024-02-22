import 'package:foodfestadeliverymen/data/models/get_review_model.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isLoader = false.obs;

  // File? selectedProfileImage;
  // GetProfileModel? getDataMap;
  Rx<GetReviewData> getReviewData = GetReviewData().obs;
  // RxBool isLoading = false.obs;

  RxBool isRating = false.obs;

  @override
  void onReady()  {

     DesktopRepository().getReviewApiCall(isLoader: isLoader);
    super.onReady();
  }
}
