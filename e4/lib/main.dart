import 'package:flutter/material.dart';

class Palavra {
  final String portugues;
  final String ingles;
  final String espanhol;

  const Palavra({
    required this.portugues,
    required this.ingles,
    required this.espanhol,
  });
}

const listaPalavras = [
  Palavra(
    portugues: 'Casa',
    ingles: 'House',
    espanhol: 'Casa',
  ),
  Palavra(
    portugues: 'Livro',
    ingles: 'Book',
    espanhol: 'Libro',
  ),
  Palavra(
    portugues: 'Cachorro',
    ingles: 'Dog',
    espanhol: 'Perro',
  ),
  Palavra(
    portugues: 'Gato',
    ingles: 'Cat',
    espanhol: 'Gato',
  ),
  Palavra(
    portugues: 'Água',
    ingles: 'Water',
    espanhol: 'Agua',
  ),
  Palavra(
    portugues: 'Comida',
    ingles: 'Food',
    espanhol: 'Comida',
  ),
  Palavra(
    portugues: 'Escola',
    ingles: 'School',
    espanhol: 'Escuela',
  ),
  Palavra(
    portugues: 'Carro',
    ingles: 'Car',
    espanhol: 'Coche',
  ),
  Palavra(
    portugues: 'Amigo',
    ingles: 'Friend',
    espanhol: 'Amigo',
  ),
  Palavra(
    portugues: 'Sol',
    ingles: 'Sun',
    espanhol: 'Sol',
  ),
];

void main() {
  runApp(const TradutorApp());
}

class TradutorApp extends StatelessWidget {
  const TradutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tradutor de Palavras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TradutorPage(),
    );
  }
}

class TradutorPage extends StatefulWidget {
  const TradutorPage({super.key});

  @override
  State<TradutorPage> createState() => _TradutorPageState();
}

class _TradutorPageState extends State<TradutorPage> {
  int indiceAtual = 0;
  bool mostrarTraducao = false;

  void proximaPalavra() {
    setState(() {
      if (indiceAtual == listaPalavras.length - 1) {
        indiceAtual = 0;
      } else {
        indiceAtual++;
      }

      mostrarTraducao = false;
    });
  }

  void palavraAnterior() {
    setState(() {
      if (indiceAtual == 0) {
        indiceAtual = listaPalavras.length - 1;
      } else {
        indiceAtual--;
      }

      mostrarTraducao = false;
    });
  }

  void alternarTraducao() {
    setState(() {
      mostrarTraducao = !mostrarTraducao;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palavra = listaPalavras[indiceAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tradutor de Palavras'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Português',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                palavra.portugues,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              if (mostrarTraducao) ...[
                Text(
                  palavra.ingles,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  palavra.espanhol,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ],

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: palavraAnterior,
                    child: const Text('Anterior'),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: alternarTraducao,
                    child: Text(
                      mostrarTraducao
                          ? 'Esconder tradução'
                          : 'Mostrar tradução',
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: proximaPalavra,
                    child: const Text('Próxima'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                '${indiceAtual + 1} / ${listaPalavras.length}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}