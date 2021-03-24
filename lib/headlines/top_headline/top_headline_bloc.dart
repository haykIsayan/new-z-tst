import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:rxdart/rxdart.dart';

class TopHeadlineBloc {
  final UseCase<NewsModel> _getTopHeadline;

  final BehaviorSubject<NewsModel> _topHeadline = BehaviorSubject.seeded(null);
  ValueStream<NewsModel> get topHeadlineStream => _topHeadline.stream;

  TopHeadlineBloc({
    UseCase<NewsModel> getTopHeadline,
  }) : this._getTopHeadline = getTopHeadline;

  void load() async {
    final topHeadline = await _getTopHeadline.execute();
    _topHeadline.add(topHeadline);
  }
}
