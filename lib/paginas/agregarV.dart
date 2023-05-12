import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class AgregarV extends StatefulWidget {
  const AgregarV({Key? key}) : super(key: key);

  @override
  State<AgregarV> createState() => _AgregarVState();
}

List Tipo = ["Camión", "Coche", "Camioneta", "Tracktor", "Motocicleta"];
String _Tipo = Tipo.first;

List Combustible = ["Diésel", "Gasolina regular", "Gasolina premium"];
String _Combustible = Combustible.first;

List Depto = ["Materiales", "Jardineria", "Dirección", "Seguridad"];
String _Depto = Depto.first;

class _AgregarVState extends State<AgregarV> {
  TextEditingController placa = TextEditingController(text: "");
  TextEditingController numero = TextEditingController(text: "");
  TextEditingController tanque = TextEditingController(text: "");
  TextEditingController trabajador = TextEditingController(text: "");
  TextEditingController resguardado = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Agregar vehiculo"),
            centerTitle: true,
            backgroundColor: Colors.red
        ),

        body: ListView(padding: EdgeInsets.all(15),
        children: [
          Column(
            children:[
              TextFormField(decoration: InputDecoration(labelText: "Placas del vehiculo",
              hintText: "Ingrese las placas del vehiculo",
                  //focusedBorder: UnderlineInputBorder(
                    //borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  //)
              ),
              controller: placa,
              autofocus: true,),

              SizedBox(height: 30),
              DropdownButtonFormField(
                value: _Tipo,
                items: Tipo.map((value){
                  return DropdownMenuItem(
                      child: Text(value), value: value);
                }).toList(),
                onChanged: (value){
                  setState(() {
                    _Tipo = value.toString();
                  });
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
              DropdownButtonFormField(
                value: _Combustible,
                items: Combustible.map((value){
                  return DropdownMenuItem(
                      child: Text(value), value: value);
                }).toList(),
                onChanged: (value){
                  setState(() {_Combustible = value.toString();});
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
              DropdownButtonFormField(
                value: _Depto,
                items: Depto.map((value){
                  return DropdownMenuItem(
                      child: Text(value), value: value);
                }).toList(),
                onChanged: (value){
                  setState(() {
                    _Depto = value.toString();
                  });
                  }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                decoration: InputDecoration(labelText: "Selecciona el departamento",
                    prefixIcon: Image.asset('assets/departamento.png', width: 10, height: 10),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10),

              TextField(decoration: const InputDecoration(hintText: "Ingrese el jefe del departamento",
                  labelText: "Jefe de departamento"),
                  controller: resguardado),
              SizedBox(height: 20),

              ElevatedButton(onPressed: () async{
                await agregarVehiculo(placa.text, _Tipo.toString(), numero.text, _Combustible.toString(), int.parse(tanque.text),
                    trabajador.text, _Depto.toString(), resguardado.text).then((_) {
                      Navigator.pop(context);
                    });
                }, child: const Text("Guardar"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red
                ),
              )
            ],
          )
        ]
        )
    );
  }
}
