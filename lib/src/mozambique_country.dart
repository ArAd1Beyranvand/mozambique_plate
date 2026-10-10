import 'package:plate_core/plate_core.dart';

import 'mozambique_colors.dart';

/// Mozambique as a `PlateCountry`. The plates carry no country block, so every
/// spec sets `noPanel`.
abstract final class MozambiqueCountry {
  static const PlateCountry mozambique = PlateCountry(
    code: 'mz',
    captionLines: <String>[],
    panelColor: MozambiqueColors.modernTop,
    panelTextColor: MozambiqueColors.modernInk,
  );
}
