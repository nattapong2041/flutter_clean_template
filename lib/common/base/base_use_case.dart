abstract class BaseUseCase<T, Param> {
  Future<T> execute(Param params);
}
