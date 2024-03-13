import 'dart:ui';

enum ColorSet {
  background,
  textBegin,
  textEnd,
}

extension ColorSetExtenstion on ColorSet {
  Color get color {
    switch (this) {
      case ColorSet.background:
        return const Color(0xFF211130);
      case ColorSet.textBegin:
        return const Color(0xFFF82CFF);
      case ColorSet.textEnd:
        return const Color(0xFF16FBFF);
    }
  }
}
