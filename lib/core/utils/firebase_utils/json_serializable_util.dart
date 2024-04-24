// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:thespeedturtleapp/app/model/sendbird_push_notification/sendbird.dart';

// import '../data/enums.dart';
// import '../logger/app_logger.dart';

// class JsonSerializableUtils {
//   static NotificationType? notificationEnumDecode(String? value) {
//     try {
//       return $enumDecodeNullable(notificationTypeEnumMap, value);
//     } on ArgumentError catch (e) {
//       AppLog.e(e);
//       return NotificationType.reminderTime;
//     } catch (e) {
//       AppLog.e(e);
//       return NotificationType.reminderTime;
//     }
//     // return null;
//   }

//   static final notificationTypeEnumMap = {
//     NotificationType.alignmentRequest: 'ALIGNMENT_REQUEST',
//     NotificationType.gamificationRequest: 'GAMIFICATION_REQUEST',
//     NotificationType.lifelineRequest: 'LIFELINE_REQUEST',
//     NotificationType.proofValidate: 'PROOF_VALIDATE',
//     NotificationType.reminderAdded: 'REMINDER_ADDED',
//     NotificationType.supportPartners: 'SUPPORT_PARTNERS',
//     NotificationType.actionItemsAdded: 'ACTION_ITEMS_ADDED',
//     NotificationType.userSharkAssigned: 'USER_SHARK_ASSIGNED',
//     NotificationType.communityCreated: 'COMMUNITY_CREATED',
//     NotificationType.alignmentChecked: 'ALIGNMENT_CHECKED',
//     NotificationType.gamificationChecked: 'GAMIFICATION_CHECKED',
//     NotificationType.lifelineChecked: 'LIFELINE_CHECKED',
//     NotificationType.proofChecked: 'PROOF_CHECKED',
//     NotificationType.reminderTime: 'REMINDER_TIME',
//     NotificationType.lifelineAdded: 'LIFELINE_ADDED',
//     NotificationType.goldPoint: 'GOLD_POINT',
//     NotificationType.breakThrough: 'BREAKTHROUGH',
//   };

//   static double? doubleParse(value) {
//     try {
//       return value.toDouble();
//     } catch (e) {
//       return null;
//     }
//   }

//   static int? intParse(value) {
//     try {
//       return value.toInt();
//     } catch (e) {
//       return null;
//     }
//   }

//   static int? doubleToIntParse(value) {
//     try {
//       if (value == null) {
//         return null;
//       }

//       return int.tryParse(value);
//     } catch (e) {
//       return null;
//     }
//   }

//   static jsonDecode(String value) {
//     final jsonData = json.decode(value);
//     return Sendbird.fromJson(jsonData);
//   }

//   static Duration intToSecondsDuration(int? value) {
//     final durationInMs = ((value ?? 0).toDouble() * 1000).floor();
//     return Duration(milliseconds: durationInMs);
//   }

//   static int durationToSeconds(Duration? value) {
//     return value?.inSeconds ?? 0;
//   }

//   static DateTime? timestampToDateTime(dynamic val) {
//     if (val == null) {
//       return null;
//     }
//     if (val != null && val is num) {
//       return DateTime.fromMillisecondsSinceEpoch(val.toInt());
//     }
//     if (val != null && val is Timestamp) {
//       return DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);
//     }
//     if (val != null && val is Map<String, dynamic>) {
//       Timestamp timestamp = Timestamp(val["_seconds"], val["_nanoseconds"]);
//       return DateTime.fromMillisecondsSinceEpoch(
//           timestamp.millisecondsSinceEpoch);
//     }
//     if (val != null && val is String) {
//       if (val.startsWith("{")) {
//         var map = jsonDecode(val);
//         if (map is Map) {
//           Timestamp timestamp = Timestamp(map["_seconds"], map["_nanoseconds"]);
//           return DateTime.fromMillisecondsSinceEpoch(
//               timestamp.millisecondsSinceEpoch);
//         }
//       } else {
//         try {
//           DateTime dateTime = DateTime.parse(val);
//           return dateTime;
//         } catch (e) {
//           AppLog.d(e);
//           return DateTime.now();
//         }
//       }
//     }
//     return null;
//   }

//   static bool? parseBool(dynamic value) {
//     return value.toString() == "1";
//   }

//   static int boolToInt(bool? value) {
//     return value != null
//         ? value
//             ? 1
//             : 0
//         : 0;
//   }

//   static int? dateTimeToTimestamp(DateTime? time) =>
//       time?.millisecondsSinceEpoch;

//   static dynamic dateTimeToTimestampOrServerTime(DateTime? time) => time != null
//       ? Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch)
//       : FieldValue.serverTimestamp();

//   static String checkString(String? value) {
//     if (value != null) {
//       return value;
//     } else {
//       return '';
//     }
//   }

//   static GamificationStatus? gamificationStatusFromJson(String val) {
//     switch (val) {
//       case 'pending':
//         return GamificationStatus.pending;

//       case 'requested':
//         return GamificationStatus.requested;

//       case 'approved':
//         return GamificationStatus.approved;

//       case 'completed':
//         return GamificationStatus.completed;

//       case 'finished':
//         return GamificationStatus.finished;

//       case 'rejected':
//         return GamificationStatus.rejected;
//     }
//     return null;
//   }

//   static LifelineStatus lifelineStatusFromJson(int val) {
//     switch (val) {
//       case 1:
//         return LifelineStatus.pending;

//       case 2:
//         return LifelineStatus.approved;

//       case 3:
//         return LifelineStatus.rejected;

//       default:
//         return LifelineStatus.pending;
//     }
//   }

//   static int lifeLineStatusToJson(LifelineStatus val) {
//     return switch (val) {
//       LifelineStatus.pending => 1,
//       LifelineStatus.approved => 2,
//       LifelineStatus.rejected => 3
//     };
//   }

//   static int enumToInt(Gender val) {
//     return switch (val) {
//       Gender.male => 1,
//       Gender.female => 2,
//       Gender.other => 3
//     };
//   }

//   static Gender intToStringGender(int val) {
//     switch (val) {
//       case 1:
//         return Gender.male;
//       case 2:
//         return Gender.female;
//       case 3:
//         return Gender.other;
//       default:
//         return Gender.male;
//     }
//   }

//   static DateTime? checkDateTime(String? value) {
//     if (value != null) {
//       return DateFormat('dd-MM-yyyy').parse(value);
//     }
//     return null;
//   }

//   static List<String> checkArray(List<dynamic>? value) {
//     if (value != null) {
//       return value.map((e) => e.toString()).toList();
//     } else {
//       return <String>[];
//     }
//   }

//   static GeoPoint? fromJsonGeoPoint(dynamic geoPoint) {
//     if (geoPoint != null && geoPoint is GeoPoint) {
//       return geoPoint;
//     }
//     if (geoPoint != null && geoPoint is Map<String, dynamic>) {
//       return GeoPoint(geoPoint["_latitude"], geoPoint["_longitude"]);
//     }
//     return null;
//   }

//   static Map<String, dynamic> toJsonGeoPoint(GeoPoint? geoPoint) {
//     return {
//       "latitude": geoPoint?.latitude,
//       "longitude": geoPoint?.longitude,
//     };
//   }

//   static bool checkBool(bool? value) {
//     if (value != null) {
//       return value;
//     } else {
//       return false;
//     }
//   }

//   static num checkNum(num? value, {num defaultValue = 0}) {
//     if (value != null) {
//       return num.parse(value.toString());
//     }
//     return defaultValue;
//   }

//   static int checkInt(int? value, {int defaultValue = 0}) {
//     if (value != null) {
//       return int.parse(value.toString());
//     }
//     return defaultValue;
//   }

//   static int? genderToInt(Gender? gender) {
//     if (gender != null) {
//       return gender == Gender.male
//           ? 1
//           : gender == Gender.female
//               ? 2
//               : 0;
//     }
//     return 0;
//   }

//   static Gender intToGender(int? gender) {
//     if (gender != null) {
//       return gender == 1
//           ? Gender.male
//           : gender == 2
//               ? Gender.female
//               : Gender.other;
//     } else {
//       return Gender.other;
//     }
//   }

//   /// The function converts a CommunitySubscriptionIntervalType enum value into a
//   /// corresponding string representation.
//   /// Args:
//   ///   communitySubscriptionPlanType (CommunitySubscriptionIntervalType): The
//   /// parameter `communitySubscriptionPlanType` is of type
//   /// `CommunitySubscriptionIntervalType?`, which means it is an optional enum value
//   /// of type `CommunitySubscriptionIntervalType`.
//   /// Returns:
//   ///   The method returns a string representing the interval type of a community
//   /// subscription plan.
//   static String? communitySubscriptionIntervalTypeToString(
//       CommunitySubscriptionIntervalType? communitySubscriptionPlanType) {
//     if (communitySubscriptionPlanType != null) {
//       return communitySubscriptionPlanType ==
//               CommunitySubscriptionIntervalType.halfYear
//           ? "6 Month"
//           : communitySubscriptionPlanType ==
//                   CommunitySubscriptionIntervalType.annual
//               ? "Annual"
//               : communitySubscriptionPlanType ==
//                       CommunitySubscriptionIntervalType.quarterly
//                   ? "Quarterly"
//                   : "Month";
//     }
//     return "Month";
//   }

//   /// The function converts an integer value to a corresponding
//   /// CommunitySubscriptionIntervalType enum value in Dart.
//   ///
//   /// Args:
//   ///   value (int): An integer value representing the subscription interval type.
//   ///
//   /// Returns:
//   ///   The method is returning a value of type
//   /// `CommunitySubscriptionIntervalType?`.
//   static CommunitySubscriptionIntervalType?
//       intToCommunitySubscriptionIntervalType(int? value) {
//     if (value != null) {
//       return value == 1
//           ? CommunitySubscriptionIntervalType.month
//           : value == 2
//               ? CommunitySubscriptionIntervalType.annual
//               : value == 3
//                   ? CommunitySubscriptionIntervalType.quarterly
//                   : CommunitySubscriptionIntervalType.halfYear;
//     }
//     return CommunitySubscriptionIntervalType.month;
//   }

//   /// The function converts a CommunitySubscriptionIntervalType enum value to an
//   /// integer representation.
//   ///
//   /// Args:
//   ///   communitySubscriptionPlanType (CommunitySubscriptionIntervalType): A
//   /// nullable enum variable of type CommunitySubscriptionIntervalType.
//   ///
//   /// Returns:
//   ///   The method returns an integer value.
//   static int? communitySubscriptionIntervalTypeToInt(
//       CommunitySubscriptionIntervalType? communitySubscriptionPlanType) {
//     if (communitySubscriptionPlanType != null) {
//       return communitySubscriptionPlanType ==
//               CommunitySubscriptionIntervalType.month
//           ? 1
//           : communitySubscriptionPlanType ==
//                   CommunitySubscriptionIntervalType.annual
//               ? 2
//               : communitySubscriptionPlanType ==
//                       CommunitySubscriptionIntervalType.quarterly
//                   ? 3
//                   : 4;
//     }
//     return 1;
//   }

//   /// The function converts a CommunitySubscriptionPlanType enum value into a
//   /// corresponding string representation.
//   ///
//   /// Args:
//   ///   communitySubscriptionPlanType (CommunitySubscriptionPlanType): The parameter
//   /// `communitySubscriptionPlanType` is of type `CommunitySubscriptionPlanType?`,
//   /// which means it is an optional value of the `CommunitySubscriptionPlanType`
//   /// enum.
//   ///
//   /// Returns:
//   ///   The method is returning a string representation of the given
//   /// CommunitySubscriptionPlanType. If the given plan type is not null, it will
//   /// return "Basic Membership" if the plan type is basicMembership, "Pro
//   /// Membership" if the plan type is proMembership, and "Premium" for any other
//   /// plan type. If the given plan type is null, it will return "Basic Membership".
//   static String? communitySubscriptionPlanTypeToString(
//       CommunitySubscriptionPlanType? communitySubscriptionPlanType) {
//     if (communitySubscriptionPlanType != null) {
//       return communitySubscriptionPlanType ==
//               CommunitySubscriptionPlanType.basicMembership
//           ? "Basic Membership"
//           : communitySubscriptionPlanType ==
//                   CommunitySubscriptionPlanType.proMembership
//               ? "Pro Membership"
//               : "Premium";
//     }
//     return "Basic Membership";
//   }

//   /// The function converts a CommunitySubscriptionPlanType enum value to an integer
//   /// representation.
//   /// Args:
//   ///   communitySubscriptionPlanType (CommunitySubscriptionPlanType): A nullable
//   /// enum variable of type CommunitySubscriptionPlanType.
//   /// Returns:
//   ///   The method returns an integer value.
//   static int? communitySubscriptionPlanTypeToInt(
//       CommunitySubscriptionPlanType? communitySubscriptionPlanType) {
//     if (communitySubscriptionPlanType != null) {
//       return communitySubscriptionPlanType ==
//               CommunitySubscriptionPlanType.basicMembership
//           ? 1
//           : communitySubscriptionPlanType ==
//                   CommunitySubscriptionPlanType.proMembership
//               ? 2
//               : 3;
//     }
//     return 1;
//   }

//   /// The function converts an integer value to a corresponding
//   /// CommunitySubscriptionPlanType enum value.
//   /// Args:
//   ///   value (int): The "value" parameter is an integer value that represents the
//   /// subscription plan type for a community subscription.
//   /// Returns:
//   ///   The method is returning a value of type CommunitySubscriptionPlanType.
//   static CommunitySubscriptionPlanType intToCommunitySubscriptionPlanType(
//       int? value) {
//     if (value != null) {
//       return value == 1
//           ? CommunitySubscriptionPlanType.basicMembership
//           : value == 2
//               ? CommunitySubscriptionPlanType.proMembership
//               : CommunitySubscriptionPlanType.premium;
//     } else {
//       return CommunitySubscriptionPlanType.basicMembership;
//     }
//   }

//   static int? proofCheckToInt(ProofCheck? proofCheck) {
//     if (proofCheck != null) {
//       return proofCheck == ProofCheck.checked ? 1 : 0;
//     }
//     return 0;
//   }

//   static ProofCheck intToProofCheck(int? proofCheck) {
//     if (proofCheck != null) {
//       return proofCheck == 1 ? ProofCheck.remaining : ProofCheck.checked;
//     }
//     return ProofCheck.remaining;
//   }

//   static int? proofStatusToInt(ProofStatus? proofCheck) {
//     try {
//       if (proofCheck != null) {
//         if (proofCheck == ProofStatus.approved) {
//           return 1;
//         }
//         if (proofCheck == ProofStatus.rejected) {
//           return 0;
//         }
//       }
//     } catch (e) {
//       AppLog.d(e);
//     }
//     return -1;
//   }

//   static ProofStatus intToProofStatus(var proofCheck) {
//     if (proofCheck is int) {
//       if (proofCheck == 1) {
//         return ProofStatus.pending;
//       }
//       if (proofCheck == 2) {
//         return ProofStatus.underReview;
//       }
//       if (proofCheck == 3) {
//         return ProofStatus.approved;
//       }
//       if (proofCheck == 4) {
//         return ProofStatus.rejected;
//       }
//     }
//     return ProofStatus.pending;
//   }

//   static ActionItemType stringToTask(String? type) {
//     if (type != null) {
//       if (type == ActionItemType.habit.name) {
//         return ActionItemType.habit;
//       }
//       if (type == ActionItemType.task.name) {
//         return ActionItemType.task;
//       }
//       return ActionItemType.task;
//     }
//     return ActionItemType.task;
//   }

//   static String workTypeToString(ActionItemType? type) {
//     if (type != null) {
//       return type.name;
//     }
//     return ActionItemType.task.name;
//   }

//   static String intToReminderString(int reminderType) {
//     switch (reminderType) {
//       case 0:
//         return "SMS";
//       case 1:
//         return "Push Notification";
//       case 2:
//         return "Email";
//       case 3:
//         return "Calender";
//       case 4:
//         return "Whatsapp";
//       default:
//         return "SMS";
//     }
//   }

//   static GamificationStatus? gamificationStatus(int? reminderType) {
//     return switch (reminderType) {
//       0 => GamificationStatus.none,
//       1 => GamificationStatus.pending,
//       2 => GamificationStatus.requested,
//       3 => GamificationStatus.approved,
//       4 => GamificationStatus.rejected,
//       5 => GamificationStatus.finished,
//       6 => GamificationStatus.completed,
//       _ => null
//     };
//   }

//   static int? gamificationStatusInt(GamificationStatus? reminderType) {
//     return switch (reminderType) {
//       GamificationStatus.none => 0,
//       GamificationStatus.pending => 1,
//       GamificationStatus.requested => 2,
//       GamificationStatus.approved => 3,
//       GamificationStatus.rejected => 4,
//       GamificationStatus.finished => 5,
//       GamificationStatus.completed => 6,
//       _ => null,
//     };
//   }

//   static LoginPlatform loginPlatform(String? reminderType) {
//     return switch (reminderType) {
//       "phone" => LoginPlatform.phone,
//       "google" => LoginPlatform.google,
//       "facebook" => LoginPlatform.facebook,
//       "apple" => LoginPlatform.apple,
//       _ => LoginPlatform.phone
//     };
//   }

//   static GpTransactionType? parseGpTransaction(int? val) {
//     return switch (val) {
//       1 => GpTransactionType.task,
//       2 => GpTransactionType.habit,
//       3 => GpTransactionType.goal,
//       4 => GpTransactionType.speedTurtle,
//       5 => GpTransactionType.bought,
//       6 => GpTransactionType.redeemed,
//       7 => GpTransactionType.barrier,
//       8 => GpTransactionType.communityBalance,
//       _ => null,
//     };
//   }

//   static int? transactionTypetoInt(GpTransactionType? val) {
//     return switch (val) {
//       GpTransactionType.task => 1,
//       GpTransactionType.habit => 2,
//       GpTransactionType.goal => 3,
//       GpTransactionType.speedTurtle => 4,
//       GpTransactionType.bought => 5,
//       GpTransactionType.redeemed => 6,
//       GpTransactionType.barrier => 7,
//       GpTransactionType.communityBalance => 8,
//       _ => null,
//     };
//   }

//   static int? resourceTypeToInt(ResourceType? val) {
//     return switch (val) {
//       ResourceType.link => 1,
//       ResourceType.tools => 2,
//       ResourceType.books => 3,
//       ResourceType.videos => 4,
//       ResourceType.documents => 5,
//       ResourceType.formAndQuiz => 6,
//       ResourceType.trainingMaterial => 7,
//       _ => null,
//     };
//   }

//   static int getUserType(
//       {required bool isCommunitySharkResource,
//       required bool info,
//       required bool isShark,
//       bool isPersonalResource = false}) {
//     return info
//         ? 2
//         : isPersonalResource
//             ? 1
//             : isCommunitySharkResource || isShark
//                 ? 3
//                 : 4;
//   }

//   static CommunityType? communityTypeEnumDecode(String value) {
//     try {
//       return $enumDecodeNullable(communityTypeEnumMap, value);
//     } on ArgumentError catch (e) {
//       AppLog.e(e);
//       return null;
//     } catch (e) {
//       AppLog.e(e);
//       return null;
//     }
//     // return null;
//   }

//   static ActionItemType? gameTypeToActionItemType(GameActionItemType item) {
//     return switch (item) {
//       GameActionItemType.habit => ActionItemType.habit,
//       GameActionItemType.task => ActionItemType.task,
//       _ => ActionItemType.goal,
//     };
//   }
// }
