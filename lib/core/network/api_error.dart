import 'package:dio/dio.dart';

/// A typed, user-presentable error surfaced by every repository.
///
/// Repos never throw raw [DioException]s or swallow errors — they convert to
/// [ApiError] via [ApiError.fromDio] so the UI gets a clean message plus the
/// HTTP status code (when there is one) for status-specific handling
/// (e.g. 409 conflict on a trip already taken, 401 unauthorized).
class ApiError implements Exception {
  /// Human-readable message safe to show in a snackbar / inline error.
  final String message;

  /// HTTP status code, or null for connectivity/timeout/unknown errors.
  final int? statusCode;

  /// True when the failure was a network/timeout problem (no server response),
  /// so the UI can show a "no connection" affordance with retry.
  final bool isNetwork;

  const ApiError(this.message, {this.statusCode, this.isNetwork = false});

  bool get isUnauthorized => statusCode == 401;

  /// 409/422/400 — used by driver accept to detect "trip already taken".
  bool get isConflict =>
      statusCode == 409 || statusCode == 422 || statusCode == 400;

  factory ApiError.network([String? message]) => ApiError(
    message ?? 'No connection. Check your internet and try again.',
    isNetwork: true,
  );

  factory ApiError.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError.network('The server took too long to respond.');
      case DioExceptionType.connectionError:
        return ApiError.network();
      case DioExceptionType.cancel:
        return const ApiError('Request cancelled.');
      case DioExceptionType.badCertificate:
        return const ApiError('Could not establish a secure connection.');
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        final status = e.response?.statusCode;
        final data = e.response?.data;
        return ApiError(
          _extractMessage(data) ?? _defaultForStatus(status),
          statusCode: status,
          isNetwork: e.type == DioExceptionType.unknown && e.response == null,
        );
    }
  }

  /// Backends vary: { message }, { error }, { errors:[{msg}] }, plain string…
  /// Pull whatever human text we can find without hard-failing.
  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is String && data.trim().isNotEmpty) return data;
    if (data is Map) {
      for (final key in const ['message', 'error', 'msg', 'detail']) {
        final v = data[key];
        if (v is String && v.trim().isNotEmpty) return v;
        if (v is Map && v['message'] is String) return v['message'] as String;
      }
      // express-validator style: { errors: [ { msg } ] }
      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) {
        final first = errors.first;
        if (first is Map && first['msg'] is String) return first['msg'] as String;
        if (first is String) return first;
      }
    }
    return null;
  }

  static String _defaultForStatus(int? status) {
    switch (status) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Your session has expired. Please log in again.';
      case 403:
        return 'You are not allowed to do that.';
      case 404:
        return 'Not found.';
      case 409:
        return 'Conflict — this action could not be completed.';
      case 422:
        return 'Validation failed. Please check your input.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again shortly.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => 'ApiError($statusCode): $message';
}
