import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/utils/app_router.dart';
import 'package:lekki_proj_demo/utils/getit_setup.dart';
import 'package:lekki_proj_demo/views/list_property_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // setup locators
  await getItSetup();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  ).then((val) => runApp(
    const ProviderScope(
      child: MyApp()
    ))
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lekki Property Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: 'Montserrat'
        ),
        home: const ListPropertyView(),
        onGenerateRoute: AppRouter.generateRoute,
      )
    );
  }
}
