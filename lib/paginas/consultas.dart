import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({Key? key}) : super(key: key);

  @override
  State<Consultas> createState() => _ConsultasState();
}

List Depto = ["Materiales", "Jardineria", "Dirección", "Seguridad"];
String _Depto = Depto.first;

List Placa = ["Selecciona las placas"];
String _Placa = Placa.first;

List placasFechaVacia = [];

class _ConsultasState extends State<Consultas> {
  TextEditingController fecha = TextEditingController(text: "");
  DateTime date = DateTime.now();
  String mes = "";
  double tam1 = 0;
  double tam2 = 0;
  double tam3 = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Consultas")
          ,centerTitle: true,
          backgroundColor: Colors.red),

      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            //----------------------------CONSULTA 1----------------------------
            Text("(1) Consultar bitacora por medio de las placas de un vehiculo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            SizedBox(height: 20),

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
                setState(() {
                  Placa;
                  _Placa = value.toString();
                  tam1 = 100;
                });
              }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
              decoration: InputDecoration(labelText: "Selecciona la placa",
                  prefixIcon: Image.asset('assets/placa.png', width: 10, height: 10, scale: 8),
                  border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 20),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerBitacoraPlaca(_Placa),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: tam1,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('\n Fecha: ${snapshot.data![index]['fecha'].toString()} '
                            '\n Evento: ${snapshot.data![index]['evento']} '
                            '\n Recursos: ${snapshot.data![index]['recursos']} '
                            '\n Verficado por: ${snapshot.data![index]['verifico']} '
                            '\n Fecha de verificación: ${snapshot.data![index]['fechaverificacion'].toString()} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                }else {return Text("");
                }
              },
            ),

            //----------------------------CONSULTA 2----------------------------
            SizedBox(height: 50),
            Text("(2) Consultar bitacora de TODOS los vehiculos según su fecha",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            SizedBox(height: 10),

            TextFormField(decoration: InputDecoration(labelText: "Fecha",
                border: OutlineInputBorder(),
                prefixIcon: Image.asset("assets/calendario.png", height: 30, width: 30, scale: 15,)),
                controller: fecha,
                readOnly: true,
                onTap: (){
                  tam2 = 100;
                  _fecha();
                  FocusScope.of(context).requestFocus(new FocusNode());
                }),
            SizedBox(height: 10),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerBitacoraFecha(fecha.text),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: tam2,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('\n Placa: ${snapshot.data![index]['placa']}'
                            '\n Evento: ${snapshot.data![index]['evento']} '
                            '\n Recursos: ${snapshot.data![index]['recursos']} '
                            '\n Verficado por: ${snapshot.data![index]['verifico']} '
                            '\n Fecha de verificación: ${snapshot.data![index]['fechaverificacion'].toString()} \n',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                }else {return Text("");}
              },
            ),

            //----------------------------CONSULTA 3----------------------------
            SizedBox(height: 50),
            Text("(3) Consultar vehiculos que estén en uso o fuera de la institución",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            SizedBox(height: 10),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerPlacasFechaVacia(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  placasFechaVacia.clear();
                  return Container(
                    height: 0,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        placasFechaVacia.add(snapshot.data![index]['placa']);
                        return Text(snapshot.data![index]['placa']);
                      },
                    ),
                  );
                }else {return Text("");}
              },
            ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerVehiculoEnUso(placasFechaVacia),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('Placa: ${snapshot.data![index]['placa']} '
                            '\n Tipo de vehiculo: ${snapshot.data![index]['tipo']} '
                            '\n Número de serie: ${snapshot.data![index]['numeroserie']} '
                            '\n Combustible: ${snapshot.data![index]['combustible']} '
                            '\n Litros en el tanque: ${snapshot.data![index]['tanque']} '
                            '\n Trabajador: ${snapshot.data![index]['trabajador']} '
                            '\n Departamento: ${snapshot.data![index]['depto']} '
                            '\n Jefe de departamento: ${snapshot.data![index]['resguardadopor' ]} \n',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                }else {return Text("");}
              },
            ),

            //----------------------------CONSULTA 4----------------------------
            SizedBox(height: 50),
            Text("(4) Consultar vehiculoS por medio del departamento",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            SizedBox(height: 20),

            DropdownButtonFormField(
                value: _Depto,
                items: Depto.map((valor){
                  return DropdownMenuItem(child: Text(valor),value: valor);
                }).toList(),
                onChanged: (valor){
                  setState(() {
                    _Depto = valor.toString();
                    tam3 = 100;
                  });
                }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
              decoration: InputDecoration(labelText: "Selecciona el departamento",
                  prefixIcon: Image.asset('assets/departamento.png', width: 10, height: 10, scale: 15),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerVehiculoDepto(_Depto),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: tam3,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('Placa: ${snapshot.data![index]['placa']} '
                            '\n Tipo de vehiculo: ${snapshot.data![index]['tipo']} '
                            '\n Número de serie: ${snapshot.data![index]['numeroserie']} '
                            '\n Combustible: ${snapshot.data![index]['combustible']} '
                            '\n Litros en el tanque: ${snapshot.data![index]['tanque']} '
                            '\n Trabajador: ${snapshot.data![index]['trabajador']} '
                            '\n Jefe de departamento: ${snapshot.data![index]['resguardadopor' ]} \n',
                          textAlign: TextAlign.center,
                        );
                        },
                    ),
                  );
                }else if (snapshot.hasError) {return Text('Error: ${snapshot.error}');
                }else {return Text('Loading...');}
                },
            ),

          ]
      ),
    );
  }
}
