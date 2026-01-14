import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertest/core/shared/constant/default_asset_source.dart';
import 'package:fluttertest/core/shared/theme/color/app_color.dart';

class DefaultNetworkImage extends StatelessWidget {
  final String pathURL;
  final double? width, height, radius;
  final BoxFit? fit;

  const DefaultNetworkImage({
    super.key,
    required this.pathURL,
    this.width,
    this.height,
    this.radius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return buildImage(pathURL, width, height, radius, fit);
  }

  bool isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasAbsolutePath &&
        (uri.isScheme("http") || uri.isScheme("https"));
  }

  bool isSvgUrl(String url) {
    return url.toLowerCase().endsWith('.svg');
  }

  Widget buildImage(
    String pathURL,
    double? width,
    double? height,
    double? radius,
    BoxFit? fit,
  ) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: !isValidUrl(pathURL)
            ? Image.asset(DefaultAssetSource.logoLight, fit: BoxFit.cover)
            : isSvgUrl(pathURL)
            ? SvgPicture.network(
                pathURL,
                fit: BoxFit.cover,
                placeholderBuilder: (context) => Center(
                  child: CircularProgressIndicator(
                    backgroundColor: context.primaryColor,
                  ),
                ),
              )
            : CachedNetworkImage(
                fit: fit ?? BoxFit.cover,
                imageUrl: pathURL,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    backgroundColor: context.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
      ),
    );
  }
}
