import 'package:flutter/material.dart';
import 'package:flutter_clean_template/common/base/base_service.dart';
import 'package:flutter_clean_template/features/home/presentation/view/widget/news_card_view.dart';
import 'package:flutter_clean_template/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../common/widget/default_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //context.read<HomeViewModel>().getNews();
    return Scaffold(
        appBar: const DefaultAppbar(),
        body: Consumer<HomeViewModel>(
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
