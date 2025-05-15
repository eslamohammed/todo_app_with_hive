abstract class BaseViewModel extends BaseViewModelIns /*with BaseViewModelOuts*/ {

}

abstract class BaseViewModelIns {
  void onStart(); //init

  void onDispose(); //dispose
}

abstract class BaseViewModelOuts {

}
