import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String failureMessage;

  Failure({this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

class UnExpectedFailure extends Failure {}
