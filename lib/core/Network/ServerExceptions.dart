abstract class ServerExceptions {
  final String message;
  ServerExceptions({this.message = "Server failure!"});
}

class FetchProductException extends ServerExceptions {
  FetchProductException({required String message}) : super(message: message);
}

class AddToLocalException extends ServerExceptions {
  AddToLocalException({required String message}) : super(message: message);
}
