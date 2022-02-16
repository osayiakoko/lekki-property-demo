import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/views/add_property_view.dart';
import 'package:lekki_proj_demo/views/filter_property_view.dart';
import 'package:lekki_proj_demo/views/list_property_view.dart';
import 'package:lekki_proj_demo/views/property_details_view.dart';
import 'package:lekki_proj_demo/views/update_property_view.dart';

class AppRouter{

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case ListPropertyView.routeName:
        return _pageRoute(const ListPropertyView(), settings);

      case PropertyDetailsView.routeName:
        final arg = args as Property;
        return _pageRoute(PropertyDetailsView(arg), settings);

      case FilterPropertyView.routeName:
        return _pageRoute(const FilterPropertyView(), settings);

      case AddPropertyView.routeName:
        return _pageRoute(const AddPropertyView(), settings);

      case UpdateProperty.routeName:
        final arg = args as Property;
        return _pageRoute(UpdateProperty(arg), settings);

      default:
        return _pageRoute(_errorPage(routeName: settings.name), settings);
    }
  }

  // an errorPage likened to a 404 web page; helps in development.
  static Widget _errorPage({String message = "Error! Page not found", String? routeName}) =>
    Scaffold(
      appBar: AppBar(
          title: const Text(
            'Page not found',
            style: TextStyle(color: Colors.red),
          )),
      body: Center(
        child: Column(
          children: [
            Text(message,
              style: const TextStyle(color: Colors.red, fontSize: 40),
            ),
            const SizedBox(height: 20),
            Text("$routeName")
          ],
        ),
      ),
    );

  // view/page router
  static MaterialPageRoute _pageRoute(Widget child, RouteSettings settings){
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => child,
    );
  }
  
}
