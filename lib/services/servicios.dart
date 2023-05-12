import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//--------------------------------Vehiculo--------------------------------------

//Obtener registros de la base de datos Vehiculo
Future <List> obtenerVehiculo()async{
  List v = [];
  QuerySnapshot consulta = await db.collection('Vehiculo').get();
  for(var doc in consulta.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final vehiculos ={
      "placa": data['placa'],
      "tipo": data['tipo'],
      "numeroserie": data['numeroserie'],
      "combustible": data['combustible'],
      "tanque": data['tanque'],
      "trabajador": data['trabajador'],
      "depto": data['depto'],
      "resguardadopor": data['resguardadopor'],
      "id": doc.id,
    };
    v.add(vehiculos);
  }
  return v;
}

//Guardar en la base de datos Vehiculo
Future<void> agregarVehiculo(String placa, String tipo, String numeroserie, String combustible,
    int tanque, String trabajador, String depto, String resguardadopor) async{
  await db.collection("Vehiculo").add({"placa": placa, "tipo": tipo, "numeroserie":numeroserie,
  "combustible": combustible, "tanque":tanque, "trabajador": trabajador, "depto": depto,
  "resguardadopor":resguardadopor});
}

//Actualizar en la base de datos Vehiculo
Future<void> actualizarVehiculo(String placa, String tipo, String numeroserie, String combustible,
int tanque, String trabajador, String depto, String resguardadopor, String id) async{
await db.collection("Vehiculo").doc(id).set({"placa": placa, "tipo": tipo, "numeroserie":numeroserie,
"combustible": combustible, "tanque":tanque, "trabajador": trabajador, "depto": depto,
"resguardadopor":resguardadopor});
}

//Borrar en la base de datos Vehiculo
Future <void> borrarVehiculo(String id) async{
  await db.collection("Vehiculo").doc(id).delete();
}

//--------------------------------Bitacora--------------------------------------
//Obtener registros de la base de datos Bitacora
Future <List> obtenerBitacora()async{
  List b = [];
  QuerySnapshot consulta = await db.collection('Bitacora').get();
  for(var doc in consulta.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bitacoras ={
      "placa":data['placa'],
      "fecha":data['fecha'],
      "evento":data['evento'],
      "recursos":data['recursos'],
      "verifico":data['verifico'],
      "fechaverificacion":data['fechaverificacion'],
      "id": doc.id,
  };
    b.add(bitacoras);
  }
  return b;
}

//Guardar en la base de datos Bitacora
Future<void> agregarBitacora(String placa, String fecha, String evento, String recursos, String verifico, String fechaverificacion) async{
  await db.collection("Bitacora").add({"placa":placa, "fecha":fecha, "evento":evento, "recursos":recursos, "verifico":verifico, "fechaverificacion":fechaverificacion});
}

//Actualizar en la base de datos Bitacora
Future<void> actualizarBitacora(String placa, String fecha, String evento, String recursos, String verifico, String fechaverificacion, String id) async{
  await db.collection("Bitacora").doc(id).set({"placa":placa,"fecha":fecha, "evento":evento, "recursos":recursos, "verifico":verifico, "fechaverificacion":fechaverificacion});
}

//---------------------------------Consultas------------------------------------
Future<List<Map<String, dynamic>>> obtenerPlacas() async {
  List<Map<String, dynamic>> vehiculos = [];
  QuerySnapshot querySnapshot = await db.collection("Vehiculo").get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    vehiculos.add(
        {
          'placa': data['placa']
        });
  }
  return vehiculos;
}

Future<List<Map<String, dynamic>>> obtenerVehiculoDepto(String d) async {
  List<Map<String, dynamic>> vehiculos = [];
  QuerySnapshot querySnapshot = await db.collection("Vehiculo").where("depto", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    vehiculos.add(
        {
          'placa': data['placa'],
          'tipo': data['tipo'],
          'combustible': data['combustible'],
          'numeroserie': data['numeroserie'],
          'trabajador': data['trabajador'],
          'tanque': data['tanque'],
          'resguardadopor': data['resguardadopor']
        });
  }
  return vehiculos;
}

Future<List<Map<String, dynamic>>> obtenerBitacoraPlaca(String d) async {
  List<Map<String, dynamic>> bitacora = [];
  QuerySnapshot querySnapshot = await db.collection("Bitacora").where("placa", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacora.add(
        {
          "fecha":data['fecha'],
          "evento":data['evento'],
          "recursos":data['recursos'],
          "verifico":data['verifico'],
          "fechaverificacion":data['fechaverificacion']
        });
  }
  return bitacora;
}

Future<List<Map<String, dynamic>>> obtenerBitacoraFecha(String d) async {
  List<Map<String, dynamic>> bitacora = [];
  QuerySnapshot querySnapshot = await db.collection("Bitacora").where("fecha", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacora.add(
        {
          "placa":data['placa'],
          "evento":data['evento'],
          "recursos":data['recursos'],
          "verifico":data['verifico'],
          "fechaverificacion":data['fechaverificacion']
        });
  }
  return bitacora;
}

Future<List<Map<String, dynamic>>> obtenerPlacasFechaVacia() async {
  List<Map<String, dynamic>> vehiculos = [];
  QuerySnapshot querySnapshot = await db.collection("Bitacora").where("fechaverificacion", isEqualTo: "").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    vehiculos.add(
        {
          "placa":data['placa']
        });
  }
  return vehiculos;
}

Future<List<Map<String, dynamic>>> obtenerVehiculoEnUso(List d) async {
  List<Map<String, dynamic>> vehiculos = [];
  for(int i = 0; i< d.length; i++){
    QuerySnapshot querySnapshot = await db.collection("Vehiculo").where("placa", isEqualTo: d[i]).get();
    for (var docSnapshot in querySnapshot.docs) {
      final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      vehiculos.add(
          {
            'placa': data['placa'],
            'tipo': data['tipo'],
            'combustible': data['combustible'],
            'tanque': data['tanque'],
            'depto': data['depto'],
            'numeroserie': data['numeroserie'],
            'trabajador': data['trabajador'],
            'resguardadopor': data['resguardadopor']
          });
    }
  }
  return vehiculos;
}