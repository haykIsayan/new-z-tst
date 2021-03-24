import 'package:new_z_tst/constants.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/news_repository.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NewsDataSource implements NewsRepository {
  final client = http.Client();

  @override
  Future<List<NewsModel>> getBreakingHeadlines(String us) async {
    final url = '$kBaseUrl/top-headlines?country=$us&apiKey=$kApiKey';
    final response = await http.get(url);
    final body = convert.jsonDecode(response.body);
    final List<dynamic> articlesJson = body['articles'];

    final articles =
        articlesJson.map((json) => NewsModel.fromJson(json)).toList();

    return articles;
  }

  @override
  Future<List<NewsModel>> getNews(String query) async {
    final url = '$kBaseUrl/everything?q=$query&apiKey=$kApiKey';
    final response = await http.get(url);
    final body = convert.jsonDecode(response.body);
    final List<dynamic> articlesJson = body['articles'];

    final articles =
        articlesJson.map((json) => NewsModel.fromJson(json)).toList();

    return articles;
  }
}
