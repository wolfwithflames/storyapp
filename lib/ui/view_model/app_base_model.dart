import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/core/data/enums.dart';

class AppBaseViewModel extends BaseViewModel {
  final refreshController = RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ApiResponseStatus _apiResponseStatus = ApiResponseStatus.loading;
  ApiResponseStatus get apiResponseStatus => _apiResponseStatus;

  ViewState _viewState = ViewState.ideal;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    if (viewState != _viewState) {
      _viewState = viewState;
      notifyListeners();
    }
  }

  setApiResponseStatus(ApiResponseStatus status) {
    if (status != _apiResponseStatus) {
      _apiResponseStatus = status;
      notifyListeners();
    }
  }

  setIdealState() {
    if (viewState != ViewState.ideal) {
      setViewState(ViewState.ideal);
      notifyListeners();
    }
  }

  init() {}
}
