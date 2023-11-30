import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'check_first_access_event.dart';
part 'check_first_access_state.dart';

class CheckFirstAccessBloc
    extends Bloc<CheckFirstAccessEvent, CheckFirstAccessState> {
  CheckFirstAccessBloc() : super(CheckFirstAccessInitial()) {
    on<CheckFirstAccessEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is FirstAccessCheckEvent) {
        try {
          emit(CheckFirstAccessLoading());
          prefs = await SharedPreferences.getInstance();
          bool? firstAccess = prefs.getBool("firstAccess");
          if (firstAccess != null) {
            emit(CheckFirstAccessIsNotFirst());
          } else {
            emit(CheckFirstAccessIsFirst());
            prefs.setBool("firstAccess", true);
          }
        } catch (e) {
          emit(CheckFirstAccessError());
        }
      }
    });
  }
  late final SharedPreferences prefs;
}
