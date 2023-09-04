import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asignment_app/allWidgets.dart';
import 'package:flutter_asignment_app/home_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return GetBuilder<HomeController>(
      autoRemove: false,
      global: true,
      init: HomeController(),
      initState: (state) {
        final homeController = Get.put(HomeController());
        homeController.getHomeDetails();
      },
      builder: (HomeController homeController) {
        bool isLoading = (homeController.homeDataModel == null ||
            homeController.homeDataModel!.title.isNotEmpty);
        return Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          appBar: AppBar(
            toolbarHeight: 45,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 205, 44, 0),
            iconTheme: const IconThemeData(color: Colors.white),
            title: isLoading
                ? Text(homeController.homeDataModel!.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto-Medium.ttf',
                    ))
                : ShimmerEffectView(height: 40.px, width: 80.w),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? const SearchWidget()
                  : ShimmerEffectView(height: 40.px, width: 80.w),
            ],
          ),
        );
      },
    );
  }

  void logs(String s) {}
}
