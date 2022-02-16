import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/utils/helpers.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';
import 'package:lekki_proj_demo/view_models/property_view_model.dart';
import 'package:lekki_proj_demo/views/add_property_view.dart';
import 'package:lekki_proj_demo/views/filter_property_view.dart';
import 'package:lekki_proj_demo/widgets/loading_indicator.dart';
import 'package:lekki_proj_demo/widgets/property_card.dart';

class ListPropertyView extends ConsumerStatefulWidget {
  const ListPropertyView({Key? key}) : super(key: key);

  static const routeName = "/list-property-view";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPropertyViewState();
}

class _ListPropertyViewState extends ConsumerState<ListPropertyView> {

  @override
  void initState() {
    Future.microtask(() async {
      await ref.read(propertyViewModelProvider).fetchProperties();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    PropertyViewModel propertyVM = ref.watch(propertyViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w
          ),
          margin: EdgeInsets.only(top: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${greeting()}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: KColorScheme.grey,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                'Find your perfect dream space with just a few clicks.',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  color: KColorScheme.lightGrey,
                  fontSize: 13
                ),
              ),
              SizedBox(height: 24.h,),
              Row(
                children: [
                  Text(
                    'Properties',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: KColorScheme.black, fontWeight: FontWeight.w600
                    )
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, FilterPropertyView.routeName);
                    }, 
                    icon: Icon(
                      Icons.tune, 
                      size: 32.r,
                      color: KColorScheme.primary,
                    )
                  )
                ],
              ),
              SizedBox(height: 16.h,),
              Expanded(
                child: propertyVM.properties == null || propertyVM.isLoading 
                  ? const LoadingIndicator() 
                  : propertyVM.properties != null && propertyVM.properties!.isEmpty 
                    ? Center(
                        child: Text(
                          "No data",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      )
                    : ListView.builder(
                        itemCount: ref.watch(propertyViewModelProvider).properties!.length,
                        itemBuilder: (context, i) => PropertyCard(propertyVM.properties![i])
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: ,
        onPressed: () => Navigator.pushNamed(context, AddPropertyView.routeName),
        tooltip: 'add property',
        // backgroundColor: Colors.white,
        child: Icon(Icons.add, size: 30.r),
      ), 
    );
  }
}
