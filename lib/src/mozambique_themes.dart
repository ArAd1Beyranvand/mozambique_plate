import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'mozambique_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The 2011 plate has a raised black border about 5 of 239 thick (0.02); the
/// pre-2011 photos show a light rim of 8–10 (0.035 of the two-row height,
/// 0.05 of the one-row's). Corner radii are not measured.
abstract final class MozambiqueThemes {
  /// 2011 series: black on the white-to-blue fade. [MozambiquePlates.private]
  /// paints the fade; the theme's field is its top.
  static final PlateTheme private = _ink(
    MozambiqueColors.modernTop,
    MozambiqueColors.modernInk,
    0.02,
  );

  /// Pre-2011 two-row plate: light on dark.
  static final PlateTheme legacy = _ink(
    MozambiqueColors.legacyField,
    MozambiqueColors.legacyInk,
    0.035,
  );

  /// Pre-2011 one-row plate.
  static final PlateTheme legacyOneRow = _ink(
    MozambiqueColors.legacyRowField,
    MozambiqueColors.legacyRowInk,
    0.05,
  );
}

PlateTheme _ink(Color field, Color ink, double border) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  inactive: MozambiqueColors.inactive,
  borderWidthRatio: border,
  plateRadiusRatio: 0.04,
);
