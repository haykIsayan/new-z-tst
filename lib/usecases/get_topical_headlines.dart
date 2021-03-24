import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/news_repository.dart';
import 'package:new_z_tst/entity/query_use_case.dart';
import 'package:new_z_tst/utils/headline_topics.dart';

class GetTopicalHeadlines
    implements QueryUseCase<HeadlineTopic, List<NewsModel>> {
  final NewsRepository _newsRepository;

  GetTopicalHeadlines({
    NewsRepository newsRepository,
  }) : this._newsRepository = newsRepository;

  @override
  Future<List<NewsModel>> execute(HeadlineTopic topic) async {
    final topicalHeadlines = await _newsRepository.getNews(topic.name);
    return topicalHeadlines;
  }
}
