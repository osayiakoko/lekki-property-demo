// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lekki_proj_demo/utils/getit_setup.dart';

// /// Handles navigation
// abstract class BaseNavigationHandler {
//   ///Pushes [destinationRoute] route onto the stack
//   Future<dynamic>? pushNamed(
//     String destinationRoute, {
//     dynamic arguments,
//   });

//   ///Pushes [destinationRoute] onto stack and removes stack items until
//   ///[lastRoute] is hit
//   Future<dynamic>? pushNamedAndRemoveUntil(
//     String destinationRoute, [RoutePredicate? routePredicate,
//     dynamic arguments]
//   );

//   ///Pushes [destinationRoute] onto stack with replacement
//   Future<dynamic>? pushReplacementNamed(
//     String destinationRoute, {
//     dynamic arguments,
//   });

//   ///Pushes [destinationRoute after popping current route off stack
//   Future<dynamic>? popAndPushNamed(
//     String destinationRoute, {
//     dynamic arguments,
//   });

//   ///Pops current route off stack
//   void goBack();

//   ///Pops routes on stack until [destinationRoute] is hit
//   void popUntil(String destinationRoute);

//   ///Exits app
//   void exitApp();

//   late GlobalKey<NavigatorState> navigatorKey;
// }


// class NavigationHandler implements BaseNavigationHandler {
//   @override
//   late GlobalKey<NavigatorState> navigatorKey;

//   /// Constructs a NavigationHandler instance
//   NavigationHandler({GlobalKey<NavigatorState>? navigatorKey}) {
//     this.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
//   }

//   NavigatorState? get state => navigatorKey.currentState;

//   @override
//   void exitApp() {
//     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//   }

//   @override
//   void goBack([dynamic data]) {
//     if (state != null) {
//       if (data != null){
//         return state!.pop(data);
//       }else{
//         return state!.pop();
//       }
//     }
//   }

//   @override
//   Future? popAndPushNamed(String destinationRoute, {arguments}) {
//     if (state != null) {
//       return state!.popAndPushNamed(destinationRoute, arguments: arguments);
//     }
//   }

//   @override
//   void popUntil(String destinationRoute) {
//     if (state != null) {
//       return state!.popUntil(ModalRoute.withName(destinationRoute));
//     }
//   }

//   @override
//   Future? pushNamed(String destinationRoute, {arguments}) {
//     if (state != null) {
//       return state!.pushNamed(destinationRoute, arguments: arguments);
//     }
//   }

//   @override
//   Future? pushNamedAndRemoveUntil(String destinationRoute, [RoutePredicate? routePredicate, arguments]) {
//     if (state != null) {
//       return state!.pushNamedAndRemoveUntil(
//         destinationRoute, 
//         routePredicate ?? (route) => false, 
//         arguments: arguments
//       );
//       // return state!.pushNamedAndRemoveUntil(
//       //   destinationRoute,
//       //   ModalRoute.withName(lastRoute),
//       //   arguments: arguments,
//       // );
//     }
//   }

//   @override
//   Future? pushReplacementNamed(String destinationRoute, {arguments}) {
//     if (state != null) {
//       return state!.pushReplacementNamed(destinationRoute, arguments: arguments);
//     }
//   }
// }


// NavigationHandler navigationHandler = getIt<NavigationHandler>();
