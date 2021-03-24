import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class BreakingHeadlinesBloc {
  final UseCase<List<NewsModel>> _getBreakingHeadlines;

  final BehaviorSubject<List<NewsModel>> _breakingHeadlines =
      BehaviorSubject.seeded([]);
  ValueStream<List<NewsModel>> get breakingHeadlinesStream =>
      _breakingHeadlines.stream;

  BreakingHeadlinesBloc({
    UseCase<List<NewsModel>> getBreakingHeadlines,
  }) : this._getBreakingHeadlines = getBreakingHeadlines;

  void load() async {
    final breakingHeadlines = await _getBreakingHeadlines.execute();
    _breakingHeadlines.add(breakingHeadlines);
  }
}
