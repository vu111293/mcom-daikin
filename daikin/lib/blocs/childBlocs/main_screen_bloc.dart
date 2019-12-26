

import 'package:rxdart/rxdart.dart';

class MainScreenBloc {

  final _pagerNavSubject = BehaviorSubject<int>();


  Function(int index) get switchPageAction => _pagerNavSubject.sink.add;

  Stream<int> get switchPageEvent => _pagerNavSubject.stream;

}