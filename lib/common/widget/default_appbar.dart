import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppbar({super.key, this.title});
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? AppLocalizations.of(context)!.app_title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      actions: const [
        //! temporary disable language change button
        // Row(
        //   children: [
        //     const Text('TH'),
        //     Switch.adaptive(
        //         value: viewModel.locale?.languageCode == 'th',
        //         onChanged: (value) {
        //           if (viewModel.locale?.languageCode == 'th') {
        //             viewModel.set(const Locale('en', ''));
        //           } else {
        //             viewModel.set(const Locale('th', ''));
        //           }
        //         }),
        //   ],
        // )
      ],
    );
  }
}
