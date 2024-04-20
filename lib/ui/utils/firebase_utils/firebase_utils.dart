import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/logger/app_logger.dart';
import 'auth_response.dart';

/// This class represents a utility class for Firebase operations.
class FirebaseUtils {
  /// The static instance of the [FirebaseUtils] class.
  static FirebaseUtils instance = FirebaseUtils();

  /// The Firebase Authentication instance.
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// This method initiates the phone authentication process by calling the `verifyPhoneNumber` method from the `firebaseAuth` instance.
  /// It handles any exceptions that may occur during the authentication process and returns an `AuthResponse` object.
  ///
  /// Example Usage:
  /// ```dart
  /// String phoneNumber = '+1234567890';
  /// Function(PhoneAuthCredential) verificationCompleted = (credential) {
  ///   // handle verification completed
  /// };
  /// Function(FirebaseAuthException) verificationFailed = (exception) {
  ///   // handle verification failed
  /// };
  /// Function(String, int?) codeSent = (verificationId, forceResendingToken) {
  ///   // handle code sent
  /// };
  /// Function(String) codeAutoRetrievalTimeout = (verificationId) {
  ///   // handle code auto retrieval timeout
  /// };
  ///
  /// AuthResponse response = await FirebaseUtils.instance.signInWithPhone(
  ///   phoneNumber: phoneNumber,
  ///   verificationCompleted: verificationCompleted,
  ///   verificationFailed: verificationFailed,
  ///   codeSent: codeSent,
  ///   codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  ///   forceResendingToken: null,
  /// );
  /// ```
  ///
  /// Inputs:
  /// - `phoneNumber` (String): The phone number to be verified.
  /// - `verificationCompleted` (Function): A callback function that is called when the phone number verification is completed successfully.
  /// - `verificationFailed` (Function): A callback function that is called when the phone number verification fails.
  /// - `codeSent` (Function): A callback function that is called when the verification code is sent to the user's phone.
  /// - `codeAutoRetrievalTimeout` (Function): A callback function that is called when the verification code auto retrieval timeout occurs.
  /// - `forceResendingToken` (int, optional): A token that can be used to force resending the verification code. Defaults to null.
  ///
  /// Outputs:
  /// - Returns a `Future<AuthResponse>` object that represents the result of the phone authentication process.
  ///   The `AuthResponse` object contains information about any error that occurred during the authentication process.
  Future<AuthResponse> signInWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    dynamic error;
    try {
      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        forceResendingToken: forceResendingToken,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration.zero,
      );
    } on FirebaseAuthException catch (e) {
      error = e;
      AppLog.e("$error");
      return AuthResponse.fromData(error: AuthResponse.getErrorString(error));
    } catch (e) {
      error = e;
      AppLog.e("$error");
      return AuthResponse.fromData(error: AuthResponse.getErrorString(error));
    }
    AppLog.e("$error");
    return AuthResponse.fromData(error: error);
  }

  /// Verifies the OTP (One-Time Password) entered by the user.
  ///
  /// This method uses the `signInWithCredential` method from the `firebaseAuth` instance to sign in the user with the provided verification code and OTP.
  ///
  /// Example Usage:
  /// ```dart
  /// String otp = '123456';
  /// String verificationCode = 'abcdefg';
  ///
  /// UserCredential? userCredential = await verifyOtp(otp, verificationCode);
  /// if (userCredential != null) {
  ///   // User is successfully signed in
  /// } else {
  ///   // Verification failed
  /// }
  /// ```
  ///
  /// Inputs:
  /// - `otp` (String): The OTP entered by the user.
  /// - `verificationCode` (String): The verification code received from the phone authentication process.
  ///
  /// Outputs:
  /// - Returns a `UserCredential` object if the sign-in is successful.
  /// - Returns `null` if the sign-in is not successful or an error occurs.
  Future<UserCredential?> verifyOtp(
    String otp,
    String verificationCode, {
    bool showLoader = true,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode,
          smsCode: otp,
        ),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      AppLog.d(e);

      throw AuthResponse.getErrorString(e);
    } catch (e) {
      AppLog.d(e);
    }
    return null;
  }

  /// Uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  ///
  /// Example Usage:
  /// ```dart
  /// File file = File('path/to/file');
  /// String path = 'images';
  /// String? fileName = 'image.jpg';
  ///
  /// String? downloadUrl = await uploadFile(file: file, path: path, fileName: fileName);
  /// AppLog.d(downloadUrl);
  /// ```
  ///
  /// Inputs:
  /// - `file` (required): The file to be uploaded.
  /// - `path` (required): The path in Firebase Storage where the file will be stored.
  /// - `fileName` (optional): The name of the file in Firebase Storage. If not provided, the name will be derived from the original file name.
  ///
  /// Flow:
  /// 1. Check if the `file` is not null.
  /// 2. Modify the `path` by prefixing it with "v2/".
  /// 3. Create a `TaskSnapshot` by uploading the `file` to the Firebase Storage using the modified `path` and `fileName`.
  /// 4. Check if the upload was successful by verifying the `state` of the `snapshot`.
  /// 5. If the upload was successful, retrieve the download URL of the uploaded file using `snapshot.ref.getDownloadURL()`.
  /// 6. Return the download URL.
  ///
  /// Outputs:
  /// - Returns the download URL of the uploaded file if the upload was successful. Otherwise, returns null.
  // Future<String?> uploadFile({
  //   required File? file,
  //   required String path,
  //   String? fileName,
  //   String? mimeType,
  // }) async {
  //   try {
  //     if (file != null) {
  //       path = "v2/$path";
  //       var mime = mimeType ?? lookupMimeType(path);

  //       TaskSnapshot snapshot = await firebaseStorageInstance
  //           .child(path)
  //           .child(fileName ?? path.split(".").first)
  //           .putFile(file, SettableMetadata(contentType: mime));
  //       if (snapshot.state == TaskState.success) {
  //         final String downloadUrl = await snapshot.ref.getDownloadURL();
  //         return downloadUrl;
  //       }
  //     }
  //   } catch (e) {
  //     AppLog.d(e);
  //   }
  //   return null;
  // }

  /// Retrieves the Firebase Cloud Messaging (FCM) token.
  ///
  /// This method asynchronously retrieves the FCM token using the `getToken()` method from the `messagingInstance`.
  /// If the token is successfully retrieved, it is returned as a `String`.
  /// If an error occurs during the retrieval process, `null` is returned.
  ///
  /// Example Usage:
  /// ```dart
  /// String? fcmToken = await getFcmToken();
  /// if (fcmToken != null) {
  ///   // FCM token retrieved successfully
  /// } else {
  ///   // Error occurred while retrieving FCM token
  /// }
  /// ```
  ///
  /// Outputs:
  /// - Returns the FCM token as a `String` if the retrieval is successful.
  /// - Returns `null` if an error occurs during the retrieval process.
  // Future<String?> getFcmToken() async {
  //   try {
  //     return await messagingInstance.getToken();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  /// Retrieves the APNS (Apple Push Notification Service) token.
  ///
  /// This method asynchronously retrieves the APNS token using the `getAPNSToken()` method from the `messagingInstance`.
  /// If the token is successfully retrieved, it is returned as a `String`.
  /// If an error occurs during the retrieval process, `null` is returned.
  ///
  /// Outputs:
  /// - Returns the APNS token as a `String` if the retrieval is successful.
  /// - Returns `null` if an error occurs during the retrieval process.
  // Future<String?> getAPNSToken() async {
  //   try {
  //     return await messagingInstance.getAPNSToken();
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
