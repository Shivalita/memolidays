//! Connection state
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/domain/usecases/login.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginState {

  bool isConnected;

  init(context) async {
    
    User user = await Login()(context);

    if (user != null) {
      isConnected = true;
      print('connected = true');
    }

  }

}