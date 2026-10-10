import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'mozambique_colors.dart';
import 'mozambique_country.dart';

/// Where the ink sits, in plate units. The two-row photos are flattened to
/// 520×239 (the aspect of `Mozambique_plate_02`, 2.12–2.17 on the others) and
/// projected onto each axis; the one-row photo measures 3.58, so it is laid
/// out on 520×145 and its ink rows scaled by 145/239.
///
/// 2011 plate (`Mozambique_plate_01`, `_02`): row 1 ink y 16.5–100.8 (centre
/// 58.6), row 2 y 119–222.2 (centre 170.6). Letters and digits share one grid,
/// centres 65, 148, 231 (pitch 83); the province code sits at 391, 470
/// (pitch 79). The emblem is x 388–456, y 7–73. The field fades from white to
/// a light blue between y 95 and 175.
///
/// Pre-2011 two-row (`Kfz-Mosambik`): row 1 y 17.8–97.8 (centre 57.8) letters
/// at 172, 282, 392; row 2 y 112.5–197.2 (centre 154.9) digits at 77, 180 and
/// 367, 468 either side of a dash at 260. The dealer line beneath is not
/// modelled.
///
/// Pre-2011 one-row (`Mozambique_plate_05`): ink y 21.3–112.3 (centre 66.8),
/// letters at 67, 117, 167, digit pairs at 256, 310 and 399, 453, dashes at
/// 214 and 354.
///
/// Every ink is 80–100 tall on a plate 145–239 high; at 0.55 ink per box a
/// box must be about 1.8 times the ink, which the canvas cannot hold when the
/// centre is near an edge. Each box is the largest centred one that stays on
/// the plate, so the ink lands at 73–85% of the references'.
abstract final class _Layout {
  static const double width = 520;

  // 2011 plate.
  static const double modernHeight = 239;
  static const double modernRow1Top = 0.1, modernRow1Box = 117;
  static const double modernRow2Top = 102.6, modernRow2Box = 136;
  static const double gridFirst = 65, gridPitch = 83;
  static const double provinceFirst = 391, provincePitch = 79;
  static const PlateBox emblem = PlateBox(391.5, 7, 61, 66);
  static const double fadeMiddle = 95, fadeFoot = 175;

  // Pre-2011 two-row.
  static const double legacyRow1Top = 0, legacyRow1Box = 115.6;
  static const double legacyRow2Top = 77.9, legacyRow2Box = 154;
  static const double legacyLetterFirst = 172, legacyLetterPitch = 110;
  static const double legacyDigitPitch = 101;
  static const double legacyDash = 260, legacyDashWidth = 80;

  // Pre-2011 one-row.
  static const double rowHeight = 145;
  static const double rowTop = 0.3, rowBox = 133;
  static const double rowLetterFirst = 67, rowLetterPitch = 50;
  static const double rowDigitPitch = 54;
  static const double rowDash1 = 214, rowDash2 = 354, rowDashWidth = 40;
}

/// The Mozambican plates.
///
/// [private] is the 2011 series, `ABC 123 MC`: groups `letters`, `number`,
/// `province`; the white-to-blue fade is painted into the background and the
/// national emblem is a decal (a crest with a ribbon, too detailed to draw).
/// [legacy] (`MLY 01-81`, groups `letters`, `first`, `second`) and
/// [legacyOneRow] (`MLW-17-30`, same groups) are the pre-2011 light-on-dark
/// plates, kept because they are still on the road.
///
/// Not implemented: the dealer line printed on some pre-2011 plates (it is
/// free text, `CAR CENTER MAPUTO` in the photo), and the 2011 plate's one-row
/// variant, for which the article gives no measured plate. The article names
/// no Israel-specific value.
abstract final class MozambiquePlates {
  /// Emblem: https://commons.wikimedia.org/wiki/File:Emblem_of_Mozambique.svg
  static const AssetImage _emblem = AssetImage(
    'assets/icons/emblem_of_mozambique.png',
    package: 'mozambique_plate',
  );

  static final PlateSpec private = _spec(
    id: 'mz.private',
    height: _Layout.modernHeight,
    background: const PlateSection.fill(
      PlateFill.stripes(
        <PlateFill>[
          PlateFill.field,
          PlateFill.color(MozambiqueColors.modernMiddle),
          PlateFill.color(MozambiqueColors.modernFoot),
        ],
        stops: <double>[_Layout.fadeMiddle, _Layout.fadeFoot],
      ),
    ),
    decals: const <PlateDecal>[PlateDecal(image: _emblem, box: _Layout.emblem)],
    slots: <PlateSlot>[
      ..._cells(
        MozambiqueAlphabets.letters,
        3,
        _Layout.gridFirst,
        _Layout.gridPitch,
        _Layout.modernRow1Top,
        _Layout.modernRow1Box,
      ),
      ..._cells(
        MozambiqueAlphabets.digits,
        3,
        _Layout.gridFirst,
        _Layout.gridPitch,
        _Layout.modernRow2Top,
        _Layout.modernRow2Box,
      ),
      ..._cells(
        MozambiqueAlphabets.letters,
        2,
        _Layout.provinceFirst,
        _Layout.provincePitch,
        _Layout.modernRow2Top,
        _Layout.modernRow2Box,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2], key: 'letters'),
      PlateTextGroup(<int>[3, 4, 5], key: 'number'),
      PlateTextGroup(<int>[6, 7], key: 'province'),
    ],
  );

  static final PlateSpec legacy = _spec(
    id: 'mz.legacy',
    height: _Layout.modernHeight,
    slots: <PlateSlot>[
      ..._cells(
        MozambiqueAlphabets.letters,
        3,
        _Layout.legacyLetterFirst,
        _Layout.legacyLetterPitch,
        _Layout.legacyRow1Top,
        _Layout.legacyRow1Box,
      ),
      ..._cells(
        MozambiqueAlphabets.digits,
        2,
        77,
        _Layout.legacyDigitPitch,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
      ..._cells(
        MozambiqueAlphabets.digits,
        2,
        367,
        _Layout.legacyDigitPitch,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2], key: 'letters'),
      PlateTextGroup(<int>[3, 4], key: 'first'),
      PlateTextGroup(<int>[5, 6], key: 'second'),
    ],
    labels: <PlateLabel>[
      _dash(
        _Layout.legacyDash,
        _Layout.legacyDashWidth,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
    ],
  );

  static final PlateSpec legacyOneRow = _spec(
    id: 'mz.legacy.one_row',
    height: _Layout.rowHeight,
    slots: <PlateSlot>[
      ..._cells(
        MozambiqueAlphabets.letters,
        3,
        _Layout.rowLetterFirst,
        _Layout.rowLetterPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
      ..._cells(
        MozambiqueAlphabets.digits,
        2,
        256,
        _Layout.rowDigitPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
      ..._cells(
        MozambiqueAlphabets.digits,
        2,
        399,
        _Layout.rowDigitPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2], key: 'letters'),
      PlateTextGroup(<int>[3, 4], key: 'first'),
      PlateTextGroup(<int>[5, 6], key: 'second'),
    ],
    labels: <PlateLabel>[
      for (final double cx in <double>[_Layout.rowDash1, _Layout.rowDash2])
        _dash(cx, _Layout.rowDashWidth, _Layout.rowTop, _Layout.rowBox),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, legacy, legacyOneRow];

  /// [count] cells of [pitch] with the first centred on [firstCx].
  static List<PlateSlot> _cells(
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch,
    double top,
    double box,
  ) => plateRegister(
    alphabet: alphabet,
    count: count,
    left: firstCx - pitch / 2,
    top: top,
    width: pitch,
    height: box,
  );

  static PlateLabel _dash(double cx, double width, double top, double box) =>
      PlateLabel(
        text: '-',
        box: PlateBox(cx - width / 2, top, width, box),
        glyphHeight: box,
      );

  static PlateSpec _spec({
    required String id,
    required double height,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    PlateSection background = PlateSection.plain,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: MozambiqueCountry.mozambique,
    canvasWidth: _Layout.width,
    canvasHeight: height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    background: background,
    decals: decals,
    slots: slots,
    labels: labels,
    textGroups: groups,
  );
}
