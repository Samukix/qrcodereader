import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String qrData;

  const ResultPage({super.key, required this.qrData});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic>? vehicleData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicle();
  }

  Future<void> fetchVehicle() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      vehicleData = {
        'plate': widget.qrData,
        'name': 'Carro Exemplo',
        'color': 'Vermelho',
        'yearModel': '2020'
      };
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Veículo'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Placa: ${vehicleData!['plate']}", style: const TextStyle(fontSize: 18)),
              Text("Modelo: ${vehicleData!['name']}", style: const TextStyle(fontSize: 18)),
              Text("Cor: ${vehicleData!['color']}", style: const TextStyle(fontSize: 18)),
              Text("Ano: ${vehicleData!['yearModel']}", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("Iniciar pressionado!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Iniciar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






/*import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String qrData;

  const ResultPage({super.key, required this.qrData});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic>? vehicleData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicle();
  }

  Future<void> fetchVehicle() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      vehicleData = {
        'plate': widget.qrData,
        'name': 'Carro Exemplo',
        'color': 'Vermelho',
        'yearModel': '2020'
      };
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Veículo'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Placa: ${vehicleData!['plate']}"),
              Text("Modelo: ${vehicleData!['name']}"),
              Text("Cor: ${vehicleData!['color']}"),
              Text("Ano: ${vehicleData!['yearModel']}"),
            ],
          ),
        ),
      ),
    );
  }
}
*/



/*import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ResultPage extends StatefulWidget {
  final String qrData;

  const ResultPage({super.key, required this.qrData});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic>? vehicleData;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchVehicle();
  }

  Future<void> fetchVehicle() async {
    setState(() {
      loading = true;
      error = null;
    });

    final dio = Dio();

    try {
      // Substitua pela URL real da sua API
      final response = await dio.post(
        'https://sua-api.com/vehicles',
        data: {
          'vehicle_id': widget.qrData,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          vehicleData = response.data;
          loading = false;
        });
      } else {
        setState(() {
          error = 'Erro na requisição: ${response.statusCode}';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Erro ao conectar: $e';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Informações do Veículo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: fetchVehicle,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Placa: ${vehicleData!['plate']}"),
                        Text("Modelo: ${vehicleData!['name']}"),
                        Text("Cor: ${vehicleData!['color']}"),
                        Text("Ano: ${vehicleData!['yearModel']}"),
                      ],
                    ),
                  ),
      ),
    );
  }
}
*/
