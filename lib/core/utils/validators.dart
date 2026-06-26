/// Reusable form-field validators for the auth screens.
class Validators {
  Validators._();

  static String? required(String? v, {String field = 'This field'}) {
    if (v == null || v.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? name(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name is required';
    if (v.trim().length < 2) return 'Enter your full name';
    return null;
  }

  /// Egyptian mobile: 010/011/012/015 + 8 digits, optionally +20 prefixed.
  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone number is required';
    final digits = v.replaceAll(RegExp(r'[\s-]'), '');
    final eg = RegExp(r'^(?:\+?20)?0?1[0125]\d{8}$');
    if (!eg.hasMatch(digits)) return 'Enter a valid Egyptian mobile number';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final re = RegExp(r'^[\w.\-+]+@[\w-]+\.[\w.-]+$');
    if (!re.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? year(String? v) {
    if (v == null || v.trim().isEmpty) return 'Year is required';
    final y = int.tryParse(v.trim());
    final now = DateTime.now().year;
    if (y == null || y < 1980 || y > now + 1) return 'Enter a valid year';
    return null;
  }
}
