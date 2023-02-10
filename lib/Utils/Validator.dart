class Validator {
  String? value;

  bool get isBlank => (value == null || value!.trim().isEmpty);
  bool get isNotBlank => ((value != null) && (value!.trim().isNotEmpty));

  bool isNumber() {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value!.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value!)) {
      return false;
    }
    return true;
  }
}
