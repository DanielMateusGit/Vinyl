import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/player_notifier.dart';
import 'components/navigation_bar.dart';
import 'components/player.dart';
import 'controllers/audio_player_controller.dart';
import 'controllers/brano_provider.dart';
import 'package:vinylproject/controllers/AudiosController.dart';

void main() => runApp(

  MultiProvider(
    providers: [

      // Provider for miniplayer
      ChangeNotifierProvider(
        create: (context) => Playernotifier(),
      ),

      // Provider for music controller
      ChangeNotifierProvider(
        create: (context) => AudioController(),
      ),
      ChangeNotifierProvider(
        create: (context) => BranoController(),
      ),
      ChangeNotifierProvider(create: (context) => downloadController()),
    ],
    child: Vinyl(),
  ),
);
class Vinyl extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        bottomNavigationBar: NavigationBar(),
      ),

      // miniplayer main builder
      builder: (context, child) {
        return Player(
          height: MediaQuery.of(context).size.height,
          percentage: 5.0,
          child: child,
        );
      },

      // global theme
      theme: new ThemeData.dark(),
    );
  }
}