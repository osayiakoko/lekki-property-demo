import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';
import 'package:lekki_proj_demo/widgets/custom_carousel.dart';

class ImagesCarousel extends StatefulWidget {

  final List<PropertyImage> images;
  
  const ImagesCarousel(this.images, {Key? key,}) : super(key: key);

  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomCarousel(
          imageURLs: widget.images.map((e) => e.path).toList(),
          onPageChanged: (index) => setState(() => _current = index),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().map((index, img) => 
            MapEntry (index, Container(
              width: 12.0,
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2),
                color: _current == index ? KColorScheme.primary : KColorScheme.lightGrey
              ),
            )
          )).values.toList()
        )
      ],
    );
  }
}
