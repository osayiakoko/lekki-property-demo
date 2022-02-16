
class APIResponse<T> {
  final bool success;
  final String? status;
  final String? message;
  final String? error;
  final int? code;
  final T? data;

  APIResponse({
    this.status,
    this.message,
    this.error,
    this.code,
    this.data,
  }): success = status == 'success' ? true: false;

  APIResponse.error(this.error, {this.status, this.message, this.code, this.data}): success = false;
}
