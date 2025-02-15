import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/typedefs/update_current_def.dart';

extension TextStyleExtensionExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle copyWithCurrent({
    UpdateCurrentDef<Color>? color,
    UpdateCurrentDef<Color>? backgroundColor,
    UpdateCurrentDef<double>? fontSize,
    UpdateCurrentDef<FontWeight>? fontWeight,
    UpdateCurrentDef<FontStyle>? fontStyle,
    UpdateCurrentDef<double>? letterSpacing,
    UpdateCurrentDef<double>? wordSpacing,
    UpdateCurrentDef<TextBaseline>? textBaseline,
    UpdateCurrentDef<double>? height,
    UpdateCurrentDef<String>? fontFamily,
    UpdateCurrentDef<TextOverflow>? overflow,
  }) {
    return copyWith(
      color: color?.call(this.color!),
      backgroundColor: backgroundColor?.call(this.backgroundColor!),
      fontSize: fontSize?.call(this.fontSize!),
      fontWeight: fontWeight?.call(this.fontWeight!),
      fontStyle: fontStyle?.call(this.fontStyle!),
      letterSpacing: letterSpacing?.call(this.letterSpacing!),
      wordSpacing: wordSpacing?.call(this.wordSpacing!),
      textBaseline: textBaseline?.call(this.textBaseline!),
      height: height?.call(this.height!),
      fontFamily: fontFamily?.call(this.fontFamily!),
      overflow: overflow?.call(this.overflow!),
    );
  }
}
