abstract class QueryUseCase<Query, Result> {
  Future<Result> execute(Query query);
}
