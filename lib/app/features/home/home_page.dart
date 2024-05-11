import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/components/vehicle_card.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/modals/delete_alert_modal.dart';
import 'package:puc_minas/app/core/models/vehicle_model.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
          var vehicle = await Navigator.of(context).pushNamed(AppRoutes.add);

          if (vehicle != null) {
            vehicles.add(vehicle as VehicleModel);
            setState(() {});
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.time_to_leave,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            vehicles.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum veículo para exibir',
                    ),
                  )
                : ListView.builder(
                    itemCount: vehicles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          bool? deleted = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return const DeleteAlertModal();
                            },
                          );

                          if (deleted ?? false) {
                            try {
                              vehicles.removeAt(index);
                              setState(() {});
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.success(message: 'O veículo foi excluído'),
                              );
                            } catch (e) {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.error(message: 'O veículo não pode ser excluído'),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: VehicleCard(
                            vehicle: vehicles[index],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
