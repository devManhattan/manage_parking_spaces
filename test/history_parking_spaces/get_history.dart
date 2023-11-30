import 'package:flutter_test/flutter_test.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/get_hisotry/gest_history_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('GestHistoryBloc', () {
    late GestHistoryBloc gestHistoryBloc;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        "total_spaces": 5,
        "history":
            '[{"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}, {"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}]'
      });
      gestHistoryBloc = GestHistoryBloc();
      gestHistoryBloc.prefs = await SharedPreferences.getInstance();
      ;
    });

    test('emits GestHistoryLoaded with data when GestHistoryGetEvent is added',
        () {
      final expectedHistoryForSpace = {
        1: [
          SpaceModel(
            number: 1,
            available: false,
            clientDescription: '',
            dateUpdated: '',
            veichleDescription: '',
          )
        ],
        2: [
          SpaceModel(
              number: 2,
              veichleDescription: '',
              available: true,
              clientDescription: '',
              dateUpdated: '')
        ]
      };

      expectLater(
        gestHistoryBloc.stream,
        emitsInOrder([
          GestHistoryLoading(),
          GestHistoryLoaded(
              historyForSpace: expectedHistoryForSpace, totalSpaces: 5)
        ]),
      );
      gestHistoryBloc.add(GestHistoryGetEvent());
    });

    test('emits GestHistoryLoaded with empty data when totalSpaces is null',
        () async{
      SharedPreferences.setMockInitialValues({
        "history":
            '[{"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}, {"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}]'
      });
       gestHistoryBloc.prefs = await SharedPreferences.getInstance();
      expectLater(
        gestHistoryBloc.stream,
        emitsInOrder([
          GestHistoryLoading(),
          const GestHistoryLoaded(historyForSpace: {}, totalSpaces: 0)
        ]),
      );

      gestHistoryBloc.add(GestHistoryGetEvent());
    });

    test('emits GestHistoryError when an exception occurs', () async{
      SharedPreferences.setMockInitialValues({
        "total_spaces": 5,
        "history":
            '[{"clientDescription"  "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}, {"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}]'
      });
       gestHistoryBloc.prefs = await SharedPreferences.getInstance();
      expectLater(
        gestHistoryBloc.stream,
        emitsInOrder([GestHistoryLoading(), GestHistoryError()]),
      );

      gestHistoryBloc.add(GestHistoryGetEvent());
    });
  });
}
