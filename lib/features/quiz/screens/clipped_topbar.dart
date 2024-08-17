import 'package:flutter/material.dart';

import 'topbar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bunny Search SearchBar Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const SearchPage());
  }
}

class ClipShapeBackground extends StatelessWidget {
  const ClipShapeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 380,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  Theme.of(context).colorScheme.primary,
                ],
                // colors: [Color(0xFFFACCCC), Color(0xFFF6EFE9)],
              )),
            ),
          )
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverSearchAppBar(),
            // Set this param so that it won't go off the screen when scrolling
            pinned: true,
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Cruelty-free brand',
                  style: TextStyle(fontSize: 20),
                ));
          }, childCount: 20))
        ],
      ),
    );
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: 280,
      child: ClipPath(
          clipper: BackgroundWaveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFFACCCC), Color(0xFFF6EFE9)],
            )),
          )),
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    const minSize = 140.0;
    final p1Diff = ((minSize - size.height) * 0.5).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class SearchBar extends StatelessWidget {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: pink,
          focusedBorder: _border(pink),
          border: _border(grey),
          enabledBorder: _border(grey),
          hintText: 'Start brand search',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(12),
      );
}
