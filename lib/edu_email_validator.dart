import 'package:email_validator/email_validator.dart';

class EduEmailValidator {
  static bool validate(String? value) {
    return value != null && value.trim().endsWith('.edu') && EmailValidator.validate(value);
  }
}