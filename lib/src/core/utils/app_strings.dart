class AppStrings {
  static const String appName = 'Booking App';

  static const String fontFamily = 'Peter';

  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';

  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';

  static const String cachedLoginStatus = 'CACHED_LOGIN_STATUS';
  static const String cachedStatusMsg = 'CACHED_STATUS_MSG';
  static const String cachedApiToken = 'CACHED_API_TOKEN';
  static const String cachedUserData = 'CACHED_USER_DATA';
  static const String cachedProfileImage = 'CACHED_PROFILE_IMAGE';

  /** validation */

  /// regex
  // name
  static const String oneSpCharRegExp = r"(?=.*?[~!@#$%^&*_+\-=×÷|\\/:',.<>\(\)\{\}\[\]])";

  // email
  static const String emailRegExp =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  // password
  static const String twoUppercaseRegExp = r"(?=.*?[A-Z].*?[A-Z])";
  static const String twoLowercaseRegExp = r"(?=.*?[a-z].*?[a-z])";
  static const String twoNumRegExp = r"(?=.*?[0-9].*?[0-9])";
  static const String twoSpCharRegExp =
      r"(?=.*?[~!@#$%^&*_+\-=×÷|\\/:',.<>\(\)\{\}\[\]].*?[~!@#$%^&*_+\-=×÷|\\/:',.<>\(\)\{\}\[\]])";

  /// messages
  static const String requiredFieldMsg = '*required field';

  // name
  static const String nameMatchesLengthMsg = '*should be 3 characters at least';
  static const String noSpacesMsg = '*shouldn\'t contain spaces';
  static const String noNumbersMsg = '*shouldn\'t contain numbers';
  static const String noSpCharMsg = '*shouldn\'t contain any special characters';

  // email
  static const String emailFormErrorMsg = '*must contain "@" and can\'t end with "."';

  // password
  static const String twoUppercaseMsg = '*must contain at least 2 uppercase letters';
  static const String twoLowercaseMsg = '*must contain at least 2 lowercase letters';
  static const String twoNumMsg = '*must contain at least 2 number digits';
  static const String twoSpCharMsg = "*must contain at least 2 special characters";
  static const String passwordMatchesLengthMsg = '*must contain at least 8 characters';

  // password confirmation
  static const String passwordsNotIdenticalMsg = "*passwords aren't identical";
}
