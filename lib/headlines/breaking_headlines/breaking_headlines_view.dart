import 'package:flutter/material.dart';
import 'package:new_z_tst/data/news_data_source.dart';
import 'package:new_z_tst/data/user_data_source.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/headlines/breaking_headlines/breaking_headlines_bloc.dart';
import 'package:new_z_tst/news_detail/news_page.dart';
import 'package:new_z_tst/usecases/get_breaking_headlines.dart';
import 'package:new_z_tst/utils/state_stream_builder.dart';

class BreakingHeadlinesView extends StatefulWidget {
  @override
  _BreakingHeadlinesViewState createState() => _BreakingHeadlinesViewState();
}

class _BreakingHeadlinesViewState extends State<BreakingHeadlinesView> {
  BreakingHeadlinesBloc _bloc = BreakingHeadlinesBloc(
    getBreakingHeadlines: GetBreakingHeadlines(
      newsRepository: NewsDataSource(),
      userRepository: UserDataSource(),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamBuilder(
      stream: _bloc.breakingHeadlinesStream,
      onLoading: _buildBreakingHeadlinesLoading,
      onFailed: _buildBreakingHeadlinesFailed,
      onSuccess: _buildBreakingHeadlinesSuccess,
    );
  }

  Widget _buildBreakingHeadlinesLoading() {
    return Container(
      width: 180.0,
      height: 170.0,
    );
  }

  Widget _buildBreakingHeadlinesFailed() {
    return Container();
  }

  Widget _buildBreakingHeadlinesSuccess(List<NewsModel> breakingHeadlines) {
    return Container(
      width: 180.0,
      height: 170.0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: breakingHeadlines.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          final newsModel = breakingHeadlines[position];
          return _buildBreakingHeadlineItem(newsModel);
        },
      ),
    );
  }

  Widget _buildBreakingHeadlineItem(NewsModel newsModel) {
    return GestureDetector(
      onTap: () => _openNewsPage(newsModel),
      child: Column(
        children: [
          _buildBreakingHeadlineCover(newsModel),
          _buildBreakingHeadlineTitle(newsModel),
        ],
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

  Widget _buildBreakingHeadlineCover(NewsModel newsModel) {
    if (newsModel.urlToImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          newsModel.urlToImage,
          fit: BoxFit.cover,
          width: 180.0,
          height: 110.0,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildBreakingHeadlineTitle(NewsModel newsModel) {
    return Expanded(
      child: Container(
        width: 180.0,
        margin: EdgeInsets.all(8.0),
        child: Text(
          newsModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
