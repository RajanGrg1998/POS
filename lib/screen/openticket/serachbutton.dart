// import 'package:flutter/material.dart';
// import 'package:pos/screen/widgets/animatedsearchbutton.dart';

// class SearchButton extends StatefulWidget {
//   const SearchButton({Key? key}) : super(key: key);

//   @override
//   _SearchButtonState createState() => _SearchButtonState();
// }

// class _SearchButtonState extends State<SearchButton> {
//   late TextEditingController textController;
//   @override
//   void initState() {
//     super.initState();
//     textController = TextEditingController();
//   }

//   @override
//   void deactivate() {
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimSearchBar(
//         width: MediaQuery.of(context).size.width,
//         helpText: 'Search',
//         textController: textController,
//         onSuffixTap: () {
//           setState(() {
//             print('Pressed');
//           });
//         });
//   }
// }
