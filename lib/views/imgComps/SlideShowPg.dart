import 'package:flutter/material.dart';

class SlideshowGallery extends StatefulWidget {
  final dynamic photos; // Can be String or List<String>
  final int initialIndex;

  const SlideshowGallery({
    Key? key,
    required this.photos,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<SlideshowGallery> createState() => _SlideshowGalleryState();
}

class _SlideshowGalleryState extends State<SlideshowGallery> {
  late final PageController _pageController;
  late final List<String> _imageList;

  @override
  void initState() {
    super.initState();

    // Normalize photos input to a list of strings
    if (widget.photos is String) {
      _imageList = [widget.photos];
    } else if (widget.photos is List<String>) {
      _imageList = widget.photos;
    } else {
      throw Exception("Invalid photos type: must be String or List<String>");
    }

    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSingleImage = _imageList.length == 1;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          isSingleImage ? "Photo" : "Gallery",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: isSingleImage
            ? InteractiveViewer(
                child: Image.network(
                  _imageList.first,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              )
            : PageView.builder(
                controller: _pageController,
                itemCount: _imageList.length,
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    child: Image.network(
                      _imageList[index],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}



/***
 * 
 * 
 * 


        For multiple images:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SlideshowGallery(
              photos: [
                'https://picsum.photos/id/1018/400/300',
                'https://picsum.photos/id/1020/400/300',
                'https://picsum.photos/id/1025/400/300',
              ],
              initialIndex: 1,
            ),
          ),
        );

        For a single image:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SlideshowGallery(
              photos: 'https://picsum.photos/id/1024/400/300',
            ),
          ),
        );


 */