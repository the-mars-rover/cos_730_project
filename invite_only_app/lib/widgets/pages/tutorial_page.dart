import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Future<void> showTutorial(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => TutorialPage(),
  ));
}

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'r1QsSQgZmJQ',
      flags: YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            ListTile(
              title: Text(
                'Welcome to Invite Only',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                'Invite Only provides a variety of functionalities to different users.\n\nDepending on how you will be using the application, which functionalities you use will differ. The video above serves as a tutorial for all users to understand how to use the app.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Want to know more?'),
              subtitle: Text('Visit our website at inviteonly.born.dev'),
              trailing: Icon(Icons.navigate_next),
              onTap: () => launch('https://inviteonly.born.dev'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.live_help),
              title: Text('Need help?'),
              subtitle: Text('Send an email to inviteonly@born.dev'),
              trailing: Icon(Icons.navigate_next),
              onTap: () => launch('mailto:inviteonly@born.dev'),
            ),
            Divider(),
          ],
        ),
        bottomSheet: ButtonBar(
          children: [
            OutlineButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.check_circle),
              label: Text('I\'m ready, let\'s go!'),
            )
          ],
        ),
      ),
    );
  }
}
