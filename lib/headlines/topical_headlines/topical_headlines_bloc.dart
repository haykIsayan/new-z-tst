import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/query_use_case.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:new_z_tst/utils/headline_topics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TopicalHeadlinesBloc {
  final BehaviorSubject<List<HeadlineTopic>> _headlineTopics =
      BehaviorSubject.seeded([]);
  ValueStream<List<HeadlineTopic>> get headlineTopicsStream =>
      _headlineTopics.stream;

  final BehaviorSubject<List<NewsModel>> _topicalHeadlines =
      BehaviorSubject.seeded([]);
  ValueStream<List<NewsModel>> get topicalHeadlinesStream =>
      _topicalHeadlines.stream;

  final UseCase<List<HeadlineTopic>> _getHeadlineTopics;

  final QueryUseCase<HeadlineTopic, List<NewsModel>> _getTopicalHeadlines;

  TopicalHeadlinesBloc({
    UseCase<List<HeadlineTopic>> getHeadlineTopics,
    QueryUseCase<HeadlineTopic, List<NewsModel>> getTopicalHeadlines,
  })  : this._getHeadlineTopics = getHeadlineTopics,
        this._getTopicalHeadlines = getTopicalHeadlines;

  void loadHeadlineTopics() async {
    final headlineTopics = await _getHeadlineTopics.execute();
    _headlineTopics.add(headlineTopics);
  }

  void loadTopicalHeadlines(HeadlineTopic topic) async {
    final topicalHeadlines = await _getTopicalHeadlines.execute(topic);
    _topicalHeadlines.add(topicalHeadlines);
  }
}
