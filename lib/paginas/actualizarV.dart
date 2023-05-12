import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class ActualizarV extends StatefulWidget {
  const ActualizarV({Key? key}) : super(key: key);

  @override
  State<ActualizarV> createState() => _ActualizarVState();
}

List Tipo = ["Camión", "Coche", "Camioneta", "Tracktor", "Motocicleta"];

List Combustible = ["Diésel", "Gasolina regular", "Gasolina premium"];

List Depto = ["Materiales", "Jardineria", "Dirección", "Seguridad"];

class _ActualizarVState extends State<ActualizarV> {
  TextEditingController placa = TextEditingController(text: "");
  TextEditingController numero = TextEditingController(text: "");
  TextEditingController tanque = TextEditingController(text: "");
  TextEditingController trabajador = TextEditingController(text: "");
  TextEditingController resguardado = TextEditingController(text: "");

  String combustible = "";
  String tipo = "";
  String depto = "";

  @override
  Widget build(BuildContext context) {
    final Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    placa.text = argumentos['placa'];
    numero.text = argumentos['numeroserie'];
    tanque.text = argumentos['tanque'].toString();
    trabajador.text = argumentos['trabajador'];
    resguardado.text = argumentos['resguardadopor'];

    //Combobox
    tipo = argumentos['tipo'];
    combustible = argumentos['combustible'];
    depto = argumentos['depto'];

    return Scaffold(
        appBar: AppBar( title: const Text("Editar vehiculo"), centerTitle: true, backgroundColor: Colors.red),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children: [
                  TextField(decoration: const InputDecoration(labelText: "Placas del vehiculo",
                      hintText: "Ingrese las placas del vehiculo"),
                      controller: placa),

                  SizedBox(height: 30),
                  Text("Vehiculo actual: ${tipo}"),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    value: tipo,
                    items: Tipo.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                        tipo = value.toString();
                      }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                    decoration: InputDecoration(labelText: "Selecciona el tipo de vehiculo",
                        prefixIcon: Image.asset('assets/vehiculo.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  TextField(decoration: const InputDecoration(labelText: "Número de serie",
                      hintText: "Ingrese el numero de serie"),
                      controller: numero),

                  SizedBox(height: 30),
                  Text("Combustible actual: ${combustible}"),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    value: combustible,
                    items: Combustible.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      combustible = value.toString();
                      }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                    decoration: InputDecoration(labelText: "Selecciona el tipo de combustible",
                        prefixIcon: Image.asset('assets/combustible.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  TextField(decoration: const InputDecoration(labelText: "Litros del tanque",
                      hintText: "Ingrese los litros de gasolina del tanque"),
                      controller: tanque),
                  SizedBox(height: 10),
                  TextField(decoration: const InputDecoration(labelText: "Trabajador del vehiculo",
                      hintText: "Ingrese el trabajador del vehiculo"),
                      controller: trabajador),

                  SizedBox(height: 30),
                  Text("Departamento actual: ${depto}"),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    value: depto,
                    items: Depto.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                        depto = value.toString();
                      }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                    decoration: InputDecoration(labelText: "Selecciona el departamento",
                        prefixIcon: Image.asset('assets/departamento.png', width: 10, height: 10),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  TextField(decoration: const InputDecoration(hintText: "Ingrese el jefe del departamento", labelText: "Jefe de departamento"),
                      controller: resguardado),
                  SizedBox(height: 20),

                  ElevatedButton(onPressed: () async{
                    await actualizarVehiculo(placa.text, tipo.toString(), numero.text, combustible.toString(), int.parse(tanque.text),
                        trabajador.text, depto.toString(), resguardado.text, argumentos['id']).then((_) {
                        Navigator.pop(context);
                      });
                    },child: const Text("Actualizar"),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red)
                  )
                ],
              )
            ]
        )
    );
  }
}
