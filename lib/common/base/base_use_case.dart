import 'result.dart';

abstract interface class BaseUseCase<T, Param> {
  Future<Result<T>> call(Param param);
}