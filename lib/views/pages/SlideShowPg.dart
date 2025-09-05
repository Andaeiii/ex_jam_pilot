import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart' show PhotoViewHeroAttributes;
import 'package:photo_view/photo_view_gallery.dart';

/// Your slideshow page
class SlideshowGallery extends StatelessWidget {
  final List<String> photos;
  final int initialIndex;

  const SlideshowGallery({
    Key? key,
    required this.photos,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: initialIndex,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PhotoViewGallery.builder(
        pageController: pageController,
        itemCount: photos.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[index]),
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (context, event) =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
