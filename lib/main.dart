import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodfestadeliverymen/res/app_strings.dart';
import 'package:foodfestadeliverymen/res/app_theme.dart';
import 'package:foodfestadeliverymen/res/color_print.dart';
import 'package:foodfestadeliverymen/route/app_pages.dart';
import 'package:foodfestadeliverymen/route/app_routes.dart';
import 'package:foodfestadeliverymen/utils/local_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/base_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await LocalStorage.readDataInfo();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // await NotificationService.init();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LocalStorage.printLocalStorageData();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          initialBinding: LazyBinding(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightMode(),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}

class LazyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
    // Get.put(FirebaseController(), permanent: true);
    printData(key: "Get.put", value: BaseController);
  }
}
