import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/widgets.dart';

class ValueListenableBuilderX5<T1, T2, T3, T4, T5> extends StatefulWidget {
  const ValueListenableBuilderX5({
    required this.valueListenable,
    required this.valueListenable2,
    required this.valueListenable3,
    required this.valueListenable4,
    required this.valueListenable5,
    required this.builder,
    this.child,
    super.key,
  });

  final Widget? child;
  final ValueListenable<T1> valueListenable;
  final ValueListenable<T2> valueListenable2;
  final ValueListenable<T3> valueListenable3;
  final ValueListenable<T4> valueListenable4;
  final ValueListenable<T5> valueListenable5;
  final Widget Function(
    BuildContext context,
    T1 value,
    T2 value2,
    T3 value3,
    T4 value4,
    T5 value5,
    Widget? child,
  ) builder;

  @override
  ValueListenableBuilderX5State<T1, T2, T3, T4, T5> createState() =>
      ValueListenableBuilderX5State<T1, T2, T3, T4, T5>();
}

class ValueListenableBuilderX5State<T1, T2, T3, T4, T5>
    extends State<ValueListenableBuilderX5<T1, T2, T3, T4, T5>> {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  void initState() {
    initListeners();
    super.initState();
  }

  void initListeners() {
    for (final listenable in _listenables) {
      listenable.addListener(rebuild);
    }
  }

  @override
  void dispose() {
    for (final listener in _listenables) {
      listener.removeListener(rebuild);
    }
    super.dispose();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  List<Listenable> get _listenables => [
        widget.valueListenable,
        widget.valueListenable2,
        widget.valueListenable3,
        widget.valueListenable4,
        widget.valueListenable5,
      ];

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  void rebuild() => setState(() {});

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  @override
  void didUpdateWidget(ValueListenableBuilderX5<T1, T2, T3, T4, T5> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(rebuild);
      widget.valueListenable.addListener(rebuild);
    }

    if (oldWidget.valueListenable2 != widget.valueListenable2) {
      oldWidget.valueListenable2.removeListener(rebuild);
      widget.valueListenable2.addListener(rebuild);
    }

    if (oldWidget.valueListenable3 != widget.valueListenable3) {
      oldWidget.valueListenable3.removeListener(rebuild);
      widget.valueListenable3.addListener(rebuild);
    }

    if (oldWidget.valueListenable4 != widget.valueListenable4) {
      oldWidget.valueListenable4.removeListener(rebuild);
      widget.valueListenable4.addListener(rebuild);
    }

    if (oldWidget.valueListenable5 != widget.valueListenable5) {
      oldWidget.valueListenable5.removeListener(rebuild);
      widget.valueListenable5.addListener(rebuild);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.valueListenable.value,
        widget.valueListenable2.value,
        widget.valueListenable3.value,
        widget.valueListenable4.value,
        widget.valueListenable5.value,
        widget.child,
      );
}
