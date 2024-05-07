import 'dart:async';
import 'dart:io';

import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../getIt.dart';
import '../router/router.dart';

/// A class representing the `SharingIntent`.
///
/// This class is responsible for handling media sharing intents coming from outside the app.
/// It provides methods to start listening for media sharing intents and route them to the appropriate destination.
///
/// Example usage:
///
/// ```dart
/// SharingIntent sharingIntent = SharingIntent();
/// sharingIntent.startMediaSaringIntent();
/// ```
///
/// Note: This class requires the `media_picker_widget` and `receive_sharing_intent` packages to be imported.
///
/// See also:
///
/// - [MediaPickerWidget](https://pub.dev/packages/media_picker_widget), a package for picking media files.
/// - [ReceiveSharingIntent](https://pub.dev/packages/receive_sharing_intent), a package for receiving sharing intents.

class SharingIntent {
  late StreamSubscription _intentSub;

  startMediaSaringIntent() {
    // Listen to media sharing coming from outside the app while the app is in the memory.
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      if (value.isNotEmpty) {
        routeToAddStory(
          media: Media(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            file: File(value.first.path),
          ),
        );
      }
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      // Tell the library that we are done processing the intent.
      ReceiveSharingIntent.instance.reset();
    });
  }

  Future<void> routeToAddStory({Media? media}) async {
    final result =
        await getIt<AppRouter>().push<bool?>(AddStoryRoute(media: media));
    if (result != null && result) {
      getIt<AppRouter>().maybePop();
    }
  }
}
