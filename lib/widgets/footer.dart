import 'dart:math';

import 'package:flutter/material.dart';
import 'package:islam_app/Location/location_permission_page.dart';
import 'package:islam_app/Screens/alarm/alarm.dart';

class myFooter extends StatefulWidget {
  const myFooter({super.key});

  @override
  State<myFooter> createState() => _myFooterState();
}

class _myFooterState extends State<myFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.home),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> LocationPermissionWidget()));
          },
          child: Icon(Icons.location_pin),
        ),

        FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> alarm()));
          },
          child: Icon(Icons.notifications_active),
        ),

        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.mosque_sharp),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
