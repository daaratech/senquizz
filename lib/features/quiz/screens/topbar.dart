import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        color: Colors.red,
        height: 300.0,
        child: const Center(
          child: Text(
            "ClipPath",
            style: TextStyle(color: Colors.yellow, fontSize: 28),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: 280,
      child: ClipPath(
          clipper: MyCustomClipper(),
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
