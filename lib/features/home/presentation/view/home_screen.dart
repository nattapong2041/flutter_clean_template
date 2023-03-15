import 'package:flutter/material.dart';
import 'package:flutter_clean_template/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_route_name.dart';
import '../../../../common/widget/default_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<HomeViewModel>().getNews();
    return Scaffold(
        appBar: const DefaultAppbar(),
        body: Consumer<HomeViewModel>(
          builder: (context, value, child) => Container(
            child: Center(
              child: ElevatedButton(
                child: Text("news detail"),
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRouteName.news),
              ),
            ),
          ),
        ));
  }
}
