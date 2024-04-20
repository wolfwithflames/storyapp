import 'package:built_value/built_value.dart';
import 'package:storyapp/core/models/snack_bar_request/snack_bar_request.dart';

part 'confirm_snack_bar_request.g.dart';

abstract class ConfirmSnackBarRequest extends SnackBarRequest
    implements Built<ConfirmSnackBarRequest, ConfirmSnackBarRequestBuilder> {
  String get message;

  String? get buttonText;

  void Function()? get onPressed;

  ConfirmSnackBarRequest._();
  factory ConfirmSnackBarRequest(
          [void Function(ConfirmSnackBarRequestBuilder) updates]) =
      _$ConfirmSnackBarRequest;
}
