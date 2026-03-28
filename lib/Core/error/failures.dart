abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
}

class LocalFailure extends Failure {
  LocalFailure(super.errMessage);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure(super.errMessage);
}

class CacheFailure extends Failure {
  CacheFailure(super.errMessage);
}

class NoInternetFailure extends Failure {
  NoInternetFailure(super.errMessage);
}
