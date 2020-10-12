import 'package:memolidays/features/login/view/states/login_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final Injected<LoginState> loginState =
    RM.inject(() => LoginState());
