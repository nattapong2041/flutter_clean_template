import 'service_exception.dart';

sealed class Result<T> {
  final T? data;

  const Result({
    this.data,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  Success<T> get asSuccess => this as Success<T>;
  Failure<T> get asFailure => this as Failure<T>;

  @override
  String toString() {
    return "$data";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Result &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

final class Success<T> extends Result<T> {
  const Success({
    required T data,
  }) : super(data: data);
}

final class Failure<T> extends Result<T> {
  final ServiceException exception;

  const Failure({
    required this.exception,
    T? data,
  }) : super(data: data);

  @override
  String toString() {
    return "$exception";
  }
}