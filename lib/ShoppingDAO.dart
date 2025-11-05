import 'package:floor/floor.dart';
import 'ShoppingItem.dart';

@dao
abstract class ShoppingDAO {
  @Query('SELECT * FROM ShoppingItem')
  Future<List<ShoppingItem>> getAllItems();

  @insert
  Future<int> insertItem(ShoppingItem item);

  @delete
  Future<void> deleteItem(ShoppingItem item);
}
