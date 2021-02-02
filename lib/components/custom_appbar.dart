import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({this.name, this.email, this.icon});
  String name;
  String email;
  Widget icon;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 10.0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Text(
      //               'Hello, ${widget.name}',
      //               style: TextStyle(
      //                 color: Colors.black38,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             SizedBox(
      //               height: 5,
      //             ),
      //             Text(
      //               '${widget.email}',
      //               style: TextStyle(
      //                 color: Colors.black38,
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           width: 5,
      //         ),
      //         // CircleAvatar(
      //         //   child: IconButton(
      //         //       icon: Icon(
      //         //         Icons.supervised_user_circle,
      //         //         size: 50,
      //         //         color: Color.fromRGBO(0, 0, 0, 0.8),
      //         //       ),
      //         //       onPressed: () {
      //         //         customBanner(
      //         //           widget.name,
      //         //           widget.email,
      //         //         );
      //         //       }),
      //         //   radius: 25,
      //         //   backgroundColor: Colors.transparent,
      //         // ),
      //       ],
      //     ),
      //   ),
      // ],
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 70,
      title: Shimmer(
        direction: ShimmerDirection.values[0],
        gradient: LinearGradient(
          List: [
            Colors.white,
            Colors.grey,
            Colors.white,
          ],
        ),
        child: Text(
          'E-Haat',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  // Future customBanner(String name, String email) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (context) {
  //       return CupertinoAlertDialog(
  //         title: Text("User Details"),
  //         content: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Text(
  //                   'Name :',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   ' $name',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   'Email :',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   ' $email',
  //                   style: TextStyle(),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text(
  //               "Logout",
  //             ),
  //             onPressed: logout,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('UID') != null) {
      await prefs.remove('UID');
      await prefs.remove('UNAME');
      await prefs.remove('UEMAIL');
      if (prefs.getString('UID') == null) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/signin');
      }
    }
  }
}
