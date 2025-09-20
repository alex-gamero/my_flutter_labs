import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
            Text("\n", style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold)),

            Text("Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories", style: TextStyle(fontSize: 15.0)),
            Text("\n", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),

            Text("BY MEAT", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            Text("\n", style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold)),

            Row(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget> [

                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage('images/beef.jpg'),
                        radius:80
                    ),
                    Text("BEEF", style: TextStyle(fontSize: 25.0, color: Colors.white))
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage('images/chicken.jpg'),
                        radius:80
                    ),
                    Text("CHICKEN", style: TextStyle(fontSize: 25.0, color: Colors.white ))
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage('images/pork.jpg'),
                        radius:80
                    ),
                    Text("PORK", style: TextStyle(fontSize: 25.0, color: Colors.white ))
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage('images/seafood.jpg'),
                        radius:80
                    ),
                    Text("SEAFOOD", style: TextStyle(fontSize: 25.0, color: Colors.white ))
                  ],
                )

              ]

            ),

            Text("\n", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
            Text("BY COURSE", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            Text("\n", style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold)),

            Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget> [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/main.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Main Dishes", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/salad.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Salad Recipes", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/side.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Side Dishes", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/pot.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Crockpot", style: TextStyle(fontSize: 20.0))
                    ],
                  )

                ]

            ),

            Text("\n", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
            Text("BY DESSERT", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            Text("\n", style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold)),

            Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget> [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/ice.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Ice Cream", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/brownies.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Brownies", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/pie.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Pies", style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage('images/cookies.jpg'),
                          radius:80
                      ),
                      Text("\n", style: TextStyle(fontSize: 2.0, fontWeight: FontWeight.bold)),
                      Text("Cookies", style: TextStyle(fontSize: 20.0))
                    ],
                  )

                ]

            )

          ],
        ),
      ),
    );
  }

}
