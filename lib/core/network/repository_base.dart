import 'package:dio/dio.dart';

import 'api_error.dart';

/// Mixin for repositories: runs a dio call and converts any failure into a
/// typed [ApiError]. Errors are never swallowed — they propagate as ApiError
/// so cubits/UI can react (message, status code, network flag).
mixin RepositoryBase {
  Future<T> guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on ApiError {
      rethrow;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError('Unexpected error: $e');
    }
  }
}

/// Tolerant JSON access helpers for unknown/variant response shapes.
extension JsonReader on Map<String, dynamic> {
  /// First non-null value among [keys]. Supports dotted paths ("data.token").
  dynamic pick(List<String> keys) {
    for (final key in keys) {
      final value = _dig(key);
      if (value != null) return value;
    }
    return null;
  }

  dynamic _dig(String key) {
    if (!key.contains('.')) return this[key];
    dynamic current = this;
    for (final part in key.split('.')) {
      if (current is Map && current.containsKey(part)) {
        current = current[part];
      } else {
        return null;
      }
    }
    return current;
  }

  String? str(List<String> keys) {
    final v = pick(keys);
    if (v == null) return null;
    return v.toString();
  }

  double? dbl(List<String> keys) {
    final v = pick(keys);
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  int? integer(List<String> keys) {
    final v = pick(keys);
    if (v == null) return null;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  bool? boolean(List<String> keys) {
    final v = pick(keys);
    if (v == null) return null;
    if (v is bool) return v;
    final s = v.toString().toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
    return null;
  }

  Map<String, dynamic>? mapField(List<String> keys) {
    final v = pick(keys);
    return v is Map<String, dynamic>
        ? v
        : (v is Map ? Map<String, dynamic>.from(v) : null);
  }
}
