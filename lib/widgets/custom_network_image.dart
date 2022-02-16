import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lekki_proj_demo/utils/helpers.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
     Key? key, 
     required this.imageUrl, 
     this.height, 
     this.width, 
     this.fit, 
     this.fullRadius = false,
     this.useFilter = false,
  }) : super(key: key);


  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool? fullRadius;
  final bool useFilter;

  @override
  Widget build(BuildContext context) {
      return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: getRadius(fullRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
            colorFilter: useFilter ? ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.srcOver) : null
          )
        ),
      ),
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: getRadius(fullRadius),
          color: KColorScheme.backgroundGrey
        ),
        child: const Center(
          child:  SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 3,)
          )
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: getRadius(fullRadius),
          color: KColorScheme.backgroundGrey
        ),
        child: const Icon(Icons.error, color: KColorScheme.red,)
      ),
    );
  }
}
