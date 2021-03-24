import 'package:flutter/material.dart';
import 'package:new_z_tst/utils/headline_topics.dart';

class HeadlineTopicsBar extends StatefulWidget {
  final List<HeadlineTopic> headlineTopics;
  final Function(HeadlineTopic) onHeadlineTopicSelected;

  const HeadlineTopicsBar(
      {Key key, this.headlineTopics, this.onHeadlineTopicSelected})
      : super(key: key);

  @override
  _HeadlineTopicsBarState createState() => _HeadlineTopicsBarState();
}

class _HeadlineTopicsBarState extends State<HeadlineTopicsBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.headlineTopics.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      widget.onHeadlineTopicSelected(
        widget.headlineTopics[_tabController.index],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: _buildHeadlineTopicTabs(widget.headlineTopics),
    );
  }

  List<Tab> _buildHeadlineTopicTabs(List<HeadlineTopic> headlineTopics) {
    return headlineTopics
        .map(
          (headlineTopic) => Tab(
            child: Text(
              headlineTopic.name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        )
        .toList();
  }
}
