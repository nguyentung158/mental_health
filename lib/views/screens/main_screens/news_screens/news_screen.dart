import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/news_controller.dart';
import 'package:mental_health_app/models/news/articles.dart';
import 'package:mental_health_app/views/screens/main_screens/news_screens/articles_screen.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Daily News',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.articles!
                  .map((e) => Newscard(
                        e: e,
                      ))
                  .toList(),
            );
          },
          future: Provider.of<NewsController>(context, listen: false)
              .fetchAndSetNews()),
    );
  }
}

class Newscard extends StatelessWidget {
  final Articles e;
  const Newscard({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ArticlesScreen(url: e.url!),
      )),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(e.urlToImage ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.title ?? '',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Published at: ${e.publishedAt!.substring(0, 10)}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Author: ${e.author}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      maxLines: 5,
                      e.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
