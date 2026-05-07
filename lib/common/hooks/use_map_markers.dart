import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

/// Returns a map of site categories to their default marker icons.
Map<SiteCategoryDTO, BytesMapBitmap?> useDefaultMarkers() {
  return {
    SiteCategoryDTO.event: _useMarkerIcon(
      Assets.icons.standard.mainEventDefault,
    ),
    SiteCategoryDTO.beforeParty: _useMarkerIcon(
      Assets.icons.standard.partyDefault,
    ),
    SiteCategoryDTO.afterParty: _useMarkerIcon(
      Assets.icons.standard.partyDefault,
    ),
    SiteCategoryDTO.leanCodeOffice: _useMarkerIcon(
      Assets.icons.standard.leancodeDefault,
    ),
    SiteCategoryDTO.park: _useMarkerIcon(Assets.icons.standard.parkDefault),
    SiteCategoryDTO.cultural: _useMarkerIcon(
      Assets.icons.standard.culturalDefault,
    ),
    SiteCategoryDTO.museum: _useMarkerIcon(Assets.icons.standard.museumDefault),
    SiteCategoryDTO.bar: _useMarkerIcon(Assets.icons.standard.barDefault),
    SiteCategoryDTO.food: _useMarkerIcon(Assets.icons.standard.foodDefault),
    SiteCategoryDTO.other: _useMarkerIcon(Assets.icons.standard.otherDefault),
  };
}

/// Returns a map of site categories to their selected marker icons.
Map<SiteCategoryDTO, BytesMapBitmap?> useSelectedMarkers() {
  return {
    SiteCategoryDTO.event: _useMarkerIcon(
      Assets.icons.standard.mainEventSelected,
    ),
    SiteCategoryDTO.beforeParty: _useMarkerIcon(
      Assets.icons.standard.partySelected,
    ),
    SiteCategoryDTO.afterParty: _useMarkerIcon(
      Assets.icons.standard.partySelected,
    ),
    SiteCategoryDTO.leanCodeOffice: _useMarkerIcon(
      Assets.icons.standard.leancodeSelected,
    ),
    SiteCategoryDTO.park: _useMarkerIcon(Assets.icons.standard.parkSelected),
    SiteCategoryDTO.cultural: _useMarkerIcon(
      Assets.icons.standard.culturalSelected,
    ),
    SiteCategoryDTO.museum: _useMarkerIcon(
      Assets.icons.standard.museumSelected,
    ),
    SiteCategoryDTO.bar: _useMarkerIcon(Assets.icons.standard.barSelected),
    SiteCategoryDTO.food: _useMarkerIcon(Assets.icons.standard.foodSelected),
    SiteCategoryDTO.other: _useMarkerIcon(Assets.icons.standard.otherSelected),
  };
}

BytesMapBitmap? _useMarkerIcon(SvgGenImage svgImage) {
  final context = useContext();
  final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
  final path = svgImage.path;
  return useFuture(
    useMemoized(
      () => _bitmapBytes(devicePixelRatio, path, const Size.square(40)),
      [path, devicePixelRatio],
    ),
  ).data;
}

Future<BytesMapBitmap> _bitmapBytes(
  double devicePixelRatio,
  String path,
  Size size,
) async {
  final bytes = await _svgAssetToPngBytes(
    path,
    size.width * devicePixelRatio,
    size.height * devicePixelRatio,
  );
  return BitmapDescriptor.bytes(
    bytes,
    width: size.width,
    height: size.height,
    imagePixelRatio: devicePixelRatio,
  );
}

Future<Uint8List> _svgAssetToPngBytes(
  String path,
  double targetWidth,
  double targetHeight,
) async {
  final svgStringLoader = SvgAssetLoader(path);
  final pictureInfo = await vg.loadPicture(svgStringLoader, null);
  final picture = pictureInfo.picture;
  try {
    final recorder = ui.PictureRecorder();
    Canvas(recorder, Offset.zero & Size(targetWidth, targetHeight))
      ..scale(
        targetWidth / pictureInfo.size.width,
        targetHeight / pictureInfo.size.height,
      )
      ..drawPicture(picture);
    final imgByteData = await recorder.endRecording().toImage(
      targetWidth.ceil(),
      targetHeight.ceil(),
    );
    final bytesData = await imgByteData.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return bytesData?.buffer.asUint8List() ?? Uint8List(0);
  } finally {
    pictureInfo.picture.dispose();
  }
}
