import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';
import 'package:lekki_proj_demo/views/update_property_view.dart';
import 'package:lekki_proj_demo/widgets/images_carousel.dart';
import 'package:lekki_proj_demo/widgets/property_attribute.dart';
import 'package:lekki_proj_demo/widgets/rect_rounded_button.dart';

class PropertyDetailsView extends ConsumerWidget {

  Property property;

  PropertyDetailsView(this.property, {Key? key}) : super(key: key);

  static const routeName = "/property-details-view";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property details'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, UpdateProperty.routeName, arguments: property), 
            icon: Icon(Icons.edit)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 8.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getImageRepr(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        PropertyAttribute(
                          Icons.person, property.propertyOwner, boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                        SizedBox(width: 20.w,),
                        PropertyAttribute(
                          Icons.location_on, property.address, boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        PropertyAttribute(
                          Icons.category, property.type, boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                        SizedBox(width: 20.w,),
                        PropertyAttribute(
                          Icons.bedroom_parent, '${property.bedroom} bedroom(s)', boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        PropertyAttribute(
                          Icons.chair, '${property.sittingRoom} sittingroom(s)', boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                        SizedBox(width: 20.w,),
                        PropertyAttribute(
                          Icons.kitchen, '${property.kitchen} kitchen(s)', boldText: true,
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        PropertyAttribute(
                          Icons.bathroom, '${property.bathroom} bathroom(s)', boldText: true, 
                          iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                        SizedBox(width: 20.w,),
                        PropertyAttribute(
                          Icons.rice_bowl_outlined, '${property.toilet} toilet(s)', 
                          boldText: true, iconColor: KColorScheme.primary.withOpacity(0.7)
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    _propertyTitleText(context, "Valid from: ", DateFormat(DateFormat.YEAR_MONTH_DAY).format(property.validFrom)),
                    SizedBox(height: 20.h,),
                    _propertyTitleText(context, "Valid To: ", DateFormat(DateFormat.YEAR_MONTH_DAY).format(property.validTo)),
                    SizedBox(height: 20.h,),
                    _propertyTitleText(context, "Description: ", property.description),
                  ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: RectRoundedButton(
                title: "Apply",
                onPressed: (){},
              ),
            )
          ]
        ),
      ),
    );
  }

  Widget _getImageRepr(){
    return property.images.isNotEmpty 
      ? ImagesCarousel(property.images)
      : Image.asset(
        'assets/images/no_property_image.jpg',
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
      );
  }

  Widget _propertyTitleText(BuildContext context, String title, String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontWeight: FontWeight.w600
          )
        ),
        SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(text),
        )
      ]
    );
  }
}
