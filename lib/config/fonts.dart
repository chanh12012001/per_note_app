enum FontApp { interBold, interThin, interSemiBold, interRegular }

extension FontAppExtension on FontApp {
  String get font {
    switch (this) {
      case FontApp.interBold:
        return 'Inter_Bold';
      case FontApp.interThin:
        return 'InterThin';
      case FontApp.interSemiBold:
        return 'Inter-SemiBold';
      case FontApp.interRegular:
        return 'Inter-Regular';
    }
  }
}
