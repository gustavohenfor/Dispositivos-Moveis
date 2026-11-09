
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/item.dart';

class ItemService {
  final supabase = Supabase.instance.client;

  // Buscar os itens do usuário conectado
  Future<List<Item>> getItems() async {
    final response = await supabase
        .from('items')
        .select('id, name, user_id, created_at')
        .order('created_at', ascending: false);

    return response.map((item) => Item.fromMap(item)).toList();
  }

  // Adicionar um novo item
  Future<void> addItem(String name) async {
    final user = supabase.auth.currentUser!;

    await supabase.from('items').insert({
      'name': name,
      'user_id': user.id,
    });
  }

  // Editar um item
  Future<void> updateItem(String id, String newName) async {
    await supabase
        .from('items')
        .update({'name': newName})
        .eq('id', id);
  }

  // Excluir um item
  Future<void> deleteItem(String id) async {
    await supabase
        .from('items')
        .delete()
        .eq('id', id);
  }
}
