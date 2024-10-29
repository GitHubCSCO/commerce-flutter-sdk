import 'dart:io';
import 'dart:ui';

double translateX(double x, Size canvasSize, Size imageSize, int rotation) {
  switch (rotation) {
    case 90:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case 270:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case 0:
    case 180:
      return x * canvasSize.width / imageSize.width;
  }
  return x;
}

double translateY(double y, Size canvasSize, Size imageSize, int rotation) {
  switch (rotation) {
    case 90:
    case 270:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case 0:
    case 180:
      return y * canvasSize.height / imageSize.height;
  }
  return y;
}
