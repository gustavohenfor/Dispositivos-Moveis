import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';
import 'detalhes_screen.dart';
import 'transformacoes_screen.dart';

class CatalogoScreen extends StatelessWidget {
  final ValueNotifier<List<AppLifecycleState>> lifecycleHistory;

  const CatalogoScreen({
    super.key,
    required this.lifecycleHistory,
  });

  @override
  Widget build(BuildContext context) {
    final List<Produto> produtos = [
      Produto(
        nome: 'Minecraft',
        descricao:
            'Jogo de construção e exploração em um mundo formado por blocos.',
        preco: 89.90,
        quantidade: 5,
      ),
      Produto(
        nome: 'EA Sports FC 26',
        descricao:
            'Jogo de futebol com diversos times, competições e modos de jogo.',
        preco: 299.90,
        quantidade: 3,
      ),
      Produto(
        nome: 'GTA V',
        descricao:
            'Jogo de ação e aventura em mundo aberto com diferentes personagens e missões.',
        preco: 99.90,
        quantidade: 8,
      ),
    ];

    final List<Widget> cards = produtos
        .map(
          (produto) => ProdutoCard(
            produto: produto,
            onDetalhes: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalhesScreen(
                    produto: produto,
                  ),
                ),
              );
            },
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Jogos'),
        actions: [
          IconButton(
            tooltip: 'Transformações',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransformacoesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.transform),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<AppLifecycleState>>(
          valueListenable: lifecycleHistory,
          builder: (context, history, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produtos disponíveis',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...cards,
                  const SizedBox(height: 20),
                  const Text(
                    'Histórico do ciclo de vida',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: history.isEmpty
                        ? const Text(
                            'Nenhum estado recebido ainda. '
                            'Realize os testes solicitados.',
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: history.asMap().entries.map(
                              (entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    '${entry.key + 1}. ${entry.value.name}',
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
