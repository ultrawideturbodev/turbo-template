enum TurboDevice {
  androidCompact,
  androidMedium,
  iPhone16,
  iPhone16Pro,
  iPhone16ProMax,
  iPhone16Plus,
  iPhone14And15ProMax,
  iPhone14And15Pro,
  iPhone13And14,
  iPhone14Plus,
  iPhone13Mini,
  iPhoneSE,
  androidExpanded,
  surfacePro8,
  iPadMini,
  iPadPro11,
  iPadPro12_9,
  macBookAir,
  macBookPro14,
  macBookPro16,
  desktop,
  wireframe,
  tv,
  appleWatchSeries1042mm,
  appleWatchSeries1046mm,
  appleWatch41mm,
  appleWatch45mm,
  appleWatch44mm,
  appleWatch40mm,
  iPhone13ProMax,
  iPhone13AndPro,
  iPhone11ProMax,
  iPhone11ProAndX,
  iPhone8Plus,
  iPhone8,
  androidSmall,
  androidLarge,
  googlePixel2,
  googlePixel2XL,
  iPadMini5,
  surfacePro4,
  macBook,
  macBookPro,
  surfaceBook,
  appleWatch42mm,
  appleWatch38mm,
  iMac,
  macintosh128k;

  double get height {
    switch (this) {
      case TurboDevice.androidCompact:
        return 917;
      case TurboDevice.androidMedium:
        return 840;
      case TurboDevice.iPhone16:
        return 852;
      case TurboDevice.iPhone16Pro:
        return 874;
      case TurboDevice.iPhone16ProMax:
        return 956;
      case TurboDevice.iPhone16Plus:
        return 932;
      case TurboDevice.iPhone14And15ProMax:
        return 932;
      case TurboDevice.iPhone14And15Pro:
        return 852;
      case TurboDevice.iPhone13And14:
        return 844;
      case TurboDevice.iPhone14Plus:
        return 926;
      case TurboDevice.iPhone13Mini:
        return 812;
      case TurboDevice.iPhoneSE:
        return 568;
      case TurboDevice.androidExpanded:
        return 800;
      case TurboDevice.surfacePro8:
        return 960;
      case TurboDevice.iPadMini:
        return 1133;
      case TurboDevice.iPadPro11:
        return 1194;
      case TurboDevice.iPadPro12_9:
        return 1366;
      case TurboDevice.macBookAir:
        return 832;
      case TurboDevice.macBookPro14:
        return 982;
      case TurboDevice.macBookPro16:
        return 1117;
      case TurboDevice.desktop:
        return 1024;
      case TurboDevice.wireframe:
        return 1024;
      case TurboDevice.tv:
        return 720;
      case TurboDevice.appleWatchSeries1042mm:
        return 223;
      case TurboDevice.appleWatchSeries1046mm:
        return 248;
      case TurboDevice.appleWatch41mm:
        return 215;
      case TurboDevice.appleWatch45mm:
        return 242;
      case TurboDevice.appleWatch44mm:
        return 224;
      case TurboDevice.appleWatch40mm:
        return 197;
      case TurboDevice.iPhone13ProMax:
        return 926;
      case TurboDevice.iPhone13AndPro:
        return 844;
      case TurboDevice.iPhone11ProMax:
        return 896;
      case TurboDevice.iPhone11ProAndX:
        return 812;
      case TurboDevice.iPhone8Plus:
        return 736;
      case TurboDevice.iPhone8:
        return 667;
      case TurboDevice.androidSmall:
        return 640;
      case TurboDevice.androidLarge:
        return 800;
      case TurboDevice.googlePixel2:
        return 731;
      case TurboDevice.googlePixel2XL:
        return 823;
      case TurboDevice.iPadMini5:
        return 1024;
      case TurboDevice.surfacePro4:
        return 912;
      case TurboDevice.macBook:
        return 700;
      case TurboDevice.macBookPro:
        return 900;
      case TurboDevice.surfaceBook:
        return 1000;
      case TurboDevice.appleWatch42mm:
        return 195;
      case TurboDevice.appleWatch38mm:
        return 170;
      case TurboDevice.iMac:
        return 720;
      case TurboDevice.macintosh128k:
        return 342;
    }
  }

  double get width {
    switch (this) {
      case TurboDevice.androidCompact:
        return 412;
      case TurboDevice.androidMedium:
        return 700;
      case TurboDevice.iPhone16:
        return 393;
      case TurboDevice.iPhone16Pro:
        return 402;
      case TurboDevice.iPhone16ProMax:
        return 440;
      case TurboDevice.iPhone16Plus:
        return 430;
      case TurboDevice.iPhone14And15ProMax:
        return 430;
      case TurboDevice.iPhone14And15Pro:
        return 393;
      case TurboDevice.iPhone13And14:
        return 390;
      case TurboDevice.iPhone14Plus:
        return 428;
      case TurboDevice.iPhone13Mini:
        return 375;
      case TurboDevice.iPhoneSE:
        return 320;
      case TurboDevice.androidExpanded:
        return 1280;
      case TurboDevice.surfacePro8:
        return 1440;
      case TurboDevice.iPadMini:
        return 744;
      case TurboDevice.iPadPro11:
        return 834;
      case TurboDevice.iPadPro12_9:
        return 1024;
      case TurboDevice.macBookAir:
        return 1280;
      case TurboDevice.macBookPro14:
        return 1512;
      case TurboDevice.macBookPro16:
        return 1728;
      case TurboDevice.desktop:
        return 1440;
      case TurboDevice.wireframe:
        return 1440;
      case TurboDevice.tv:
        return 1280;
      case TurboDevice.appleWatchSeries1042mm:
        return 187;
      case TurboDevice.appleWatchSeries1046mm:
        return 208;
      case TurboDevice.appleWatch41mm:
        return 176;
      case TurboDevice.appleWatch45mm:
        return 198;
      case TurboDevice.appleWatch44mm:
        return 184;
      case TurboDevice.appleWatch40mm:
        return 162;
      case TurboDevice.iPhone13ProMax:
        return 428;
      case TurboDevice.iPhone13AndPro:
        return 390;
      case TurboDevice.iPhone11ProMax:
        return 414;
      case TurboDevice.iPhone11ProAndX:
        return 375;
      case TurboDevice.iPhone8Plus:
        return 414;
      case TurboDevice.iPhone8:
        return 375;
      case TurboDevice.androidSmall:
        return 360;
      case TurboDevice.androidLarge:
        return 360;
      case TurboDevice.googlePixel2:
        return 411;
      case TurboDevice.googlePixel2XL:
        return 411;
      case TurboDevice.iPadMini5:
        return 768;
      case TurboDevice.surfacePro4:
        return 1368;
      case TurboDevice.macBook:
        return 1152;
      case TurboDevice.macBookPro:
        return 1440;
      case TurboDevice.surfaceBook:
        return 1500;
      case TurboDevice.appleWatch42mm:
        return 156;
      case TurboDevice.appleWatch38mm:
        return 136;
      case TurboDevice.iMac:
        return 1280;
      case TurboDevice.macintosh128k:
        return 512;
    }
  }
}
