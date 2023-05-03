class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LoginWithEmailAndPasswordFailure(
            'This user is disabled. Please contact support for more information.');
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure(
            'Account does not exist.');
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure(
            'Invalid password. Please try again.');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
