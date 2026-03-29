/// Base type for domain-level failures returned from repositories and use cases.
sealed class Failure {
  const Failure(this.message);

  /// Human-readable or diagnostic message (may be logged or shown in debug UI).
  final String message;
}

/// Failure when local cache or database operations fail.
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure when bundled asset data cannot be read or parsed.
final class AssetFailure extends Failure {
  const AssetFailure(super.message);
}
