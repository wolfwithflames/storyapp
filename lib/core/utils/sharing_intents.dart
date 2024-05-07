import 'dart:async';
import 'dart:io';

import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../getIt.dart';
import '../router/router.dart';

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
