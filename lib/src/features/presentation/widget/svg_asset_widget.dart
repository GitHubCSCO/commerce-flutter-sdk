import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class SvgAssetImage extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String semanticsLabel;
  final Color? color;

  const SvgAssetImage({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.semanticsLabel = '',
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(
        color ?? context.scheme.primary,
        BlendMode.srcIn,
      ),
      fit: fit,
      semanticsLabel: semanticsLabel,
    );
  }
}
