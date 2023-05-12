import 'package:dam_u4_proyecto1_19400618/services/servicios.dart';
import 'package:flutter/material.dart';

class Vehiculo extends StatefulWidget {
  const Vehiculo({Key? key}) : super(key: key);

  @override
  State<Vehiculo> createState() => _VehiculoState();
}

class _VehiculoState extends State<Vehiculo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vehiculos"), centerTitle: true, backgroundColor: Colors.red),

      body: FutureBuilder(
            future: obtenerVehiculo(),
          builder: ((context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(child: const Icon(Icons.delete)),
                      key: Key(snapshot.data?[index]['id']),
                    onDismissed: (direction) async{
                        await borrarVehiculo(snapshot.data?[index]['id']);
                        snapshot.data?.removeAt(index);
                    },
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (direction) async{
                        bool resultado = false;
                        resultado = await showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Estas seguro que quieres eliminar el/la ${snapshot.data?[index]['tipo']} con las placas ${snapshot.data?[index]['placa']}"),
                            actions: [
                              TextButton(onPressed: (){ return Navigator.pop(context, false);},
                                  child: const Text("No", style: TextStyle(color: Colors.red))),
                              TextButton(onPressed: (){ return Navigator.pop(context, true);},
                                  child: const Text("Si"))
                            ],
                          );
                        });
                        return resultado;
                    },
                    child: ListTile(
                      title: Text(snapshot.data?[index]['placa']),
                      subtitle: Text(snapshot.data?[index]['tipo'],),
                      trailing: Text(snapshot.data?[index]['combustible']),
                      leading: Text("Departamento:\n${snapshot.data?[index]['depto']}", textAlign: TextAlign.center),
                      onTap: () async{
                        await Navigator.pushNamed(context, '/actualizarV', arguments: {
                          "placa": snapshot.data?[index]['placa'],
                          "tipo": snapshot.data?[index]['tipo'],
                          "numeroserie": snapshot.data?[index]['numeroserie'],
                          "combustible": snapshot.data?[index]['combustible'],
                          "tanque": snapshot.data?[index]['tanque'],
                          "trabajador": snapshot.data?[index]['trabajador'],
                          "depto": snapshot.data?[index]['depto'],
                          "resguardadopor": snapshot.data?[index]['resguardadopor'],
                          "id": snapshot.data?[index]['id']
                        });
                        setState(() {});
                      },
                    ),
                    );
                  }
              );
            } else { return const Center(child: CircularProgressIndicator());}
          })),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async{
          await Navigator.pushNamed(context, '/agregarV');
          setState(() {});
        }, child: const Icon(Icons.add)
      ),
    );
  }
}