import 'dart:io';
import 'package:flutter_asignment_app/home_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asignment_app/home_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final homeController = Get.put(HomeController());
  List<RowData> searchRowModelData = [];

  @override
  void initState() {
    // TODO: implement initState
    if (homeController.rowModelData != null) {
      for (int i = 0; i < homeController.rowModelData!.length; i++) {
        searchRowModelData.add(homeController.rowModelData![i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RowData> resultData = [];
    filterSearchResults(String enteredKeyword) {
      if (enteredKeyword.isEmpty) {
        resultData.clear();
        for (int i = 0; i < homeController.rowModelData!.length; i++) {
          resultData.add(homeController.rowModelData![i]);
        }
      } else {
        resultData.clear();
        for (int i = 0; i < homeController.rowModelData!.length; i++) {
          var title = homeController.rowModelData![i].title.toString();

          if (title.toLowerCase().contains(enteredKeyword.toLowerCase())) {
            resultData.add(homeController.rowModelData![i]);
          }
        }
      }
      setState(() {
        searchRowModelData = resultData;
      });
    }

    return SizedBox(
        height: 700.px,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 10.px),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.px, horizontal: 12.px),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextField(
                    onChanged: (value) => filterSearchResults(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.px, vertical: 5.px),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            SizedBox(width: 5.px),
                            SizedBox(
                              height: 100.px,
                              width: 100.px,
                              child: Image.network(
                                searchRowModelData[index].imageHref.toString(),
                              ),
                            ),
                            SizedBox(width: 25.px),
                            Expanded(
                                child: Text(
                                    searchRowModelData[index].title.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto-Medium.ttf',
                                    ))),
                            SizedBox(width: 2.px),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.px, vertical: 5.px),
                                    child: Text(searchRowModelData[index]
                                        .description
                                        .toString()))),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 2,
                    ),
                    itemCount: searchRowModelData.length,
                  ),
                ],
              ))
            ]));
  }
}

class ShimmerEffectView extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? leftMargin;

  const ShimmerEffectView(
      {Key? key, this.height, this.width, this.borderRadius, this.leftMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 205, 44, 0),
      highlightColor: const Color.fromARGB(255, 10, 9, 9),
      child: Container(
        height: height ?? 30.px,
        width: width ?? 50.px,
        margin: EdgeInsets.only(left: leftMargin ?? 0.px),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 4.px),
        ),
      ),
    );
  }
}
