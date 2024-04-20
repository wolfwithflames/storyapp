import 'dart:async';

import 'package:logging/logging.dart';
import 'package:storyapp/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:storyapp/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:storyapp/core/models/snack_bar_response/snack_bar_response.dart';
import 'package:storyapp/core/services/snackbar/snack_bar_service.dart';
import 'package:storyapp/getIt.dart';

import '../../logger/app_logger.dart';
import '../../router/router.dart';

/// A service that is responsible for returning future snackbar
class SnackBarServiceImpl implements SnackBarService {
  final _log = Logger('SnackBarServiceImpl');

  Completer<SnackBarResponse>? _snackBarCompleter;
  @override
  Future<SnackBarResponse> showSnackBar(SnackBarRequest request) {
    _snackBarCompleter = Completer<SnackBarResponse>();

    if (request is ConfirmSnackBarRequest) {
      _log.finer('showConfirmSnackBar');
      _showConfirmSnackBar(request);
    }

    return _snackBarCompleter!.future;
  }

  @override
  void completeSnackBar(SnackBarResponse response) {
    getIt<AppRouter>().maybePop();
    _snackBarCompleter!.complete(response);
    _snackBarCompleter = null;
  }

  void _showConfirmSnackBar(ConfirmSnackBarRequest request) {
    AppLog.wtf(request.message);
    // final style =
    //     TextStyle(color: Theme.of(Get.overlayContext!).colorScheme.secondary);

    // GetSnackBar(
    //   message: request.message,
    //   margin: const EdgeInsets.all(8),
    //   dismissDirection: DismissDirection.horizontal,
    //   borderRadius: 8,
    //   mainButton: request.buttonText != null
    //       ? TextButton(
    //           child: Text(
    //             request.buttonText!,
    //             style: style,
    //           ),
    //           onPressed: () {
    //             completeSnackBar(
    //                 ConfirmSnackBarResponse((a) => a..confirmed = true));
    //             if (request.onPressed != null) {
    //               request.onPressed!();
    //             }
    //           },
    //         )
    //       : null,
    // ).show();
  }
}
