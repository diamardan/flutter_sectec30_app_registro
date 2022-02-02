
enum Status { LOADING, COMPLETED, EMPTY, ERROR }

enum AuthResponseStatus {
  SUCCESS,
  QR_INVALID,
  QR_NOT_FOUND,
  EMAIL_NOT_FOUND,
  EMAIL_ALREADY_EXISTS,
  ACCOUNT_NOT_FOUND,
  WRONG_PASSWORD,
  CONNECTION_FAILED,
  UNKNOW_ERROR,
}

class AuthnMethodEnum {
  static const QR_CAMERA = "qr-camera";
  static const QR_FILE = "qr_file";
  static const EMAIL_PASSWORD = "email_password";
}

