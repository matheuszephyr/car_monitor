import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/widgets/commom/vehicle-item.dart';
import 'package:carmonitor/widgets/home/vehicle_list.dart';
import 'package:carmonitor/widgets/home/vehicle_list_bloc.dart';
import 'package:carmonitor/widgets/vehicle_edit/vehicle/vehicle_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/vehicle-service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Veículos"),
      ),
      body: BlocProvider(
        create: (context) => VehicleListBloc(),
        child: const VehicleList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VehicleAddPage()),
                            )
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
