import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'set_history_event.dart';
part 'set_history_state.dart';

class SetHistoryBloc extends Bloc<SetHistoryEvent, SetHistoryState> {
  SetHistoryBloc() : super(SetHistoryInitial()) {
    on<SetHistoryEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SetHistorySetEvent) {
        prefs ??= await SharedPreferences.getInstance();
        String? history = prefs!.getString("history");
        if (history != null) {
          List<SpaceModel> histories = (jsonDecode(history) as List)
              .map((e) => SpaceModel.fromMap(e))
              .toList();
          histories.add(SpaceModel(
              available: event.available,
              number: event.number + 1,
              clientDescription: "",
              dateUpdated: DateTime.now().toString(),
              veichleDescription: ""));
          prefs!.setString(
              "history", jsonEncode(histories.map((e) => e.toMap()).toList()));
        } else {
          SpaceModel spaceModel = SpaceModel(
              available: event.available,
              number: event.number + 1,
              clientDescription: "",
              dateUpdated: DateTime.now().toString(),
              veichleDescription: "");
          prefs!.setString("history", jsonEncode([spaceModel.toMap()]));
        }
      }
    });
  }
  SharedPreferences? prefs;
}
