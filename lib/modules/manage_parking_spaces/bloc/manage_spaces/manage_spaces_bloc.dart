import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'manage_spaces_event.dart';
part 'manage_spaces_state.dart';

class ManageSpacesBloc extends Bloc<ManageSpacesEvent, ManageSpacesState> {
  ManageSpacesBloc() : super(ManageSpacesInitial()) {
    on<ManageSpacesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ManageSpacesLoadEvent) {
        try {
          emit(ManageSpacesloading());
          prefs ??= await SharedPreferences.getInstance();
          int? totalSpaces = prefs!.getInt("total_spaces");
          print("total spaces => ${totalSpaces}");
          if (totalSpaces != null) {
            String? spaces = prefs!.getString("spaces");
            if (spaces != null) {
              List<SpaceModel> spacesList = (jsonDecode(spaces) as List)
                  .map((e) => SpaceModel.fromMap(e))
                  .toList();
              if (spacesList.length != totalSpaces) {
                while (spacesList.length != totalSpaces) {
                  if (spacesList.length > totalSpaces) {
                    spacesList.removeAt(spacesList.length - 1);
                  } else {
                    print("é maior");
                    spacesList.add(SpaceModel(
                        available: true,
                        clientDescription: "",
                        dateUpdated: "",
                        veichleDescription: ""));
                    prefs!.setString("spaces",
                        jsonEncode(spacesList.map((e) => e.toMap()).toList()));
                  }
                }
              }
              emit(ManageSpacesLoaded(spaces: spacesList));
            } else {
              List<SpaceModel> spacesList = [];
              for (var i = 0; i < totalSpaces; i++) {
                spacesList.add(SpaceModel(
                    available: true,
                    clientDescription: "",
                    dateUpdated: "",
                    veichleDescription: ""));
                prefs!.setString("spaces",
                    jsonEncode(spacesList.map((e) => e.toMap()).toList()));
                emit(ManageSpacesLoaded(spaces: spacesList));
              }
            }
          } else {
            emit(const ManageSpacesLoaded(spaces: []));
          }
        } catch (e) {
          emit(ManageSpacesError());
        }
      }

      if (event is ManageSpacesSetvent) {
        emit(ManageSpacesloading());
        String? spaces = prefs!.getString("spaces");
        if (spaces != null) {
          List<SpaceModel> spacesList = (jsonDecode(spaces) as List)
              .map((e) => SpaceModel.fromMap(e))
              .toList();
          spacesList[event.index].available = false;
          await prefs!.setString(
              "spaces", jsonEncode(spacesList.map((e) => e.toMap()).toList()));
          add(ManageSpacesLoadEvent());
        } else {
          emit(ManageSpacesError());
        }
      }

      if (event is ManageSpacesUnsetvent) {
        emit(ManageSpacesloading());
        String? spaces = prefs!.getString("spaces");
        if (spaces != null) {
          List<SpaceModel> spacesList = (jsonDecode(spaces) as List)
              .map((e) => SpaceModel.fromMap(e))
              .toList();
          spacesList[event.index].available = true;
          await prefs!.setString(
              "spaces", jsonEncode(spacesList.map((e) => e.toMap()).toList()));
          add(ManageSpacesLoadEvent());
        } else {
          emit(ManageSpacesError());
        }
      }
    });
  }
  SharedPreferences? prefs;
}
