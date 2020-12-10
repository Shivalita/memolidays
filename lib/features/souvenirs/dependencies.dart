//! States injection
import 'package:memolidays/features/souvenirs/view/states/souvenirs_state.dart';
import 'package:memolidays/features/souvenirs/view/states/localization_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final Injected<SouvenirsState> souvenirsState =
    RM.inject(() => SouvenirsState());

final Injected<LocalizationState> localizationState =
    RM.inject(() => LocalizationState());