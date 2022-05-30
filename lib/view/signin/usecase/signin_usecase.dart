class SignInUseCase {
  bool validateId(String id) {
    return id.isNotEmpty;
  }

  bool validatePassword(String password) {
    return password.isNotEmpty;
  }
}
