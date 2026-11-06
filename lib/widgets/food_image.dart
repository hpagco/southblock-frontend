import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/image_service.dart';

/// A photo for [name] (looked up by ImageService). Falls back to a soft placeholder,
/// or to [fallback] when given (we pass the drawn illustration for menu items).
class FoodImage extends StatefulWidget {
  final String name;
  final double? size, width, height;
  final double radius;
  final Color? bg; // when set, loading/missing photos show this plain color (no icon)
  final Widget Function()? fallback;
  const FoodImage(this.name, {super.key, this.size, this.width, this.height, this.radius = 8, this.bg, this.fallback});
  @override
  State<FoodImage> createState() => _FoodImageState();
}

class _FoodImageState extends State<FoodImage> {
  late Future<String?> photo = ImageService.resolve(widget.name);

  // Without this, a reused widget keeps its first photo when the name changes.
  @override
  void didUpdateWidget(FoodImage old) {
    super.didUpdateWidget(old);
    if (old.name != widget.name) photo = ImageService.resolve(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.size ?? widget.width ?? double.infinity;
    final h = widget.size ?? widget.height ?? 140;
    final small = h.isFinite && h < 90;
    Widget placeholder() => widget.fallback != null
        ? widget.fallback!()
        : widget.bg != null
            ? Container(color: widget.bg)
            : Container(
                color: Brand.soft,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6),
                child: small
                    ? const Icon(Icons.image_outlined, color: Brand.gold)
                    : Column(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.image_outlined, color: Brand.gold),
                        const SizedBox(height: 4),
                        Text(widget.name, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                      ]),
              );
    Widget loading() => widget.fallback != null ? widget.fallback!() : Container(color: widget.bg ?? Brand.soft);
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: SizedBox(
        width: w,
        height: h,
        child: FutureBuilder<String?>(
          future: photo,
          builder: (_, s) {
            if (s.connectionState != ConnectionState.done) return loading();
            if (s.data == null) return placeholder();
            return Image.network(
              s.data!,
              fit: BoxFit.cover,
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer, // needs Flutter 3.22+
              loadingBuilder: (_, child, p) => p == null ? child : loading(),
              errorBuilder: (_, __, ___) => placeholder(),
            );
          },
        ),
      ),
    );
  }
}
