import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../common/base/base_service.dart';
import '../../../../common/widget/default_appbar.dart';
import '../view_model/news_view_model.dart';
import 'widget/news_card_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //context.read<NewsViewModel>().getNews();
    return Scaffold(
        appBar: const DefaultAppbar(),
        body: Consumer<NewsViewModel>(
          builder: (context, viewModel, child) => Container(
            child: (viewModel.listNews.isEmpty &&
                    (viewModel.apiState == ApiState.loading))
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: viewModel.listNews.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 300.0,
                    ),
                    itemBuilder: (context, index) {
                      final item = viewModel.listNews[index];
                      return NewsCardView(
                        title: item.title,
                        author: item.author,
                        description: item.description,
                        urlToImage: item.urlToImage,
                        publishedAt: item.publishedAt,
                      );
                    },
                  ),
          ),
        ));
  }
}
