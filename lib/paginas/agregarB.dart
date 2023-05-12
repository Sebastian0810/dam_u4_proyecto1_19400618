import 'dart:ui';

import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class AgregarB extends StatefulWidget {
  const AgregarB({Key? key}) : super(key: key);

  @override
  State<AgregarB> createState() => _AgregarBState();
}

List Placa = ["Selecciona las placas"];
String _Placa = Placa.first;

class _AgregarBState extends State<AgregarB> {
  TextEditingController placa = TextEditingController(text: "");
  TextEditingController fecha = TextEditingController(text: "");
  DateTime date = DateTime.now();
  String mes = "";
  TextEditingController evento = TextEditingController(text: "");
  TextEditingController recursos = TextEditingController(text: "");
  TextEditingController verifico = TextEditingController(text: "");
  TextEditingController fechaverificacion = TextEditingController(text: "");
  DateTime dateV = DateTime.now();
  String mesV = "";

  void _fecha(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025)).then((value){
          setState(() {
            date = value!;
            if(date.month.toString() == "1"){mes = "Enero";}
            else if(date.month.toString() == "2"){mes = "Febrero";}
            else if(date.month.toString() == "3"){mes = "Marzo";}
            else if(date.month.toString() == "4"){mes = "Abril";}
            else if(date.month.toString() == "5"){mes = "Mayo";}
            else if(date.month.toString() == "6"){mes = "Junio";}
            else if(date.month.toString() == "7"){mes = "Julio";}
            else if(date.month.toString() == "8"){mes = "Agosto";}
            else if(date.month.toString() == "9"){mes = "Septiembre";}
            else if(date.month.toString() == "10"){mes = "Octubre";}
            else if(date.month.toString() == "11"){mes = "Noviembre";}
            else if(date.month.toString() == "12"){mes = "Diciembre";}

            fecha.text = " ${date.day.toString()} / ${mes} / ${date.year.toString()}";
          });
    });
  }

  void _fechaV(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025)).then((value){
      setState(() {
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
            title: const Text("Agregar Bitacora"),
            centerTitle: true,
            backgroundColor: Colors.red
        ),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children:[
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: obtenerPlacas(),
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        Placa.clear();
                        Placa.add("Selecciona las placas");
                        return Container(
                          height: 0,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Placa.add(snapshot.data![index]['placa'].toString());
                              return Text(snapshot.data![index]['placa'].toString());
                            },
                          ),
                        );
                      }else {return Text("");}
                    },
                  ),

                  DropdownButtonFormField(
                    value: _Placa,
                    items: Placa.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      _Placa = value.toString();
                      setState(() {});
                    }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                    decoration: InputDecoration(labelText: "Selecciona las placas",
                        prefixIcon: Image.asset('assets/placa.png', width: 10, height: 10, scale: 8),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 25),

                  TextFormField(decoration: InputDecoration(labelText: "Fecha",
                      border: OutlineInputBorder(),
                      prefixIcon: Image.asset("assets/calendario.png", height: 30, width: 30, scale: 15,)),
                      controller: fecha,
                      readOnly: true,
                  onTap: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _fecha();
                  }),

                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Evento",
                      hintText: "Ingrese la descripción del propósito"),
                    controller: evento),
                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Recursos",
                      hintText: "Ingrese los recursos que se utilizaron"),
                    controller: recursos),
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
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {
                      _fechaV();
                    });
                  }),
                  SizedBox(height: 20),

                  ElevatedButton(onPressed: () async{
                    await agregarBitacora(_Placa.toString(), fecha.text, evento.text, recursos.text,
                    verifico.text, fechaverificacion.text).then((_) {
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
