import 'package:memolidays/features/login/view/states/localization_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final Injected<LocalizationState> localizationState =
    RM.inject(() => LocalizationState());