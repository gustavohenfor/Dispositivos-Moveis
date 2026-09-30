import 'package:flutter/material.dart';

class TransformacoesScreen extends StatefulWidget {
  const TransformacoesScreen({super.key});

  @override
  State<TransformacoesScreen> createState() => _TransformacoesScreenState();
}

class _TransformacoesScreenState extends State<TransformacoesScreen> {
  final List<int> numeros = [1, 2, 3, 4, 5];

  final List<String> palavras = [
    'Flutter',
    'é',
    'incrível',
  ];

  final List<String> nomes = [
    'Gustavo',
    'João',
    'Maria',
  ];

  late final List<String> numerosComoString;
  late final List<int> numerosMultiplicados;

  String mensagem = '';

  @override
  void initState() {
    super.initState();

    numerosComoString = numeros
        .map((numero) => numero.toString())
        .toList();

    numerosMultiplicados = numeros
        .map((numero) => numero * 2)
        .toList();
  }

  void mostrarNome(String nome) {
    setState(() {
      mensagem = 'Você selecionou: $nome';
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> palavrasWidgets = palavras
        .map(
          (palavra) => Text(
            palavra,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        )
        .toList();

    final List<Widget> botoesNomes = nomes
        .map(
          (nome) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  mostrarNome(nome);
                },
                child: Text(nome),
              ),
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformações'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Números',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text('Lista original: $numeros'),
              const SizedBox(height: 8),
              Text('Lista de strings: $numerosComoString'),
              const SizedBox(height: 8),
              Text('Valores multiplicados por 2: $numerosMultiplicados'),
              const SizedBox(height: 28),
              const Text(
                'Palavras em widgets',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...palavrasWidgets,
              const SizedBox(height: 28),
              const Text(
                'Nomes em botões',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...botoesNomes,
              if (mensagem.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    mensagem,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}