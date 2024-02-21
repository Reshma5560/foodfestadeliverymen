import 'package:foodfestadeliverymen/data/models/get_review_model.dart';
import 'package:foodfestadeliverymen/repositories/desktop_repository.dart';
import 'package:get/get.dart';

import '../../data/models/get_profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoader = false.obs;

  // File? selectedProfileImage;
  GetProfileModel? getDataMap;
Rx<GetReviewData>  getReviewData=GetReviewData().obs;
  // RxBool isLoading = false.obs;

RxBool isRating=false.obs;

  RxString userApiImageFile = "".obs;
  RxString userName = "".obs;
  RxString phoneNoName = "".obs;
  RxString email = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;

  @override
  void onReady() {
    DesktopRepository().getProfileApiCall(isLoader: isLoader);
    super.onReady();
  }
}
