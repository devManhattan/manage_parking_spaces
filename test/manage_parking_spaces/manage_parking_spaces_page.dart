import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manage_parking_spaces/components/manage_parking_spaces/bottom_sheet_first_access_modal.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/get_hisotry/gest_history_bloc.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/set_history/set_history_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/check_first_access/check_first_access_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/manage_spaces/manage_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/set_total_spaces/set_total_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/manage_parking_spaces_page.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('ManageParkingSpacesPage widget test',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      "total_spaces": 5,
      "history":
          '[{"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}, {"number": 1,"clientDescription" : "", "veichleDescription" : "", "available" : true, "dateUpdated": "2023-11-29 23:26:35.611"}]'
    });
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<CheckFirstAccessBloc>(
            create: (context) => CheckFirstAccessBloc()),
        BlocProvider<SetTotalSpacesBloc>(
            create: (context) => SetTotalSpacesBloc()),
        BlocProvider<ManageSpacesBloc>(create: (context) => ManageSpacesBloc()),
        BlocProvider<SetHistoryBloc>(create: (context) => SetHistoryBloc()),
        BlocProvider<GestHistoryBloc>(create: (context) => GestHistoryBloc()),
      ],
      child: MaterialApp(
        home: MangeParkingSpacesPage(),
      ),
    ));

    // Verifica se a página é renderizada corretamente
    expect(find.text('Gerenciar vagas'), findsOneWidget);
    // Verifica se o botão de configurações está presente na AppBar
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Testa um cenário onde a página está carregando
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simula um evento de CheckFirstAccessBloc emitindo CheckFirstAccessIsFirst

    BlocProvider.of<CheckFirstAccessBloc>(
            tester.element(find.byType(MangeParkingSpacesPage)))
        .emit(CheckFirstAccessIsFirst());

    // Verifica se o estado da página é atualizado após o evento do ManageSpacesBloc
    BlocProvider.of<ManageSpacesBloc>(
            tester.element(find.byType(MangeParkingSpacesPage)))
        .emit(ManageSpacesLoaded(spaces: [
      SpaceModel(
          available: true,
          clientDescription: "João",
          dateUpdated: "2023-11-29 23:26:35.611",
          veichleDescription: "GOL")
    ]));

    await tester.pumpAndSettle(); // Aguarda a finalização das animações

    // Verifica se a quantidade correta de espaços é exibida na página
    expect(find.byType(Card), findsNWidgets(4));

    // Simula um toque em um dos espaços
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump(); // Aguarda a reconstrução do widget após o toque
    // Verifica se o estado foi atualizado corretamente após o toque

    // Teste outros cenários relevantes conforme necessário
  });
}
