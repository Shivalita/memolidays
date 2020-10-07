//! State injection
import 'package:memolidays/features/souvenirs/view/states/souvenirs_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final Injected<SouvenirsState> souvenirsState =
    RM.inject(() => SouvenirsState());

