import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'set_total_spaces_event.dart';
part 'set_total_spaces_state.dart';

class SetTotalSpacesBloc
    extends Bloc<SetTotalSpacesEvent, SetTotalSpacesState> {
  SetTotalSpacesBloc() : super(SetTotalSpacesInitial()) {
    on<SetTotalSpacesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SetTotalSpacesSetEvent) {
        emit(SetTotalSpacesLoading());
        try {
          prefs ??= await SharedPreferences.getInstance();

          prefs!.setInt("total_spaces", event.spaces);
          emit(SetTotalSpacesLoaded());
        } catch (e) {
          emit(SetTotalSpacesError());
        }
      }
    });
  }
  SharedPreferences? prefs;
}
