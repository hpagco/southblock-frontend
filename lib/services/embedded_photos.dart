import 'dart:convert';
import 'dart:typed_data';

import 'embedded_photos_data.dart';

/// Photos baked into the app code (see tools/fetch_commons_photos.py --embed).
class EmbeddedPhotos {
  EmbeddedPhotos._();
  static final _decoded = <String, Uint8List>{};

  static bool has(String imageKey) => kEmbeddedPhotosData.containsKey(imageKey);

  /// Decoded once, then reused.
  static Uint8List? bytes(String imageKey) {
    final b64 = kEmbeddedPhotosData[imageKey];
    if (b64 == null) return null;
    return _decoded.putIfAbsent(imageKey, () => base64Decode(b64));
  }

  static int get count => kEmbeddedPhotosData.length;
}
