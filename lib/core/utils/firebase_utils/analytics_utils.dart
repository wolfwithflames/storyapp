// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// import '../utils/storage_utils.dart';

// class AppAnalytics {
//   AppAnalytics._();

//   static FirebaseCrashlytics get crashlytic => FirebaseCrashlytics.instance;
//   static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

//   /// Sets the user identifier for Crashlytics.
//   ///
//   /// Retrieves the user data from storage and sets the user identifier for Crashlytics
//   /// if the user data is not null.
//   ///
//   /// @return A [Future] that completes when the user identifier is set.
//   static Future<void> setUserIdentifier() async {
//     final userData = Storage.getUserData();
//     if (userData != null) {
//       await crashlytic.setUserIdentifier(userData.id.toString());
//     }
//   }

//   /// Logs a screen view event to Firebase Analytics.
//   ///
//   /// This method logs a screen view event to Firebase Analytics with the given [routeName].
//   /// The event name is set to 'screen_view' and the parameters include the [routeName] as the 'firebase_screen'.
//   /// This is useful for tracking user navigation within the app.
//   /// Params:
//   ///   - [routeName]: The name of the route or screen being viewed.

//   static logScreenView(String routeName) {
//     analytics.logEvent(
//       name: 'app_screen_view',
//       parameters: {
//         'app_screen': routeName,
//       },
//     );
//   }
// }
