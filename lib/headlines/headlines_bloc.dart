import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

class HeadlinesBloc {
  final UseCase<List<NewsModel>> getBreakingHeadlines;

  final BehaviorSubject<NewsModel> _topStory = BehaviorSubject.seeded(null);
  ValueStream<NewsModel> get topStory => _topStory.stream;

  final BehaviorSubject<List<NewsModel>> _breakingHeadlines =
      BehaviorSubject.seeded([]);
  ValueStream<List<NewsModel>> get breakingHeadlines =>
      _breakingHeadlines.stream;

  // final BehaviorSubject<List<NewsModel>> _topicalHeadlines = Beha

  HeadlinesBloc({this.getBreakingHeadlines});

  void load() async {
    try {
      await _loadBreakingHeadlinesAndTopStory();
    } catch (e) {}
  }

  Future<void> _loadBreakingHeadlinesAndTopStory() async {
    final breakingHeadlines = await getBreakingHeadlines.execute();
    _topStory.add(breakingHeadlines.first);
    _breakingHeadlines.add(breakingHeadlines.sublist(
      1,
      breakingHeadlines.length - 1,
    ));
  }
}
