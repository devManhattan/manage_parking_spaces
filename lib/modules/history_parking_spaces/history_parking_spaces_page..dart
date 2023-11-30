import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/get_hisotry/gest_history_bloc.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/history_for_space_page.dart';

class HistoryParkingSpacesPage extends StatefulWidget {
  const HistoryParkingSpacesPage({super.key});

  @override
  State<HistoryParkingSpacesPage> createState() =>
      _HistoryParkingSpacesPageState();
}

class _HistoryParkingSpacesPageState extends State<HistoryParkingSpacesPage> {
  int totalSpaces = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GestHistoryBloc>(context).add(GestHistoryGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico"),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return MultiBlocListener(
            listeners: [
              BlocListener<GestHistoryBloc, GestHistoryState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is GestHistoryLoaded) {
                    if (totalSpaces != state.totalSpaces || totalSpaces ==0) {
                      totalSpaces = state.totalSpaces;
                      setState(() {});
                    }
                  }
                },
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: totalSpaces == 0 ? 1 : totalSpaces,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:totalSpaces > 0 ? 2: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, counter) {
                    return BlocBuilder<GestHistoryBloc, GestHistoryState>(
                      builder: (context, state) {
                        if (state is GestHistoryError) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        }
                        if (state is GestHistoryLoaded) {
                          if (state.totalSpaces == 0) {
                            return Center(
                              child: Text(
                                  "Você ainda não definiu o total de vagas. Faça isso em configurações"),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return HistoryForSpace(history: state.historyForSpace[counter + 1]);
                              }));
                            },
                            child: Card(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${counter + 1}",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
