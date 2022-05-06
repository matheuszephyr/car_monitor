import 'package:carmonitor/util/alerts.dart';
import 'package:carmonitor/widgets/vehicle_view/vehicle_data_card.dart';
import 'package:carmonitor/widgets/vehicle_view/vehicle_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/vehicle.dart';
import '../../models/vehicle_data_card.dart';

class VehicleProfile extends StatelessWidget {
  const VehicleProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<VehicleViewBloc>().add(VehicleViewLoadEvent());    

    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<VehicleViewBloc, VehicleViewState>(
          builder: (context, state) {
            if (state is VehicleViewPopulateState) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.black87,
                        Colors.black87
                      ], stops: [
                        0.2,
                        0.5,
                        1,
                        1
                      ]),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: CircleAvatar(
                        child: Image.asset(state.vehicle.image.toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Text(
                    "${state.vehicle.model} - ${state.vehicle.year.toString()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.purple,
                    height: 5,
                    thickness: 2,
                    //indent: 22,
                    endIndent: 0,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.pink, size: 25),
                      const SizedBox(width: 5),
                      Text(
                        state.vehicle.fabricator,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.speed, color: Colors.pink, size: 25),
                      const SizedBox(width: 5),
                      Text(
                        "${state.vehicle.odometer.toString()} Km",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.purple,
                    height: 5,
                    thickness: 2,
                    //indent: 22,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.vehicleDataCards.length,
                      itemBuilder: (context, index) {
                        final card = state.vehicleDataCards[index];
                        return VehicleDataCard(
                          type: card.type,
                          idVehicle: state.vehicle.id,
                          icon: card.icon,
                          label: card.label,
                          lastDate: card.lastDate,
                          nextDate: card.nextDate,
                          odometer: state.vehicle.odometer,
                          nextKm: card.nextKm,
                          lastKm: card.lastKm,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is VehicleViewLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                  strokeWidth: 5,
                ),
              );
            } 
            else {          
              return Center(                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 100,),                    
                    Text(state.error, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
