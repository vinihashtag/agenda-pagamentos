class Failure implements Exception {
  late final Object? _exception;

  late final StackTrace _stackTrace;

  // This message is going to appear to the user as a toast.
  final String messageError;

  Failure({this.messageError = 'Unexpected error, try again.', Object? exception, StackTrace? stackTrace}) {
    _exception = exception;
    _stackTrace = stackTrace ?? StackTrace.current;
  }

  Type? get typeError => _exception?.runtimeType;

  @override
  String toString() => '[$messageError]\n[[$_stackTrace]]\n[[[${_exception ?? ''}]]]';
}

class NetworkConnectionException extends Failure {
  @override
  String get messageError => text;

  static const String text = 'Sem conexão com a internet, verifique.';
}

class NotFoundException extends Failure {
  @override
  String get messageError => text;

  static const String text = 'Registro não encontrado.';
}

class UserNotFoundException extends Failure {
  @override
  String get messageError => text;

  static const String text = 'Cliente não encontrado.';
}

class UserNotLoggedException extends Failure {
  @override
  String get messageError => text;

  static const String text = 'Cliente não autenticado.';
}

class UserDisabledException extends Failure {
  @override
  String get messageError => text;

  static const String text = 'Cliente desativado, verifique com o suporte.';
}

class RequestApiException extends Failure {
  final String message;
  final int? statusCode;

  RequestApiException({required this.message, required this.statusCode});

  @override
  String get messageError => message;
}
