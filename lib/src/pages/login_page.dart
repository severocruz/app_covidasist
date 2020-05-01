import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      )
    );
  }

  Widget _loginForm( BuildContext context ){
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            )
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.symmetric(vertical:30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            //height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0),),
                SizedBox(height:60.0),
                _crearEmail(),
                SizedBox(height:30.0),
                _crearPassword(),
                SizedBox(height:30.0),
                _crearBoton()
              ]
            ),
          ),
          Text('¿olvidó la contraseña?'),
          SizedBox(height:100.0)
          
        ],
      ),
    );
  }
  Widget _crearEmail(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email,color: Colors.deepPurple,),
          hintText: 'lmorales',
          labelText: 'Nombre de Usuario'
        ),
      ),
    );
  }
   Widget _crearPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextField(

        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline ,color: Colors.deepPurple,),
          labelText: 'Contraseña'
        ),
      ),
    );
  }
  Widget _crearBoton(){
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0,vertical:15.0),
        child: Text('Ingresar'),
        ),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0) 
          ),
          elevation: 0.0,
          color: Color.fromRGBO(0, 154, 221, 1.0) ,
          textColor: Colors.white,
          
        onPressed: (){},
    );
  }
  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    final fondoAzul =  Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(0, 154, 221, 1.0),
            Color.fromRGBO(0, 168, 227, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoAzul,
        Positioned( top: 90.0, left: 30.0, child: circulo),
        Positioned( top: -40.0, right: -30.0, child: circulo),
        Positioned( bottom: -50.0, right: -10.0, child: circulo),
        Positioned( bottom: 120.0, right: 20.0, child: circulo),
        Positioned( bottom: -50.0, left: -20.0, child: circulo),

        Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            children: <Widget>[
              Image(
                width: 120.0,
                height: 120.0,
                image: AssetImage('assets/logos/lafar.png'),
              ),
              SizedBox(width: double.infinity, height: 10.0,)
            ],
          ),
        )
      ],
    );
  }
}