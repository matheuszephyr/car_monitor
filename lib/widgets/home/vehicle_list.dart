import 'package:carmonitor/widgets/home/vehicle_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../commom/vehicle-item.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({Key? key}) : super(key: key);

  Future<void> refreshList(BuildContext context) async {
    context.read<VehicleListBloc>().add(VehicleListLoad());
  }

  @override
  Widget build(BuildContext context) {

    context.read<VehicleListBloc>().add(VehicleListLoad());

    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<VehicleListBloc, VehicleListState>(
            builder: (context, state) {
              if (state is VehicleListInitialState) {
                return RefreshIndicator(
                  onRefresh: () => refreshList(context),
                  child: ListView.builder(
                    //padding: const EdgeInsets.all(8.0),
                    itemCount: state.vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = state.vehicles[index];
                      return VehicleItem(vehicle: vehicle);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                    strokeWidth: 3,
                  ),
                );
              }
            }),
      ),
    );
  }
}
