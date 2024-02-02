import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sphere',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Sphere Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Scene _scene;
  Object? _spheres;
  double xChange = 0.0;
  double yChange = 0.0;
  double zChange = 50.0;
  int n = 1;
  final _formKey = GlobalKey<FormState>();

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.x = xChange;
    scene.camera.position.y = yChange;
    scene.camera.position.z = zChange;

    // Add spheres to the scene
    _spheres = Object();

    for (var i = 0; i < n; i++) {
      final y = 5 - Random().nextDouble() * 10;
      final r = sqrt(1 - pow(y, 2));
      final x = 5 - Random().nextDouble() * 10;
      final z = 5 - Random().nextDouble() * 10;
      final rad = Random().nextDouble() * 5;

      Object newSphere = Object(
        position: Vector3(x, y,z),
        scale: Vector3(rad, rad, rad),
        rotation: Vector3(0, 0, 0),
        lighting: true,
        fileName: 'obj_file/1.obj',
      );

      _spheres!.add(newSphere);
    }

    scene.world.add(_spheres!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Cube(onSceneCreated: _onSceneCreated),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('N:', style: TextStyle(fontSize: 20.0)),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter a value';
                          n = int.parse(value);
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _onSceneCreated(_scene);
                            });
                          }
                        },
                        child: Text('Generate Spheres'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
