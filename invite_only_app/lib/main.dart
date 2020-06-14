import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_event.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/blocs/spaces/spaces_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_event.dart';
import 'package:invite_only_app/widgets/pages/auth_page.dart';
import 'package:invite_only_app/widgets/pages/spaces_page.dart';

// These keys are restricted - they won't work without the necessary signing keys - so no harm in exposing them.
final kAndroidMapsApiKey = 'AIzaSyAXTDtFj3Dk0J61YcT9QlhXiCzWmDKvC4c';
final kIosMapsApiKey = 'AIzaSyAd9ja782qKYxLpWADesbPryXrf8WdukDI';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadImage('assets/place_placeholder.jpg');

  runApp(InviteOnlyApp());
}

class InviteOnlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(InitializeAuth()),
        ),
        BlocProvider<SpacesBloc>(
          create: (_) => SpacesBloc(),
        ),
        BlocProvider<DocsBloc>(
          create: (_) => DocsBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Invite Only",
        theme: ThemeData(primarySwatch: Colors.green),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserAuthenticated) {
              SpacesBloc.of(context).add(LoadSpaces());
              DocsBloc.of(context).add(LoadDocs());
            }
          },
          builder: (context, state) {
            if (state is AuthUninitialized) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (state is UserAuthenticated) {
              return SpacesPage();
            }

            return AuthPage();
          },
        ),
      ),
    );
  }
}

/// A helper method to preload asset images. Prevents the wait period when asset
/// images are loaded.
Future<Uint8List> loadImage(String url) {
  ImageStreamListener listener;

  final Completer<Uint8List> completer = Completer<Uint8List>();
  final ImageStream imageStream =
      AssetImage(url).resolve(ImageConfiguration.empty);

  listener = ImageStreamListener(
    (ImageInfo imageInfo, bool synchronousCall) {
      imageInfo.image
          .toByteData(format: ImageByteFormat.png)
          .then((ByteData byteData) {
        imageStream.removeListener(listener);
        completer.complete(byteData.buffer.asUint8List());
      });
    },
    onError: (dynamic exception, StackTrace stackTrace) {
      imageStream.removeListener(listener);
      completer.completeError(exception);
    },
  );

  imageStream.addListener(listener);

  return completer.future;
}
