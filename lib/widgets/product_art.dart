import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/embedded_photos.dart';
import '../services/image_index.dart';
import '../services/image_service.dart';
import 'art_painter.dart';
import 'food_image.dart';

/// The one widget every screen uses to show a menu item picture.
/// Precedence: pinned URL > photo embedded in code (embedded_photos_data.dart) >
/// file in assets/images/menu/<imageKey>.jpg > live Commons photo (FoodImage) >
/// the drawn illustration.
class ProductArt extends StatelessWidget {
  final Item item;
  const ProductArt(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final illustration = CustomPaint(painter: ArtPainter(item), size: Size.infinite);
    final pinned = ImageService.pinned.containsKey(item.photoName.toLowerCase());
    if (!pinned && EmbeddedPhotos.has(item.imageKey)) {
      return Image.memory(EmbeddedPhotos.bytes(item.imageKey)!, fit: BoxFit.cover, gaplessPlayback: true, errorBuilder: (_, __, ___) => illustration);
    }
    if (!pinned && ImageIndex.has(item.assetPath)) {
      return Image.asset(item.assetPath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => illustration);
    }
    return LayoutBuilder(
      builder: (_, bc) => FoodImage(
        item.photoName,
        width: bc.maxWidth.isFinite ? bc.maxWidth : null,
        height: bc.maxHeight.isFinite ? bc.maxHeight : 140,
        radius: 6,
        fallback: () => illustration,
      ),
    );
  }
}
