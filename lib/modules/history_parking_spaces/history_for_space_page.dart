import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manage_parking_spaces/core/date_formatter.dart';
import 'package:manage_parking_spaces/models/parking_paces/space_model.dart';

class HistoryForSpace extends StatefulWidget {
  const HistoryForSpace({super.key, required this.history});
  final List<SpaceModel>? history;
  @override
  State<HistoryForSpace> createState() => _HistoryForSpaceState();
}

class _HistoryForSpaceState extends State<HistoryForSpace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (widget.history != null)
                  for (int counterHistory = 0;
                      counterHistory < widget.history!.length;
                      counterHistory++)
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Card(
                        color: widget.history![counterHistory].available ? Colors.green[400] : Colors.red[400],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Vaga: " + widget.history![counterHistory].number
                                  .toString()),
                              Text("Situação: ${widget.history![counterHistory].available ? 'Disponível' : 'Indisponível'}"),
                               Text("${DateFormatter.brasilDateFormatWithHour.format(DateTime.parse(widget.history![counterHistory].dateUpdated))}")
                            ],
                          ),
                        ),
                      ),
                    )
              ],
            ),
          );
        }),
      )),
    );
  }
}
