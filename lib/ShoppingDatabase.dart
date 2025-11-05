import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ShoppingItem.dart';
import 'ShoppingDAO.dart';

part 'ShoppingDatabase.g.dart'; // Generated File

@Database(version: 1, entities: [ShoppingItem])
abstract class ShoppingDatabase extends FloorDatabase {
  ShoppingDAO get shoppingDAO;
}
