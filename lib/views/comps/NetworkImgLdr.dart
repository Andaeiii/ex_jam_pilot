import 'package:flutter/material.dart';

class NetworkImgLdr extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;

  const NetworkImgLdr({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // 👈 take parent width if not given
      height: height, // 👈 height is optional (can stretch inside parent)
      child: Image.network(
        imageUrl,
        fit: fit,
        loadingBuilder:
            (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child; // ✅ fully loaded
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              const Icon(Icons.broken_image, color: Colors.red, size: 40);
        },
      ),
    );
  }
}
