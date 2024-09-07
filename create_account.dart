import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'my_login_page.dart';

class create_account extends StatefulWidget {
  const create_account({super.key, required String title});
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<create_account> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

  final firebase=FirebaseFirestore.instance;
  
  registroUsuario() async{
    try {
      await firebase.collection('Users').doc().set(
        {
          "Nombre": nombre.text,
          "Correo": correo.text,
          "Password": password.text,
        },
      );
    } catch (e) {
      print("Error..."+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('CreateAccount'),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60,),
              txtRegistro(),
              SizedBox(height: 60,),
              txtNombre(),
              cuadroNombre(nombre), 
              SizedBox(height: 30,),
              txtCorreo(),
              cuadroCorreo(correo),
              SizedBox(height: 30,),
              txtPassword(),
              cuadroPassword(password),
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  print('Enviando...');
                  registroUsuario();
                },
                child: Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => my_login_page(title: 'my_login_page')),
                  );
                },
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              SizedBox(height: 10,),
              Image.network(
                "https://media.datacenterdynamics.com/media/images/IA_salud.original.jpg",
                height: 150.0,
                width: 350.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container txtRegistro() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Registro",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  Container txtNombre() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Nombre",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

Container cuadroNombre(TextEditingController nombre) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30),
    margin: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      controller: nombre, // Asignamos el controller a TextFormField
      style: const TextStyle(fontSize: 20.0),
      decoration: const InputDecoration(border: InputBorder.none),
    ),
  );
}

Container cuadroCorreo(TextEditingController correoController) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30),
    margin: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      controller: correoController,
      style: const TextStyle(fontSize: 20.0),
      decoration: const InputDecoration(border: InputBorder.none),
    ),
  );
}

Container cuadroPassword(TextEditingController passwordController) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30),
    margin: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      controller: passwordController,
      style: const TextStyle(fontSize: 20.0),
      decoration: const InputDecoration(border: InputBorder.none),
    ),
  );
}


  Container txtCorreo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Correo",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Container txtPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Contraseña",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
