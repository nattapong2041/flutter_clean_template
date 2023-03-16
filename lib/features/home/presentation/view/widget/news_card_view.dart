import 'package:flutter/material.dart';
import 'package:flutter_clean_template/common/widget/app_image.dart';
import 'package:intl/intl.dart';

class NewsCardView extends StatelessWidget {
  const NewsCardView(
      {super.key,
      required this.title,
      required this.author,
      required this.description,
      required this.urlToImage,
      this.publishedAt});
  final String title;
  final String author;
  final String description;
  final String? urlToImage;
  final DateTime? publishedAt;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd-MM-yyy HH:mm");
    return SizedBox(
      height: 450,
      child: Card(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (urlToImage != null)
            AppUrlImage(
              urlToImage!,
              height: 150,
            )
          else
            Container(
              height: 150,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(children: [
                Text(
                  title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    description,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    publishedAt == null ? "-" : dateFormat.format(publishedAt!),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
