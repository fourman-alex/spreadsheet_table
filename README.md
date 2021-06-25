# spreadsheet_table

Provides a way to create a spreadsheet-like table that is scrollable in both axis and that has headers that are always visible, no matter the scroll offset. This is similar to the way a spreadsheet app can freeze the first row or column.  
This package is simillar to [table_sticky_headers](https://pub.dev/packages/table_sticky_headers) but is better suited for longer lists in the X axis (tables with lots of rows) as the rows are generated dynamically.

# Usage
See the [example](https://github.com/fourman-alex/spreadsheet_table/tree/master/example) project for a demo app.
```dart
import 'package:spreadsheet_table/spreadsheet_table.dart';

SpreadsheetTable(
  cellBuilder: (_, int row, int col) =>
      Center(child: Text('Cell $row/$col')),
  legendBuilder: (_) => Center(child: Text('Legend')),
  rowHeaderBuilder: (_, index) => Center(child: Text('Row $index')),
  colHeaderBuilder: (_, index) => Center(child: Text('Col $index')),
  rowHeaderWidth: 80, //optional
  colsHeaderHeight: 30, //optional
  cellHeight: 30, //optional
  cellWidth: 80, //optional
  rowsCount: 100,
  colCount: 15,
)
```

## Flutter Web
When building for web prefer `canvaskit` as the performance of the table will be better.  
Use `flutter build web --web-renderer canvaskit --release` when releasing to production 
