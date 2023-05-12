import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Paginas
import 'package:dam_u4_proyecto1_19400618/paginas/actualizarB.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/actualizarV.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/agregarB.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/agregarV.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/bitacora.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/navegacion.dart';
import 'package:dam_u4_proyecto1_19400618/paginas/vehiculo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto 1 - DAM',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Navegacion(),
        '/vehiculo': (context) => const Vehiculo(),
        '/agregarV':(context) => const AgregarV(),
        '/actualizarV':(context) => const ActualizarV(),
        '/bitacora': (context) => const Bitacora(),
        '/agregarB':(context) => const AgregarB(),
        '/actualizarB':(context) => const ActualizarB(),
      }
    );
  }
}


