import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceScreen extends StatelessWidget {
  final String carId;

  const ServiceScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Servis")),

      body: Center(child: Text("Auto ID: $carId")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/service/$carId/add');
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
