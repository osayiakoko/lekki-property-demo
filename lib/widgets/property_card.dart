import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/utils/helpers.dart';
import 'package:lekki_proj_demo/views/property_details_view.dart';
import 'package:lekki_proj_demo/widgets/custom_network_image.dart';
import 'package:lekki_proj_demo/widgets/property_attribute.dart';

class PropertyCard extends StatelessWidget {

  final Property property;

  const PropertyCard(this.property, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context, 
        PropertyDetailsView.routeName, 
        arguments: property
      ),
      child: Container(
        height:280.h,
        margin: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 6.w
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: -2,
              blurRadius: 6,
              offset: const Offset(3, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            getImage(property.images),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                children: [
                  PropertyAttribute(Icons.person, property.propertyOwner),
                  SizedBox(width: 20.w,),
                  PropertyAttribute(Icons.location_on, property.address),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w
              ),
              child: Row(
                children: [
                  PropertyAttribute(Icons.category, property.type),
                  SizedBox(width: 20.w,),
                  PropertyAttribute(Icons.bedroom_parent, '${property.bedroom} room(s)'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImage(List<PropertyImage> images){
    return images.isNotEmpty 
      ? CustomNetworkImage(
        imageUrl: images[0].path,
        height: 200.h,
      )
      : ClipRRect(
        borderRadius: getRadius(false),
        child: Image.asset(
          'assets/images/no_property_image.jpg',
          height: 200.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
  }
}
