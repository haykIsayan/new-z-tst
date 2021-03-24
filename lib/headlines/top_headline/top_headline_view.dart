import 'package:flutter/material.dart';
import 'package:new_z_tst/data/news_data_source.dart';
import 'package:new_z_tst/data/user_data_source.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/headlines/top_headline/top_headline_bloc.dart';
import 'package:new_z_tst/news_detail/news_page.dart';
import 'package:new_z_tst/usecases/get_top_headline.dart';
import 'package:new_z_tst/utils/state_stream_builder.dart';

class TopHeadlineView extends StatefulWidget {
  @override
  _TopHeadlineViewState createState() => _TopHeadlineViewState();
}

class _TopHeadlineViewState extends State<TopHeadlineView> {
  TopHeadlineBloc _bloc = TopHeadlineBloc(
    getTopHeadline: GetTopHeadline(
      userRepository: UserDataSource(),
      newsRepository: NewsDataSource(),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _buildTopStoryHeader(),
        _buildTopStory(),
      ],
    );
  }

  Widget _buildTopStoryHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      child: Text(
        'Top story for you',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 26.0,
        ),
      ),
    );
  }

  Widget _buildTopStory() {
    return StateStreamBuilder(
      stream: _bloc.topHeadlineStream,
      onLoading: _buildTopStoryLoading,
      onFailed: _buildTopStoryFailed,
      onSuccess: _buildTopStorySuccess,
    );
  }

  Widget _buildTopStoryLoading() {
    return Container();
  }

  Widget _buildTopStoryFailed() {
    return Container();
  }

  Widget _buildTopStorySuccess(NewsModel newsModel) {
    return GestureDetector(
      onTap: () {
        _openNewsPage(newsModel);
      },
      child: Container(
        width: double.infinity,
        height: 300.0,
        child: Stack(
          children: [
            _buildHeadlineCover(newsModel.urlToImage),
            _buildHeadlineTitle(newsModel.title),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadlineCover(String url) {
    return Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300.0,
        ),
      ),
    );
  }

  Widget _buildHeadlineTitle(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  void _openNewsPage(NewsModel newsModel) {
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
