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
          cellBuilder: (int row, int col) =>
              Center(child: Text('Cell $row/$col')),
          legendBuilder: () => Center(child: Text('Legend')),
          rowHeaderBuilder: (index) => Center(child: Text('Row $index')),
          colHeaderBuilder: (index) => Center(child: Text('Col $index')),
          rowsCount: 100,
          colCount: 15,
        ),
      ),
    );
  }
}
