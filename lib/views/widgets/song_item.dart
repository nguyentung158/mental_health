import 'package:flutter/material.dart';

class SongItem extends StatelessWidget {
  final String title;
  final String duration;
  final String imageUrl;
  final String category;
  const SongItem(
      {super.key,
      required this.title,
      required this.duration,
      required this.imageUrl,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          Row(
            children: [
              Text(
                duration,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
              const Text(
                ' * ',
              ),
              Flexible(
                child: Text(
                  category,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
