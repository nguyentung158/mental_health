import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/news/news.dart';
import 'package:http/http.dart' as http;

class NewsController with ChangeNotifier {
  late News _news;
  final mainUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=695693466b3f43c18a94ba4278cd3ade';

  Future<News> fetchAndSetNews() async {
    final response = await http.get(Uri.parse(mainUrl));
    _news = News.fromJson(json.decode(response.body));
    return _news;
  }
}
