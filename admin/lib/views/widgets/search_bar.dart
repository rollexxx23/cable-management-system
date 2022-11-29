import 'package:admin/utils/extension.dart';
import 'package:admin/views/widgets/iconbtn.dart';
import 'package:flutter/material.dart';

import 'dropdown.dart';
part 'search_field.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.bigScale,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(25.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SearchTextfield(),
          const _HorizontalPadding(),
          const _HorizontalPadding(),
          // IconBtn(
          //   child: DropdownBtn(
          //     options: const ['Filter', 'Lorem', 'Ipsum'],
          //     width: 85.scale,
          //   ),
          //   onTap: () {},
          // ),
          const SizedBox(width: 10),
          const Text(
            "Displaying 10 results",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _HorizontalPadding extends StatelessWidget {
  const _HorizontalPadding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 12,
    );
  }
}
