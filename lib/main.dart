import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/player_notifier.dart';
import 'components/navigation_bar.dart';
import 'components/player.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => Playernotifier(),
      child: Vinyl(),
    ));

class Vinyl extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        bottomNavigationBar: new NavigationBar(),
      ),

      // Builder del miniplayer
      builder: (context, child) {
        return Player(
          height: MediaQuery.of(context).size.height,
          percentage: 0.0,
          child: child,
        );
      },
      theme: new ThemeData.dark(),
    );
  }
}
