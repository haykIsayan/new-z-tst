import 'package:new_z_tst/entity/use_case.dart';
import 'package:new_z_tst/headlines/topical_headlines/headline_topics_bar.dart';
import 'package:new_z_tst/utils/headline_topics.dart';

class GetHeadlineTopics implements UseCase<List<HeadlineTopic>> {
  @override
  Future<List<HeadlineTopic>> execute() async {
    return HeadlineTopic.values;
  }
}
