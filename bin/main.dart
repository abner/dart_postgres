import 'package:postgres/postgres.dart';
import 'dart:io';

int dbPort = int.tryParse((Platform.environment['DART_POSTGRES_DB_PORT'] ?? '32780')) ?? 5432;

void main() async {
  var connection = PostgreSQLConnection("localhost", dbPort, "dart_postgres",
      username: "dart_postgres", password: "dart_postgres");
  final openConn = await connection.open();

  List<List<dynamic>> results = await connection.query(
      "SELECT name, age FROM users WHERE age >= @age",
      substitutionValues: {"age": 3});

  for (final row in results) {
    print(row.toString());
  }
  await connection.close();
}
