import 'package:flutter/foundation.dart';
import 'package:veto/data/constants/k_values.dart';
import 'package:veto/data/enums/busy_type.dart';
import 'package:veto/data/models/busy_model.dart';
import 'package:veto/services/busy_service.dart';

BusyModel get gBusyModel => BusyService.instance().isBusyListenable.value;
ValueListenable<BusyModel> get gIsBusyListenable => BusyService.instance().isBusyListenable;
bool get gIsBusy => BusyService.instance().isBusy;
void gSetIdle() => gSetBusy(isBusy: false);

void gSetBusy({
  bool isBusy = true,
  Duration minBusyDuration = kValuesMinBusyDuration,
  String? busyMessage,
  String? busyTitle,
  BusyType? busyType,
  Duration? timeoutDuration,
  VoidCallback? onTimeout,
  dynamic payload,
}) =>
    BusyService.instance().setBusy(
      isBusy,
      minBusyDuration: minBusyDuration,
      busyMessage: busyMessage,
      busyTitle: busyTitle,
      busyType: busyType,
      onTimeout: onTimeout,
      payload: payload,
      timeoutDuration: timeoutDuration,
    );
