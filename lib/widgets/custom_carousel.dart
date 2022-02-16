import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/widgets/custom_network_image.dart';

class CustomCarousel extends StatelessWidget {

  final List<String> imageURLs;
  final Function(int index) onPageChanged;

  CustomCarousel({required this.imageURLs, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190.h,
        autoPlay: true,
        viewportFraction: 1,
        pauseAutoPlayOnTouch: true,
        onPageChanged: (index, _) => onPageChanged(index),
      ),
      items: imageURLs.map((imageURL) =>
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: CustomNetworkImage(
              imageUrl: imageURL,
              fullRadius: true,
            ),
          ),
        )
      ).toList()
    );
  }
}
