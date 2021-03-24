import 'package:flutter/material.dart';
import 'package:new_z_tst/data/news_data_source.dart';
import 'package:new_z_tst/data/user_data_source.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:new_z_tst/headlines/breaking_headlines/breaking_headlines_view.dart';
import 'package:new_z_tst/headlines/headlines_bloc.dart';
import 'package:new_z_tst/headlines/top_headline/top_headline_view.dart';
import 'package:new_z_tst/headlines/topical_headlines/topical_headlines_view.dart';
import 'package:new_z_tst/news_detail/news_page.dart';
import 'package:new_z_tst/search/search_page.dart';
import 'package:new_z_tst/usecases/get_breaking_headlines.dart';
import 'package:new_z_tst/utils/search_bar.dart';
import 'package:shimmer/shimmer.dart';

class HeadlinesPage extends StatefulWidget {
  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();

  static Widget build() {
    return HeadlinesPage();
  }
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  final HeadlinesBloc _bloc = HeadlinesBloc(
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
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          _buildSearchBar(),
          // _buildDivider(),
          _buildTopHeadline(),
          // _buildDivider(),
          _buildBreakingHeadlines(),
          _buildDivider(),
          _buildTopicalHeadlines(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: _openSearchPage,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: SearchBar(),
      ),
    );
  }

  void _openSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.black,
    );
  }

  Widget _buildTopHeadline() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TopHeadlineView(),
    );
  }

  Widget _buildBreakingHeadlines() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: BreakingHeadlinesView(),
    );
  }

  Widget _buildNewsListLoading() {
    final placeHolderItems = [
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
      _buildNewsListItemPlaceHolder(),
    ];
    return ListView(
      shrinkWrap: true,
      children: placeHolderItems,
    );
    // return SizedBox(
    //   width: 200.0,
    //   height: 100.0,
    //   child: Shimmer.fromColors(
    //     baseColor: Colors.red,
    //     highlightColor: Colors.yellow,
    //     child: Text(
    //       'Shimmer',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 40.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildNewsListItemPlaceHolder() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            color: Colors.grey,
            height: 60.0,
            width: 60.0,
          ),
          Container(
            margin: EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  color: Colors.grey,
                  width: 260.0,
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  color: Colors.grey,
                  width: 160.0,
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  color: Colors.grey,
                  width: 120.0,
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
      baseColor: Colors.grey,
      highlightColor: Colors.white,
    );
  }

  Widget _buildNewsList(List<NewsModel> news) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, position) {
        return _buildNewsListItem(news[position]);
      },
    );
  }

  Widget _buildNewsListItem(NewsModel newsModel) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: ListTile(
        onTap: () => _openNewsDetail(newsModel),
        leading: newsModel.urlToImage == null || newsModel.urlToImage.isEmpty
            ? Container()
            : SizedBox(
                width: 60.0,
                height: 60.0,
                child: Image.network(
                  newsModel.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
        title: SizedBox(
          child: Text(
            newsModel.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          height: 55.0,
        ),
      ),
    );
  }

  void _openNewsDetail(NewsModel newsModel) {
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

  Widget _buildTopicalHeadlines() {
    return Container(
      // margin: EdgeInsets.all(10.0),
      child: TopicalHeadlinesView(
        shrinkWrap: true,
      ),
    );
  }
}
