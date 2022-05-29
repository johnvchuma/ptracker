// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.local_police_outlined,
              color: Color.fromARGB(255, 159, 30, 233),
              size: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Vmonitor",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
