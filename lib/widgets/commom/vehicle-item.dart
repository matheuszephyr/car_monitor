import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/widgets/vehicle_view/vehicle-view.dart';
import 'package:flutter/material.dart';

class VehicleItem extends StatefulWidget {
  final Vehicle vehicle;
  bool warning = true;

  VehicleItem({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<VehicleItem> createState() => _VehicleItemState();
}

class _VehicleItemState extends State<VehicleItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.white, Colors.white]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(colors: [
                      Colors.deepPurple,
                      Colors.deepPurple,
                      Colors.white,
                      Colors.white
                    ], stops: [
                      0.2,
                      0.5,
                      1,
                      1
                    ]),
                  ),
                  child: CircleAvatar(
                    child: Image.asset(widget.vehicle.image.toString()),
                    minRadius: 30,
                    maxRadius: 40,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //padding: const EdgeInsets.all(8.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.directions_car,
                                  color: Colors.deepPurple, size: 25),
                              Text(
                                "${widget.vehicle.model} - ${widget.vehicle.year.toString()}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.deepPurple, size: 25),
                              Text(
                                widget.vehicle.fabricator,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                            ],
                          ),
                          widget.vehicle.warning == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Icon(Icons.warning,
                                        color: Colors.orange, size: 25),
                                    Text(
                                      "Manutenção Necessária",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 17,
                                          color: Colors.orange),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: const [
                                    Icon(Icons.where_to_vote,
                                        color: Colors.green, size: 25),
                                    Text(
                                      "Manutenção Ok",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 17,
                                          color: Colors.green,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.deepPurple,
                          size: 50,
                          //textDirection: TextDirection.ltr,
                        ),
                        tooltip: 'Ver Veículo',
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VehicleView(vehicle: widget.vehicle)),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
