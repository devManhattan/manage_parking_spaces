import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'gest_history_event.dart';
part 'gest_history_state.dart';

class GestHistoryBloc extends Bloc<GestHistoryEvent, GestHistoryState> {
  GestHistoryBloc() : super(GestHistoryInitial()) {
    on<GestHistoryEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GestHistoryGetEvent) {
        try {
          emit(GestHistoryLoading());
          prefs ??= await SharedPreferences.getInstance();
          int? totalSpaces = prefs!.getInt("total_spaces");
          if (totalSpaces != null) {
            Map historyForSpace = {};
            String? history = prefs!.getString("history");
            if (history != null) {
              List<SpaceModel> histories = (jsonDecode(history) as List)
                  .map((e) => SpaceModel.fromMap(e))
                  .toList();
              histories.forEach((element) {
                if (historyForSpace[element.number] == null) {
                  historyForSpace[element.number] = [element];
                } else {
                  (historyForSpace[element.number] as List).add(element);
                }
              });
            }
            emit(GestHistoryLoaded(
                historyForSpace: historyForSpace, totalSpaces: totalSpaces));
          } else {
            emit(const GestHistoryLoaded(historyForSpace: {}, totalSpaces: 0));
          }
        } catch (e, stackTrace) {
          ;
          emit(GestHistoryError());
        }
      }
    });
  }
  SharedPreferences? prefs;
}
