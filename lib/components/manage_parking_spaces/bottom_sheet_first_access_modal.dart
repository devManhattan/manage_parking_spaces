import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/manage_spaces/manage_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/set_total_spaces/set_total_spaces_bloc.dart';

class BottomSheetFistAccessModal extends StatefulWidget {
  const BottomSheetFistAccessModal({super.key});

  @override
  State<BottomSheetFistAccessModal> createState() =>
      _BottomSheetFistAccessModalState();
}

class _BottomSheetFistAccessModalState
    extends State<BottomSheetFistAccessModal> {
  TextEditingController spaces = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SetTotalSpacesBloc, SetTotalSpacesState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SetTotalSpacesLoaded) {
          Navigator.pop(context, true);
          BlocProvider.of<ManageSpacesBloc>(context).add(ManageSpacesLoadEvent());
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Total de vagas atualizado")));
        }
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
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
                            BlocProvider.of<SetTotalSpacesBloc>(context).add(
                                SetTotalSpacesSetEvent(
                                    spaces: int.parse(spaces.text)));
                          }
                        },
                        controller: spaces,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Ex: 20"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (spaces.text.isNotEmpty) {
                              BlocProvider.of<SetTotalSpacesBloc>(context).add(
                                  SetTotalSpacesSetEvent(
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
          ),
        );
      }),
    );
  }
}
