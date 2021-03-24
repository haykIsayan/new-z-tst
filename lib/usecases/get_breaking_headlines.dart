import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/entity/news_repository.dart';
import 'package:new_z_tst/entity/use_case.dart';
import 'package:new_z_tst/entity/user_repository.dart';

class GetBreakingHeadlines implements UseCase<List<NewsModel>> {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;

  GetBreakingHeadlines({
    NewsRepository newsRepository,
    UserRepository userRepository,
  })  : this._newsRepository = newsRepository,
        this._userRepository = userRepository;

  @override
  Future<List<NewsModel>> execute() async {
    final country = await _userRepository.getUserCountry();
    final breakingHeadlines =
        await _newsRepository.getBreakingHeadlines(country);
    return breakingHeadlines;
  }
}
