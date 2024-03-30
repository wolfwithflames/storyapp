import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storyapp/constants/app_assets.dart';
import 'package:storyapp/logger/app_logger.dart';

enum ImageType { asset, file, url, svg }

// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  String? path;
  ImageType type;
  double? height, width;
  String? placeHolderImagePath;
  BoxFit? fit;
  Color? color;

  bool isBigImage = false;

  ImageView(
    this.path,
    this.type, {
    super.key,
    this.height,
    this.width,
    this.color,
    this.placeHolderImagePath = AppAssets.placeholder,
    this.fit,
    this.isBigImage = false,
  }) {
    if (placeHolderImagePath == null || placeHolderImagePath!.isEmpty) {
      placeHolderImagePath = AppAssets.placeholder;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return ImageState();
  }
}

class ImageState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showImage(
      widget.path,
      widget.type,
      widget.height,
      widget.width,
      widget.placeHolderImagePath,
      widget.fit,
    );
  }

  Widget showImage(String? path, ImageType type, double? height, double? width,
      String? placeHolderImagePath, BoxFit? fit) {
    switch (type) {
      case ImageType.asset:
        try {
          return Image.asset(
            path!,
            height: height,
            width: width,
            fit: fit,
            color: widget.color,
            opacity: const AlwaysStoppedAnimation(1),
          );
        } catch (e) {
          AppLog.i(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.svg:
        try {
          return SvgPicture.asset(
            path!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: widget.color != null
                ? ColorFilter.mode(
                    widget.color ?? Colors.black, BlendMode.srcIn)
                : null,
          );
        } catch (e) {
          AppLog.i(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.file:
        try {
          File f = File(path!);
          if (f.existsSync()) {
            return Image.file(
              f,
              height: height,
              width: width,
              fit: fit,
              opacity: const AlwaysStoppedAnimation(1),
            );
          } else {
            return placeHolder(height, width, placeHolderImagePath!, fit);
          }
        } catch (e) {
          AppLog.i(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.url:
        try {
          return SizedBox(
            width: width,
            child: CachedNetworkImage(
              imageUrl: path ?? "",
              errorWidget: (context, url, error) =>
                  placeHolder(height, width, placeHolderImagePath!, fit),
              height: height,
              fit: fit,
              // memCacheWidth: (Get.width * .8).toInt(),
              placeholderFadeInDuration: const Duration(milliseconds: 500),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  placeHolder(height, width, placeHolderImagePath!, fit),
            ),
          );
        } catch (e) {
          AppLog.i(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }
    }
  }

  Widget placeHolder(
      double? height, double? width, String placeHolderImagePath, BoxFit? fit) {
    return SvgPicture.asset(
      placeHolderImagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }
}
