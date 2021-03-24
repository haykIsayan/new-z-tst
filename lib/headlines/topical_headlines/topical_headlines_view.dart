import 'package:flutter/material.dart';
import 'package:new_z_tst/data/news_data_source.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/headlines/topical_headlines/headline_topics_bar.dart';
import 'package:new_z_tst/headlines/topical_headlines/topical_headlines_bloc.dart';
import 'package:new_z_tst/news_detail/news_page.dart';
import 'package:new_z_tst/usecases/get_headline_topics.dart';
import 'package:new_z_tst/usecases/get_topical_headlines.dart';
import 'package:new_z_tst/utils/headline_topics.dart';
import 'package:new_z_tst/utils/state_stream_builder.dart';

class TopicalHeadlinesView extends StatefulWidget {
  final bool shrinkWrap;

  const TopicalHeadlinesView({
    Key key,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  _TopicalHeadlinesViewState createState() => _TopicalHeadlinesViewState();
}

class _TopicalHeadlinesViewState extends State<TopicalHeadlinesView> {
  TopicalHeadlinesBloc _bloc = TopicalHeadlinesBloc(
    getHeadlineTopics: GetHeadlineTopics(),
    getTopicalHeadlines: GetTopicalHeadlines(
      newsRepository: NewsDataSource(),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.loadHeadlineTopics();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamBuilder<List<HeadlineTopic>>(
      stream: _bloc.headlineTopicsStream,
      onLoading: _buildHeadlineTopicsLoading,
      onSuccess: _buildHeadlineTopicsSuccess,
    );
  }

  Widget _buildHeadlineTopicsLoading() {
    return Container();
  }

  Widget _buildHeadlineTopicsSuccess(List<HeadlineTopic> headlineTopics) {
    return Column(
      children: [
        // _buildTopicalHeadlinesHeader(),
        _buildHeadlineTopicsBar(headlineTopics),
        _buildTopicalHeadlines(),
      ],
    );
  }

  Widget _buildTopicalHeadlinesHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      child: Text(
        'Headlines by topic',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 26.0,
        ),
      ),
    );
  }

  Widget _buildHeadlineTopicsBar(List<HeadlineTopic> headlineTopics) {
    return HeadlineTopicsBar(
      headlineTopics: headlineTopics,
      onHeadlineTopicSelected: (topic) {
        _bloc.loadTopicalHeadlines(topic);
      },
    );
  }

  Widget _buildTopicalHeadlines() {
    return StateStreamBuilder<List<NewsModel>>(
      stream: _bloc.topicalHeadlinesStream,
      onLoading: _buildTopicalHeadlinesLoading,
      onFailed: _buildTopicalHeadlinesFailed,
      onSuccess: _buildTopicalHeadlinesSuccess,
    );
  }

  Widget _buildTopicalHeadlinesLoading() {
    return Container();
  }

  Widget _buildTopicalHeadlinesFailed() {
    return Container();
  }

  Widget _buildTopicalHeadlinesSuccess(List<NewsModel> topicalHeadlines) {
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: topicalHeadlines.length,
      itemBuilder: (context, position) =>
          _buildTopicalHeadlineItem(topicalHeadlines[position]),
    );
  }

  Widget _buildTopicalHeadlineItem(NewsModel newsModel) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: ListTile(
        onTap: () {
          _openNewsDetailPage(newsModel);
        },
        leading: newsModel.urlToImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  newsModel.urlToImage,
                  fit: BoxFit.cover,
                  width: 90.0,
                  height: 90.0,
                ),
              )
            : Container(),
        title: Text(
          newsModel.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void _openNewsDetailPage(NewsModel newsModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return NewsDetailPage(
            newsModel: newsModel,
          );
        },
      ),
    );
  }
}
