import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/models/vehicle_model.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<VehicleModel> vehicles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              bool result = await HomeController.logout();
              if (result) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         VehicleModel? vehicle = await Navigator.of(context).pushNamed(AppRoutes.add);

         if (vehicle != null) {
          vehicles.add(vehicle);
         }
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.time_to_leave,
          color: Colors.white,
        ),
      ),
      body: Container(),
    );
  }
}
