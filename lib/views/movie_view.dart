import 'package:flutter/material.dart';
import 'package:movie/widgets/bottom_nav.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Text("Movie"),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}
