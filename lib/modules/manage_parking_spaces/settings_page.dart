import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/manage_spaces/manage_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/set_total_spaces/set_total_spaces_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.totalSpaces});
  final int totalSpaces;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController spaces = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: BlocListener<SetTotalSpacesBloc, SetTotalSpacesState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SetTotalSpacesLoaded) {
           
            BlocProvider.of<ManageSpacesBloc>(context)
                .add(ManageSpacesLoadEvent());
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Total de vagas atualizado")));
          }
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SingleChildScrollView(
                  child: BlocBuilder<SetTotalSpacesBloc, SetTotalSpacesState>(
                    builder: (context, state) {
                      if (state is SetTotalSpacesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is SetTotalSpacesError) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      }
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Quantas vagas há no estabelecimento?",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onEditingComplete: () {
                              if (spaces.text.isNotEmpty) {
                                if (int.parse(spaces.text) <
                                    widget.totalSpaces) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Parece que você diminuiu a quantiade de vagas. Se eu fosse fazer esse app por completo, eu ia valdiar as informações salvas paga as vagas excluídas")));
                                }
                                BlocProvider.of<SetTotalSpacesBloc>(context)
                                    .add(SetTotalSpacesSetEvent(
                                        spaces: int.parse(spaces.text)));
                              }
                            },
                            controller: spaces,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(labelText: "Ex: 20"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (spaces.text.isNotEmpty) {
                                  BlocProvider.of<SetTotalSpacesBloc>(context)
                                      .add(SetTotalSpacesSetEvent(
                                          spaces: int.parse(spaces.text)));
                                }
                              },
                              child: Text(
                                "Confirmar",
                              ))
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        )),
      ),
    );
  }
}
