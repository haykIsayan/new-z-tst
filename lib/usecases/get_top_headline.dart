import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/news_repository.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:new_z_tst/entity/user_repository.dart';

class GetTopHeadline implements UseCase<NewsModel> {
  final UserRepository _userRepository;
  final NewsRepository _newsRepository;

  GetTopHeadline({
    UserRepository userRepository,
    NewsRepository newsRepository,
  })  : this._userRepository = userRepository,
        this._newsRepository = newsRepository;

  @override
  Future<NewsModel> execute() async {
    final country = await _userRepository.getUserCountry();
    final breakingHeadlines =
        await _newsRepository.getBreakingHeadlines(country);
    breakingHeadlines.shuffle();
    return breakingHeadlines
        .firstWhere((element) => element.urlToImage != null);
  }
}
