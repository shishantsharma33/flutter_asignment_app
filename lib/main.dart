import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wakelock/wakelock.dart';
import 'homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext context, Orientation orientation, screenType) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: GetMaterialApp(
            title: 'Flutter AsignApp',
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fadeIn,
            navigatorKey: Get.key,
            initialRoute: RouteHelper.getInitialRoute(),
            getPages: RouteHelper.routes,
            scrollBehavior: MyBehavior(),
            locale: Get.deviceLocale,
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class RouteHelper {
  static String getInitialRoute() => RouteConstant.initial;

  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => HomeScreen()),
  ];
}

class RouteConstant {
  static const String initial = '/HomeScreen';
}
