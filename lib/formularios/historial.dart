import 'package:flutter/material.dart';
import 'registro_parqueo.dart';

class HistorialParqueadero extends StatelessWidget {
  final List<Registro> registros;
  final void Function(Registro) onRegistrarSalida;

  const HistorialParqueadero({
    super.key,
    required this.registros,
    required this.onRegistrarSalida,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial de Clientes')),
      body: ListView.builder(
        itemCount: registros.length,
        itemBuilder: (_, index) {
          final r = registros[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.nombrePropietario,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(r.resumen()),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => onRegistrarSalida(r),
                    child: Text('Registrar salida'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
