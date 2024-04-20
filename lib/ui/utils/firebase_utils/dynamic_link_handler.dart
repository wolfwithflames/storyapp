// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:thespeedturtleapp/app/model/sub_group/get_sub_group.dart';
// import 'package:thespeedturtleapp/app/utils/app_strings.dart';
// import 'package:thespeedturtleapp/app/utils/app_utils.dart';
// import 'package:thespeedturtleapp/app/utils/storage_utils.dart';
// import 'package:thespeedturtleapp/app/widgets/raised_button.dart';
// import 'package:thespeedturtleapp/app/widgets/text_view.dart';
// import 'package:thespeedturtleapp/app/ws/api_repository.dart';
// import 'package:thespeedturtleapp/app/ws/api_response.dart';
// import 'package:thespeedturtleapp/app/ws/community/community_api_repository.dart';

// import '../logger/app_logger.dart';
// import '../model/community_item/get_community_model.dart';
// import '../routes/app_pages.dart';
// import '../services/app_services.dart';

// class DynamicLinkHandler {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

//   Future<void> initDynamicLinks() async {
//     AppLog.i("Starting dynamic links listener");
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       // Listen and retrieve dynamic links here
//       final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
//       // Ex: https://namnp.page.link/product/013232
//       final Map<String, String> queryParameters =
//           dynamicLinkData.link.queryParameters; // Get PATH

//       if (deepLink.isEmpty) return;
//       handleDeepLink(queryParameters);
//     }).onError((error) {
//       AppLog.e('onLink error');
//       AppLog.e(error.message);
//     });
//     initUniLinks();
//   }

//   Future<void> initUniLinks() async {
//     try {
//       final initialLink = await dynamicLinks.getInitialLink();
//       if (initialLink == null) return;
//       handleDeepLink(initialLink.link.queryParameters);
//     } catch (e) {
//       // Error
//     }
//   }

//   Future<void> handleDeepLink(Map<String, String> data) async {
//     // navigate to specific screen location
//     AppLog.prettyPrint(data);
//     if (data.isNotEmpty && data.containsKey("link_type")) {
//       switch (data['link_type']) {
//         case 'INVITE_COMMUNITY':
//           AppService.instance.selectedCommunity.value =
//               CommunityItem(id: int.tryParse(data['community_id'] as String));
//           if (data.containsKey("community_type") &&
//               data['community_type'] == '4') {
//             Get.toNamed(Routes.gameroomInfo, arguments: {"is_invited": true})
//                 ?.then((value) =>
//                     AppService.instance.selectedCommunity.value = null);
//           } else {
//             Get.toNamed(Routes.aboutCommunity, arguments: {"is_invited": true})
//                 ?.then((value) =>
//                     AppService.instance.selectedCommunity.value = null);
//           }
//           break;
//         case 'INVITE_COMMUNITY_SUB_GROUP':
//           int? channelId = int.tryParse(data['channel_id'] as String);
//           int? communityId = int.tryParse(data['community_id'] as String);

//           if (channelId != null && communityId != null) {
//             await subGroupInvitationManage(channelId, communityId);
//           } else {
//             Get.offAllNamed(Routes.home);
//           }
//           break;
//         case 'TOWNHALL_SHARE':
//           Get.toNamed(Routes.townHallSinglePost, arguments: {
//             "isSinglePost": true,
//             "singlePostId": int.parse(data['post_id'].toString()),
//             "singlePostCommunityId": int.parse(data['community_id'].toString())
//           });
//           break;

//         default:
//       }
//     }
//   }

//   ///sub group invitation dialog and screen manage
//   Future subGroupInvitationManage(int channelId, int communityId) async {
//     Map<String, dynamic> bodyData = {
//       "community_id": communityId,
//       "type": 4,
//       "id": channelId,
//     };
//     SubGroupDetails apiResponse = await ApiRepository.instance
//         .getSubGroupDetails(data: bodyData, showProgress: true);
//     if (apiResponse.status == 1 && apiResponse.data != null) {
//       bool isUserAlreadyInGroup = apiResponse.data?.members
//               ?.where((e) => e.user?.id == Storage.getUserData()?.id?.toInt())
//               .isNotEmpty ??
//           false;
//       if (isUserAlreadyInGroup) {
//         Get.offAllNamed(Routes.home);
//         AppUtility.showSnackBar(message: "You are already in group");
//         return;
//       } else {
//         AppUtility.showDynamicWidgetDialogue(
//           cancelable: false,
//           title: TextView(
//             apiResponse.data?.groupName,
//             fontSize: 15,
//             fontWeight: FontWeight.w700,
//             maxLines: 2,
//             textOverflow: TextOverflow.ellipsis,
//           ),
//           content: SizedBox(
//             width: Get.width,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const TextView(
//                   AppStrings.areYouWantToJoinThisGroup,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   maxLines: 2,
//                   textOverflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 TextView(
//                   "${AppStrings.totalTurtles} : ${apiResponse.data?.members?.length ?? 0}",
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   maxLines: 2,
//                   textOverflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: AppRaisedButton(
//                           title: AppStrings.cancel,
//                           onPressed: () {
//                             Get.back();
//                             Get.back();
//                           },
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: AppRaisedButton(
//                           title: AppStrings.confirm,
//                           onPressed: () async {
//                             Map<String, dynamic> bodyData = {
//                               "community_id": communityId,
//                               "type": 1,
//                               "user_ids": [
//                                 Storage.getUserData()?.id?.toInt() ?? 0
//                               ],
//                               "channel_url": apiResponse.data?.channelUrl
//                             };
//                             APIResponse<dynamic> response = await ApiRepository
//                                 .instance
//                                 .addDeleteCommunitySubGroupMember(
//                                     data: bodyData, showProgress: true);
//                             Get.back();
//                             if (response.success && response.data != null) {
//                               Get.close(1);
//                               AppUtility.showSnackBar(
//                                   message:
//                                       AppStrings.communitySubGroupMemberAddMsg,
//                                   isSuccess: true);
//                             } else {
//                               Get.back();
//                               AppUtility.showSnackBar(
//                                   message: response.message);
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     } else {
//       Get.offAllNamed(Routes.home);
//       AppUtility.showSnackBar(message: apiResponse.message);
//     }
//   }
// }
