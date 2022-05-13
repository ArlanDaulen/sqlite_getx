import 'package:sqlite_getx/shared/dialogs/error_dialog.dart';

class Helper {
  static String errorHandle(int status, String message) {
    switch (status) {
      case 401:
        ErrorDialog.unAuthorizedError();
        return message;
      default:
        return message;
    }
  }
}
