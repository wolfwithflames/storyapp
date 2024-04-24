// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:get/get.dart';
// import 'package:thespeedturtleapp/app/utils/app_utils.dart';

// class FirebaseDynamicLink {
//   String uriPrefix = 'https://speedturtleapp.page.link';

//   Future<Uri?> generateShareLink(String pageUrl, imageUrl, title, desc,
//       {bool showProgress = true}) async {
//     if (showProgress) {
//       await AppUtility.showProgressDialog();
//     }
//     DynamicLinkParameters linkParameters = DynamicLinkParameters(
//       uriPrefix: uriPrefix,
//       link: Uri.parse(pageUrl),
//       androidParameters:
//           const AndroidParameters(packageName: 'com.speedturtle.app'),
//       iosParameters: const IOSParameters(bundleId: 'com.speedturtle.app'),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         description: desc,
//         imageUrl: Uri.parse(imageUrl),
//       ),
//     );
//     Uri shareLink;
//     ShortDynamicLink shortDynamicLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(linkParameters);
//     shareLink = shortDynamicLink.shortUrl;

//     if (showProgress) {
//       Get.close(1);
//     }

//     return shareLink;
//   }
// }
