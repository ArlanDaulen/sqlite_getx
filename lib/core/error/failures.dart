import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message, [List props = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
  @override
  List<Object?> get props => [message];
}

class ChacheFailure extends Failure {
  ChacheFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}
