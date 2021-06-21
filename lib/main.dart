import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinylproject/controllers/player_notifier.dart';
import 'components/navigation_bar.dart';
import 'components/player.dart';

void main() => runApp(

  // global provider
  ChangeNotifierProvider(
    create: (context) => Playernotifier(),
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