import 'package:flutter/widgets.dart';

/// The colours of the Mozambican plates, the modal pixel of each flattened
/// photo region.
///
/// The 2011 plate fades from white at the top to a light blue at the bottom
/// (`E7E5E4`, `D8E4E4`, `BDE5F5` at the top, middle and foot of the
/// `Mozambique_plate_02` flat); the ink is the photo's `504240` darkened to a
/// near black, as the article calls it black. The pre-2011 plates are light
/// ink on a dark field: `EDEEF0` on `2E313D` for the two-row dealer plate and
/// `F2F4F3` on `635953` for the one-row plate, whose field is a warm grey in
/// its photo.
abstract final class MozambiqueColors {
  static const Color modernTop = Color(0xFFE7E5E4);
  static const Color modernMiddle = Color(0xFFD8E4E4);
  static const Color modernFoot = Color(0xFFBDE5F5);
  static const Color modernInk = Color(0xFF2B2523);

  static const Color legacyField = Color(0xFF2E313D);
  static const Color legacyInk = Color(0xFFEDEEF0);

  static const Color legacyRowField = Color(0xFF635953);
  static const Color legacyRowInk = Color(0xFFF2F4F3);

  static const Color inactive = Color(0xFFB0B0B0);
}
