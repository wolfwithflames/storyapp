import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/core/data/enums.dart';

class AppBaseModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ViewState _viewState = ViewState.ideal;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  init() {
    return this;
  }
}
