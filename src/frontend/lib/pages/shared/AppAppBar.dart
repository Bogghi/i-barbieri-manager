import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/settings_provider.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: FaIcon(FontAwesomeIcons.scissors),
          ),
          Text("I Barbieri Lissone")
        ],
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: (){
            context.read<SettingsProvider>().changeMode();
          },
          icon: Theme.of(context).colorScheme.brightness == Brightness.light ?
          const Icon(Icons.sunny) : const Icon(Icons.nightlight_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
