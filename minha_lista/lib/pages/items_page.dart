
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/item_service.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final ItemService itemService = ItemService();
  final TextEditingController nameController = TextEditingController();

  List<Item> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  // Carregar tarefas
  Future<void> loadItems() async {
    try {
      final result = await itemService.getItems();

      if (!mounted) return;

      setState(() {
        items = result;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar tarefas: $error')),
      );
    }
  }

  // Adicionar tarefa
  Future<void> addItem() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return;

    try {
      await itemService.addItem(name);

      nameController.clear();
      await loadItems();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar tarefa: $error')),
      );
    }
  }

  // Editar tarefa
  Future<void> editItem(Item item) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        return EditItemDialog(initialName: item.name);
      },
    );

    if (newName == null || newName.trim().isEmpty) return;

    try {
      await itemService.updateItem(item.id, newName.trim());
      await loadItems();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa atualizada!')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao editar tarefa: $error')),
      );
    }
  }

  // Excluir tarefa
  Future<void> deleteItem(Item item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir tarefa'),
          content: Text('Deseja excluir "${item.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await itemService.deleteItem(item.id);
      await loadItems();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa excluída!')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir tarefa: $error')),
      );
    }
  }

  // Sair da conta
  Future<void> logout() async {
    await itemService.supabase.auth.signOut();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nova tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: addItem,
                child: const Text('Adicionar'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : items.isEmpty
                      ? const Center(
                          child: Text('Nenhuma tarefa cadastrada.'),
                        )
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];

                            return Card(
                              child: ListTile(
                                title: Text(item.name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => editItem(item),
                                      icon: const Icon(Icons.edit),
                                      tooltip: 'Editar',
                                    ),
                                    IconButton(
                                      onPressed: () => deleteItem(item),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      tooltip: 'Excluir',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// Diálogo de edição
class EditItemDialog extends StatefulWidget {
  final String initialName;

  const EditItemDialog({
    super.key,
    required this.initialName,
  });

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar tarefa'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Nome da tarefa',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, controller.text.trim());
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
