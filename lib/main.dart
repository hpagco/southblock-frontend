import 'package:flutter/material.dart';

import 'app.dart';
import 'services/image_index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImageIndex.load();
  runApp(const SouthBlockApp());
}
