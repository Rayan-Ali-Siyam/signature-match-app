import 'dart:ui';

import 'package:signature/signature.dart';

class MyPoint {
  /// constructor
  MyPoint(this.offset, this.type, this.pressure);

  /// x and y value on 2D canvas
  Offset offset;

  /// pressure that user applied
  double pressure;

  /// type of user display finger movement
  PointType type;

  // <<<Added by Rayan Ali Siyam>>>
  /// Returns a JSON-serializable representation of this object
  Map<String, dynamic> toJson() {
    return {
      'offset': [offset.dx, offset.dy],
      'pressure': pressure,
      'type': type.toString(),
    };
  }

  /// Creates a Point object from a JSON object
  factory MyPoint.fromJson(Map<String, dynamic> json) {
    return MyPoint(
      Offset(json['offset'][0], json['offset'][1]),
      _parsePointType(json['type']),
      json['pressure'],
    );
  }

  static PointType _parsePointType(String value) {
    if (value == 'PointType.tap') {
      return PointType.tap;
    } else if (value == 'PointType.move') {
      return PointType.move;
    } else {
      throw ArgumentError('Invalid PointType value: $value');
    }
  }
  // <<<Added by Rayan Ali Siyam>>>
}
