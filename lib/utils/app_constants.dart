import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/utils/app_strings.dart';
import '../screens/bases/BaseWidget.dart';


class AppConstants {
  static const int splashDelay = 1500;
  static const int sliderAnimationTime = 300;

  
}

/// No task Warning Dialog
dynamic warningNoTask(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStrings.oopsMsg,
    message:
        "There is no Task For Delete!\n Try adding some and then try to delete it!",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

/// Delete All Task Dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStrings.areYouSure,
    message:
        "Do You really want to delete all tasks? You will no be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}


String lottieURL = 'assets/lottie/1.json';


/// Nothing Enter When user try to edit the current tesk
nothingEnterOnUpdateTaskMode(context) {
  return FToast.toast(
    context,
    msg: AppStrings.oopsMsg,
    subMsg: "You must edit the tasks then try to update it!",
    corner: 20.0,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}
emptyFieldsWarning(context) {
  return FToast.toast(
    context,
    msg: AppStrings.oopsMsg,
    subMsg: "You must fill all Fields!",
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}