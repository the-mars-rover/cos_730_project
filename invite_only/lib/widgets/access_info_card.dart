import 'package:flutter/material.dart';

class AccessInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.arrow_forward, color: Colors.green),
      title: Text('John Doe'),
      subtitle: Text('Entered on Tue 15 Jul @ 20:15'),
    );
  }
}
