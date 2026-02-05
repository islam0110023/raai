abstract class ApiFailure {
  ApiFailure(this.appCode);

  final int? appCode;
}

class ServerFailure extends ApiFailure {
  ServerFailure(super.appCode);
}
