import 'package:flutter/material.dart';
import 'registro_parqueo.dart';
import 'formulario_parqueadero.dart';
import 'historial.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  bool mostrarHistorial = false;
  List<Registro> registros = [];

  final GlobalKey<FormularioParqueaderoState> _formularioKey = GlobalKey();

  void registrarSalida(Registro r) {
    final horaActual = TimeOfDay.now().format(context);
    final salidaRegistrada = r.registrarSalida(horaActual);

    final mensaje = salidaRegistrada
        ? 'Salida registrada para ${r.placa}'
        : 'Este vehículo ya salió';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void registrarVehiculo(Registro nuevo) {
    if (!nuevo.placaValida()) {
      mostrarDialogo(
        'Formato inválido',
        'La placa ${nuevo.placa} no cumple el formato esperado para un ${nuevo.tipoVehiculo}.',
      );
      return;
    }

    final placaIgual = registros.any((r) => r.placa == nuevo.placa);

    if (placaIgual) {
      mostrarDialogo(
        'Placa duplicada',
        'Ya existe un registro con la placa ${nuevo.placa}.',
      );
      return;
    }

    setState(() {
      registros.add(nuevo);
      mostrarHistorial = true;
    });

    mostrarDialogo('Registro exitoso', nuevo.resumen());
    _formularioKey.currentState?.limpiarCampos();
  }

  void mostrarDialogo(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              'Menú Principal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 350,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FormularioParqueadero(
                  key: _formularioKey,
                  onGuardar: registrarVehiculo,
                ),
              ),
            ),
          ),
          if (mostrarHistorial)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistorialParqueadero(
                        registros: registros,
                        onRegistrarSalida: registrarSalida,
                      ),
                    ),
                  );
                },
                child: Text('Ver historial'),
              ),
            ),
        ],
      ),
    );
  }
}
