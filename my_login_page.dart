import 'create_account.dart';
import 'package:flutter/material.dart';
import 'main_menu.dart';

class my_login_page extends StatelessWidget {
  const my_login_page({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MyLoginPage'),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250.0,
                width: 450.0,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuRIMU86unttyGyLtR6Vkq95Q7CLJpZAWZmw&s",
                  fit: BoxFit.cover,
                ),
              ),
              txtInicio(),
              const SizedBox(height: 50,),
              txtCorreo(),
              cuadro(),
              const SizedBox(height: 20,),
              txtPassword(),
              cuadro(),
              const SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(title: '',),
                    ),
                  );
                },
                child: Text(
                  'Iniciar sesión',
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
              const SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => create_account(title: 'create_account')),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container txtInicio() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Inicio de sesión",
        style: TextStyle(fontSize: 30, color: Colors.white),
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

  Container cuadro() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        style: const TextStyle(fontSize: 20.0),
        decoration: const InputDecoration(border: InputBorder.none),
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
