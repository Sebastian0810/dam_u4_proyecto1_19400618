import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class ActualizarB extends StatefulWidget {
  const ActualizarB({Key? key}) : super(key: key);

  @override
  State<ActualizarB> createState() => _ActualizarBState();
}

class _ActualizarBState extends State<ActualizarB> {
  TextEditingController fecha = TextEditingController(text: "");
  TextEditingController evento = TextEditingController(text: "");
  TextEditingController recursos = TextEditingController(text: "");
  TextEditingController verifico = TextEditingController(text: "");
  TextEditingController fechaverificacion = TextEditingController(text: "");
  TextEditingController placa = TextEditingController(text: "");
  DateTime dateV = DateTime.now();
  String mesV = "";

   void _fechaV(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025)).then((value){
      //setState(() {
        dateV = value!;
        if(dateV.month.toString() == "1"){mesV = "Enero";}
        else if(dateV.month.toString() == "2"){mesV = "Febrero";}
        else if(dateV.month.toString() == "3"){mesV = "Marzo";}
        else if(dateV.month.toString() == "4"){mesV = "Abril";}
        else if(dateV.month.toString() == "5"){mesV = "Mayo";}
        else if(dateV.month.toString() == "6"){mesV = "Junio";}
        else if(dateV.month.toString() == "7"){mesV = "Julio";}
        else if(dateV.month.toString() == "8"){mesV = "Agosto";}
        else if(dateV.month.toString() == "9"){mesV = "Septiembre";}
        else if(dateV.month.toString() == "10"){mesV = "Octubre";}
        else if(dateV.month.toString() == "11"){mesV = "Noviembre";}
        else if(dateV.month.toString() == "12"){mesV = "Diciembre";}

        fechaverificacion.text = " ${dateV.day.toString()} / ${mesV} / ${dateV.year.toString()}";
      //});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    placa.text = argumentos['placa'];
    fecha.text = argumentos['fecha'];
    evento.text = argumentos['evento'];
    recursos.text = argumentos['recursos'];
    verifico.text = argumentos['verifico'];
    fechaverificacion.text = argumentos['fechaverificacion'];

    return Scaffold(
        appBar: AppBar( title: const Text("Editar bitacora"), centerTitle: true, backgroundColor: Colors.red),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children: [
                  TextField(decoration: const InputDecoration(labelText: "Placas del vehiculo",
                      hintText: "Ingrese las placas del vehiculo"),
                      controller: placa, enabled: false),
                  SizedBox(height: 25),

                  TextFormField(decoration: InputDecoration(labelText: "Fecha",
                      border: OutlineInputBorder(),
                      prefixIcon: Image.asset("assets/calendario.png", height: 30, width: 30, scale: 15,)),
                      controller: fecha,
                      enabled: false),
                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Evento",
                      hintText: "Ingrese la descripción del propósito"),
                    controller: evento, enabled: false,),
                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Recursos",
                      hintText: "Ingrese los recursos que se utilizaron"),
                    controller: recursos, enabled: false,),
                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Verifico",
                      hintText: "Ingrese el nombre de la persona que verifico la salida"),
                    controller: verifico),
                  SizedBox(height: 20),

                  TextField(decoration: InputDecoration(labelText: "Fecha de verificación",
                      border: OutlineInputBorder(),
                      prefixIcon: Image.asset("assets/calendario.png", height: 30, width: 30, scale: 15,)),
                      controller: fechaverificacion,
                      readOnly: true,
                      onTap: (){
                          _fechaV();
                      }),
                  SizedBox(height: 20),

                  ElevatedButton(onPressed: () async{
                    await actualizarBitacora(placa.text, fecha.text, evento.text, recursos.text,
                        verifico.text, fechaverificacion.text, argumentos['id']).then((_) {
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
