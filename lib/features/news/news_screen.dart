import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/news_bloc.dart';
import 'widget/news_card_shimmer.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: BlocSelector<NewsBloc, NewsState, bool>(
        selector: (state) {
          if (state is NewsInitial) {
            return true;
          }

          return false;
        },
        builder: (context, shouldShowLoading) => shouldShowLoading
            ? const _SkeletonShimmer()
            : const _NewsListView(),
      ),
    );
  }
}

class _NewsListView extends StatefulWidget {
  const _NewsListView();

  @override
  State<_NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<_NewsListView> {
  late final ScrollController _scrollController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >
          (_scrollController.position.maxScrollExtent * 0.7)) {
        context.read<NewsBloc>().add(const NewsFecthData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const _SkeletonShimmer();
        } else if (state is NewsError) {
          return Center(
            child: Column(
              children: [
                Text(state.message),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<NewsBloc>()
                        .add(const NewsFecthData(shouldRefresh: true));
                  },
                  child: const Text("refresh"),
                )
              ],
            ),
          );
        } else if (state is NewsReady) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              context
                  .read<NewsBloc>()
                  .add(const NewsFecthData(shouldRefresh: true));
            },
            child: state.news.isEmpty
                ? const _EmptyList()
                : GridView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.news.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 300.0,
                    ),
                    itemBuilder: (context, index) {
                      final item = state.news[index];
                      return NewsCardView(
                        title: item.title,
                        author: item.author ?? "",
                        description: item.description,
                        urlToImage: item.urlToImage,
                        publishedAt: item.publishedAt,
                      );
                    },
                  ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _SkeletonShimmer extends StatelessWidget {
  const _SkeletonShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) / 300.0,
      ),
      itemBuilder: (context, index) {
        return const NewsCardShimmer();
      },
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () async {
          context
              .read<NewsBloc>()
              .add(const NewsFecthData(shouldRefresh: true));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth),
            child: const Center(
              child: Text("My Widget"),
            ),
          ),
        ),
      ),
    );
  }
}
