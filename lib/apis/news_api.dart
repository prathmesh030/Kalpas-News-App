import 'package:flutter/cupertino.dart';
import 'package:kalpas_news_app/models/news_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsAPI with ChangeNotifier {
  List<NewsDataModel> _lsOfNews = [];

  List<NewsDataModel> get lsOfNews {
    return [..._lsOfNews];
  }

  Future fetchNewsFromAPI() async {
    if (lsOfNews.isNotEmpty) return;

    final url = Uri.parse("https://api.first.org/data/v1/news");
    try {
      final res = await http.get(url);

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      var newsData = extractedData['data'];
      (extractedData['data'] as List<dynamic>).forEach((newNews) {
        _lsOfNews.add(NewsDataModel(
          id: newNews['id'],
          title: newNews['title'] ?? "No Title News",
          subtitle: newNews['summary'] ?? "",
          date: newNews['published'] ?? "",
          link: newNews['link'] ?? "",
        ));
      });
    } catch (err) {
      // print(err);
      throw err;
    }
  }

  List<int> _favNewsId = [];

  List<int> get favNewsId {
    return [..._favNewsId];
  }

  List<NewsDataModel> _favNewsList = [];

  List<NewsDataModel> get favNewsList {
    _favNewsList = [];
    _favNewsId.forEach((favN) {
      _favNewsList.add(_lsOfNews.firstWhere((element) => favN == element.id));
    });

    return [..._favNewsList];
  }

  void toggleFavs(int newsId) {
    if (_favNewsId.contains(newsId)) {
      _favNewsId.remove(newsId);
    } else {
      _favNewsId.add(newsId);
    }

    print(_favNewsId);
  }

//end
}
