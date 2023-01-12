class SignInException implements Exception {}

class NoUserException extends SignInException {}

class IncorrectPasswordException extends SignInException {}


class SignUpException implements Exception {}

class UserExistsException extends SignInException {}
