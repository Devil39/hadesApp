class Validators {
  static String validateEmail(String email) {
    email = email.trim();
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (email.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String validateCPassword(String password, String confirmPassword) {
    password = password.trim();
    confirmPassword = confirmPassword.trim();
    if (password.length == 0 || confirmPassword.length == 0) {
      return "Re-Type the password";
    } else if (password.compareTo(confirmPassword) != 0) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }

  static String validatePassword(String password) {
    password = password.trim();
    if (password.length < 6) {
      return "Password is invalid, min. 6 characters";
    } else {
      return null;
    }
  }

  static String validateText(String text) {
    text = text.trim();
    if (text.length == 0) {
      return "This field cannot be left empty";
    } else {
      return null;
    }
  }

  static String validatePhoneNumber(String text) {
    text = text.trim();
    bool containsOnlyDigits = false;
    try {
      int.parse(text);
      containsOnlyDigits = true;
    } on FormatException catch(_) {
      containsOnlyDigits = false;
    }
    if (text.length == 0 || text.length<10 || !containsOnlyDigits) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  static String validateNumber(String text) {
    text = text.trim();
    bool containsOnlyDigits = false;
    try {
      int.parse(text);
      containsOnlyDigits = true;
    } on FormatException catch(_) {
      containsOnlyDigits = false;
    }
    if (text.length == 0 || !containsOnlyDigits || int.parse(text)<1) {
      return "Invalid number";
    } else {
      return null;
    }
  }

  static String validateURL(String url) {
    url = url.trim();
    String pattern = r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)';
    RegExp regExp = new RegExp(pattern);
    if (url.length == 0) {
      return "URL is Required";
    } else if (!regExp.hasMatch(url)) {
      return "Invalid Website URL";
    } else {
      return null;
    }
  }

  static String validateRegNo(String regNo) {
    regNo = regNo.trim();
    String pattern = r'[1-9][0-9][A-Za-z]{3}[0-9]{4}$';
    RegExp regExp = new RegExp(pattern);
    if (regNo.length == 0) {
      return "Registration Number is Required";
    } else if (!regExp.hasMatch(regNo)) {
      return "Invalid Registration Number";
    } else {
      return null;
    }
  }
}
