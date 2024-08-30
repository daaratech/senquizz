// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardWithImageBackground extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CardWithImageBackground({
    super.key,
    this.imageUrl =
        "https://cdn.pixabay.com/photo/2021/10/11/23/49/app-6702045_1280.png",
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
          // Inner shadow
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Title
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final String emoji;
  const CategoryWidget({
    super.key,
    this.categoryName = "Education And Learning",
    this.emoji = "📚",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(4.0), // Default Card radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 2), // Default Card shadow offset
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                categoryName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                // Prevent overflow
              ),
            ),
          ],
        ));
  }
}

class CategoryGridView extends StatelessWidget {
  final List<String> categories;

  const CategoryGridView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 3 rows
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          //  childAspectRatio: 3 / 7, // Adjust the aspect ratio as needed
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryWidget(
            categoryName: categories[index],
            emoji: "📚",
          );
        },
      ),
    );
  }
}

class CategoryPager extends StatelessWidget {
  final List<String> categories;

  const CategoryPager({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Diviser la liste de catégories en pages de six éléments
    List<List<String>> pages = [];
    for (var i = 0; i < categories.length; i += 6) {
      pages.add(categories.sublist(
          i, i + 6 > categories.length ? categories.length : i + 6));
    }

    return PageView.builder(
      itemCount: pages.length,
      itemBuilder: (context, pageIndex) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 9 / 3, // Ajuster le ratio selon les besoins
          ),
          itemCount: pages[pageIndex].length,
          itemBuilder: (context, index) {
            return CategoryWidget(
              categoryName: pages[pageIndex][index],
              emoji: "📚",
            );
          },
        );
      },
    );
  }
}
