import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateSpacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      watch: null,
      mobile: _mobile(context),
      tablet: _tablet(context),
      desktop: _desktop(context),
    );
  }

  Widget _mobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Space"),
      ),
      body: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.title),
              labelText: "Add Title",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit_location),
              labelText: "Add Location",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.child_care),
              labelText: "Add Age Restriction",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.block),
              labelText: "Add Maximum Capacity",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.people),
              labelText: "Add Managers",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.security),
              labelText: "Add Guards",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail),
              labelText: "Add Inviters",
              suffixIcon: IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text("SAVE"),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _tablet(BuildContext context) {
    return null;
  }

  Widget _desktop(BuildContext context) {
    return null;
  }
}
