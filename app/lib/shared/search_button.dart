import 'package:app/audible_icons_icons.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AudibleIcons.search),
      iconSize: 20.0,
      color: Colors.grey.shade400,
      onPressed: () {},
    );
  }
}
