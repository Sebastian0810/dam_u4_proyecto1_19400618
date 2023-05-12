import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class Bitacora extends StatefulWidget {
  const Bitacora({Key? key}) : super(key: key);

  @override
  State<Bitacora> createState() => _BitacoraState();
}

class _BitacoraState extends State<Bitacora> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bitacora"), centerTitle: true, backgroundColor: Colors.red),

      body: FutureBuilder(
          future: obtenerBitacora(),
          builder: ((context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index]['verifico']),
                          subtitle: Text(snapshot.data?[index]['placa'],),
                          trailing: Text(snapshot.data?[index]['fechaverificacion']),
                          leading: Text(snapshot.data?[index]['fecha']),
                          onTap: () async{
                            await Navigator.pushNamed(context, '/actualizarB', arguments: {
                              "placa":snapshot.data?[index]['placa'],
                              "fecha":snapshot.data?[index]['fecha'],
                              "evento":snapshot.data?[index]['evento'],
                              "recursos":snapshot.data?[index]['recursos'],
                              "verifico":snapshot.data?[index]['verifico'],
                              "fechaverificacion":snapshot.data?[index]['fechaverificacion'],
                              "id": snapshot.data?[index]['id']
                            });
                            setState(() {});
                            },
                        );
                  }
              );
            } else { return const Center(child: CircularProgressIndicator());}
          }
          )
      ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async{
            await Navigator.pushNamed(context, '/agregarB');
            setState(() {});
          }, child: const Icon(Icons.add)
      ),
    );
  }
}