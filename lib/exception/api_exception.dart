enum HttpStatusCode {
  badRequest(400),
  unAuthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  requestTooLargeForGateway(413),
  internalServerError(500),
  serviceUnavailable(503),
  otherError(null);

  final int? statusNumber;
  const HttpStatusCode(this.statusNumber);
}

class ApiException {
  final HttpStatusCode statusCode;
  final Map<String, dynamic>? responseBody;
  ApiException(this.statusCode, {this.responseBody});
}
