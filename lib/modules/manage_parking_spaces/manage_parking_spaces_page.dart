import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_parking_spaces/components/manage_parking_spaces/bottom_sheet_first_access_modal.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/set_history/set_history_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/check_first_access/check_first_access_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/manage_spaces/manage_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/settings_page.dart';

class MangeParkingSpacesPage extends StatefulWidget {
  const MangeParkingSpacesPage({super.key});

  @override
  State<MangeParkingSpacesPage> createState() => _MangeParkingSpacesPageState();
}

class _MangeParkingSpacesPageState extends State<MangeParkingSpacesPage> {
  int totalSpaces = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CheckFirstAccessBloc>(context).add(FirstAccessCheckEvent());
    BlocProvider.of<ManageSpacesBloc>(context).add(ManageSpacesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar vagas"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingPage(
                    totalSpaces: totalSpaces,
                  );
                }));
              },
              child: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return MultiBlocListener(
            listeners: [
              BlocListener<CheckFirstAccessBloc, CheckFirstAccessState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is CheckFirstAccessIsFirst) {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: false,
                        constraints: BoxConstraints(
                            maxHeight: constraints.maxHeight * 0.9),
                        context: context,
                        builder: (context) {
                          return const BottomSheetFistAccessModal();
                        }).then((value) {
                      if (value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Você pode definir isso no icone no canto superior direito")));
                      }
                    });
                  }
                },
              ),
              BlocListener<ManageSpacesBloc, ManageSpacesState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is ManageSpacesLoaded) {
                    if (totalSpaces != state.spaces.length ||
                        totalSpaces == 0) {
                      print("aquii");
                      totalSpaces = state.spaces.length;
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
                    crossAxisCount: totalSpaces > 0 ? 2 : 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, counter) {
                    return BlocBuilder<ManageSpacesBloc, ManageSpacesState>(
                      builder: (context, state) {
                        if (state is ManageSpacesError) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        }
                        if (state is ManageSpacesLoaded) {
                          if (state.spaces.isEmpty) {
                            return Center(
                              child: Text(
                                  "Você ainda não definiu o total de vagas. Faça isso em configurações"),
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              if (state.spaces[counter].available) {
                                BlocProvider.of<ManageSpacesBloc>(context)
                                    .add(ManageSpacesSetvent(index: counter));
                                BlocProvider.of<SetHistoryBloc>(context).add(
                                    SetHistorySetEvent(
                                        available: false, number: counter));
                              } else {
                                BlocProvider.of<SetHistoryBloc>(context).add(
                                    SetHistorySetEvent(
                                        available: true, number: counter));
                                BlocProvider.of<ManageSpacesBloc>(context)
                                    .add(ManageSpacesUnsetvent(index: counter));
                              }
                            },
                            child: Card(
                              color: state.spaces[counter].available
                                  ? Colors.green[400]
                                  : Colors.red[400],
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${counter + 1}",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                  if (!state.spaces[counter].available)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Editar/Consultar informações como tipo do veículo, nome do condutor...")));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(10))),
                                          height: 40,
                                          child: Center(child: Text("Editar")),
                                        ),
                                      ),
                                    )
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
