import 'package:flutter/material.dart';
import 'package:order_listing/App_configs/app_configs.dart';
import 'package:shimmer/shimmer.dart';
class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
              loop: 2,
              child: Container(height: 150,),
              baseColor: AppConfig.loadingColorforworg,
              highlightColor:AppConfig.loadingColorBackword,
            );
  }
}