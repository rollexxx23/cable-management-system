part of 'search_bar.dart';

class _SearchTextfield extends StatelessWidget {
  _SearchTextfield({Key? key}) : super(key: key);

  final TextEditingController _searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFEFEDED),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.scale),
      constraints: BoxConstraints(maxWidth: 394.scale),
      alignment: Alignment.center,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        controller: _searchText,
        decoration: InputDecoration(
          focusColor: Colors.red,
          border: InputBorder.none,
          hintText: 'Search...',
          hintStyle: TextStyle(
            fontSize: 18.scale,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('images/search.png'),
              const SizedBox(height: 10),
            ],
          ),
        ),
        style: TextStyle(
          fontSize: 18.scale,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
