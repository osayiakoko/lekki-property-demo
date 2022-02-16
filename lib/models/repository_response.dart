
class RepositoryResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  const RepositoryResponse({
    this.success = true,
    this.data,
    this.error,
  });

  const RepositoryResponse.error(this.error, {this.data}) : success=false;
}
