import 'package:flutter/material.dart';
import 'package:spreadsheet_table/spreadsheet_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SpreadsheetTable(
          cellBuilder: (_, int row, int col) =>
              Center(child: Text('Cell $row/$col')),
          legendBuilder: (_) => Center(child: Text('Legend')),
          rowHeaderBuilder: (_, index) => Center(child: Text('Row $index')),
          colHeaderBuilder: (_, index) => Center(child: Text('Col $index')),
          rowsCount: 100,
          colCount: 15,
        ),
      ),
    );
  }
}
