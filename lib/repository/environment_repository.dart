class EnvironmentRepository {
  String getOperationTypeString() {
    const type = String.fromEnvironment('OPERATION_TYPE');
    return type;
  }
}
