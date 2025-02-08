import 'package:informers/informer.dart';

extension InformerExtension on Informer<bool> {
  void toggle() => updateCurrent((value) => !value);
}
