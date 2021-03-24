import 'package:flutter/foundation.dart';

enum HeadlineTopic {
  covid,
  movie,
  game,
  war,
}

extension HeadlineTopicExtension on HeadlineTopic {
  String get name => describeEnum(this);
}
