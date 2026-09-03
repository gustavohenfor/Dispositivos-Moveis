import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const GeradorQrApp());
}

class GeradorQrApp extends StatelessWidget {
  const GeradorQrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerador de QR Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const GeradorQrPage(),
    );
  }
}

class GeradorQrPage extends StatefulWidget {
  const GeradorQrPage({super.key});

  @override
  State<GeradorQrPage> createState() => _GeradorQrPageState();
}

class _GeradorQrPageState extends State<GeradorQrPage> {
  final TextEditingController controlador = TextEditingController();

  String textoQrCode = '';

  void gerarQrCode() {
    setState(() {
      textoQrCode = controlador.text.trim();
    });
  }

  void limparQrCode() {
    setState(() {
      controlador.clear();
      textoQrCode = '';
    });
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gerador de QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.qr_code_2,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Crie seu QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Digite um texto, link ou qualquer informação para gerar um QR Code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controlador,
                decoration: const InputDecoration(
                  labelText: 'Texto ou link',
                  hintText: 'Digite aqui...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: gerarQrCode,
                icon: const Icon(Icons.qr_code),
                label: const Text(
                  'Gerar QR Code',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (textoQrCode.isNotEmpty) ...[
                const Text(
                  'QR Code gerado:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: textoQrCode,
                      version: QrVersions.auto,
                      size: 240,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  textoQrCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: limparQrCode,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Limpar'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}