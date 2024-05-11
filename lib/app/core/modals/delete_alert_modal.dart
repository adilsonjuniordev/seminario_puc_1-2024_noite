import 'package:flutter/material.dart';

class DeleteAlertModal extends StatefulWidget {
  const DeleteAlertModal({super.key});

  @override
  State<DeleteAlertModal> createState() => _DeleteAlertModalState();
}

class _DeleteAlertModalState extends State<DeleteAlertModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Excluir Veículo'),
      content: const Text(
        'Você tem certeza que deseja excluir o veículo?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Excluir'),
        ),
      ],
    );
  }
}
