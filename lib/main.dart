import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var myFontSize = 30.0;
  var fileToShow = "images/question-mark.png";
  late TextEditingController _controller; //late means promise to initialize it later
  var _login = TextEditingController();


  //you're visible
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); //doing your promise to initialize
  }

  //you are being removed
  @override
  void dispose() {
    super.dispose();
    //free memory:
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(child:
            TextField(controller: _login, decoration:
            InputDecoration(
                border: OutlineInputBorder(),
                hintText:"Login",
                labelText: "Login"

            ) ),
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0)
            ),

            Padding(child:
            TextField(controller: _controller, decoration:
            InputDecoration(
                border: OutlineInputBorder(),
                hintText:"Password",
                labelText: "Password"

            ),
                obscureText: true
            ),
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0)
            ),

            ElevatedButton(onPressed: () { //paste the text written
              setState((){

                var txt = _controller.value.text;
                setState(() {
                  if(txt == "QWERTY123"){
                    fileToShow = "images/idea.png";
                  }
                  else {
                    fileToShow = "images/stop.png";
                  }
                });

              });

            } //<-- Lambda, or anonymous function
                , child: Text("Login")),

            Semantics(child: Image.asset(fileToShow, height:100, width:100))



          ],
        ),
      ),
    );
  }

}
