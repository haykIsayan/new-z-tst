import 'package:new_z_tst/entity/models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getBreakingHeadlines(String country);

  Future<List<NewsModel>> getNews(String query);
}
