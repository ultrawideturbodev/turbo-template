import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/enums/t_png.dart';

class TPngImage extends StatelessWidget {
  const TPngImage({
    Key? key,
    required this.png,
    this.height = 64,
    this.width,
  }) : super(key: key);

  final TPng png;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) => Image.asset(png.path, height: height, width: width);
}
