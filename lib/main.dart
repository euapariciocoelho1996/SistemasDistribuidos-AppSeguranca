import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Motion Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isDetectingMotion = false;
  String _statusMessage = 'Pressione o botão abaixo para proteger seu celular!';
  
  List<CameraDescription>? cameras;
  late CameraDescription frontCamera;

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    frontCamera = cameras!.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    await _controller!.initialize();

    setState(() {
      _isCameraInitialized = true;
    });
  }

  // Função para enviar alerta e imagem para o servidor
  Future<void> _sendAlertWithImage(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.15:5000/alert'), // Endereço do servidor Flask
      );

      request.fields['timestamp'] = DateTime.now().toIso8601String();
      request.fields['motionDetected'] = 'true';
      request.files.add(await http.MultipartFile.fromPath(
        'image', // Nome do campo no servidor
        imageFile.path,
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Movimento Detectado! Sorriaa!!';
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to send image. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error sending image: $e';
      });
    }
  }

  // Função para capturar e enviar a imagem quando houver movimento
  Future<void> _startMotionDetection() async {
    setState(() {
      _isDetectingMotion = true;
      _statusMessage = 'Detectando movimento...';
    });

    Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!_isDetectingMotion) {
        timer.cancel();
        return;
      }

      try {
        final image = await _controller!.takePicture();
        final imageFile = File(image.path);

        if (await imageFile.exists()) {
          setState(() {
            _statusMessage = 'Movimento detectado, enviando imagem para servidor...';
          });
          await _sendAlertWithImage(imageFile);
          timer.cancel(); // Parar a detecção após enviar a imagem
        }
      } catch (e) {
        setState(() {
          _statusMessage = 'Error capturing image: $e';
        });
      }
    });
  }

  void _stopMotionDetection() {
    setState(() {
      _isDetectingMotion = false;
      _statusMessage = 'Detecção Parada';
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      title: const Text(
        'SD',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: Image.asset(
            'assets/All/icon.webp',
            width: 40,
            height: 40,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // Altura da linha
        child: Center(
          child: Container(
            width: 100.0, // Largura da linha
            color: Colors.white,
            height: 1.0, // Altura da linha
          ),
        ),
      ),
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhando à esquerda
                children: [
                  SizedBox(height: 10),
                  Text(
                    'SISTEMAS DISTRIBUIDOS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      CircleAvatar(radius: 6, backgroundColor: const Color.fromARGB(255, 114, 244, 54)),
                      SizedBox(width: 15),
                      CircleAvatar(radius: 6, backgroundColor: const Color.fromARGB(255, 199, 165, 79)),
                      SizedBox(width: 15),
                      CircleAvatar(radius: 6, backgroundColor: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'Ative a opção abaixo para manter seu celular seguro contra invasores!🔒📱.',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Define o formato como círculo
                    ),
                    clipBehavior: Clip.antiAlias, // Garante que a imagem seja cortada corretamente
                    child: Image.asset(
                      'assets/All/foto1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isDetectingMotion ? _stopMotionDetection : _startMotionDetection,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDetectingMotion ? Colors.red : Colors.green, // Cores dinâmicas
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Mais espaçamento
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Cantos levemente arredondados
                ),
                elevation: 4, // Efeito de sombra para um visual moderno
              ),
              child: Text(
                _isDetectingMotion ? 'Parar Detecção' : 'Começar Captura',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
