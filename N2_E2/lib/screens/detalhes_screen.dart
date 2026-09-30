import 'package:flutter/material.dart';
import '../models/produto.dart';

class DetalhesScreen extends StatelessWidget {
  final Produto produto;

  const DetalhesScreen({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do produto'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.sports_esports,
                  size: 100,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                produto.nome,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                produto.descricao,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Preço: R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantidade disponível: ${produto.quantidade}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar ao catálogo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}