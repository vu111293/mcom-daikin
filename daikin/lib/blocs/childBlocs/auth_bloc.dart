import 'package:daikin/apis/net/auth_service.dart';
import 'package:daikin/models/base_model.dart';
import 'package:daikin/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AuthBloc {
  AuthService _authService;
  LUser currentUser;
  final _authSubject = new BehaviorSubject<LUser>();
  ValueStream get authObservable => _authSubject.stream;

  // signal
  Function(LUser) get updateUserAction => _authSubject.sink.add;

  // trigger
  Stream<LUser> get userEvent => _authSubject.stream;
  LUser get getUser => _authSubject.stream.value;

  AuthBloc() {
    _authService = AuthService();

    currentUser = null;
    _authSubject.sink.add(currentUser);
    _authSubject.listen((user) {
//      print("Listen User");
//      print(user.fullName);
      currentUser = user;
    });
  }

  Future<AccessToken> getAccessToken() async {
//    AccessToken temp = await _authService.getAccessToken();
//    if (currentUser == null) {
//      currentUser = temp.user;
//      _authSubject.sink.add(currentUser);
//    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    AccessToken temp = await getAccessToken();
    return temp != null && temp.id != null && temp.id.isNotEmpty;
  }

  void logout() {
    _authService.logout();
    currentUser = null;
    _authSubject.sink.add(currentUser);
  }

  dispose() {
    _authSubject.close();
  }
}
