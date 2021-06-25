import 'package:flutter/widgets.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

/// A Table that is scrollable on X and Y axis and which headers
/// (row and column) are always visible (frozen), no matter the scroll offset.
class SpreadsheetTable extends StatefulWidget {
  /// Create a [SpreadsheetTable]
  const SpreadsheetTable({
    Key? key,
    this.cellWidth = 80,
    this.cellHeight = 30,
    this.rowHeaderWidth = 80,
    this.colsHeaderHeight = 30,
    required this.colCount,
    required this.rowsCount,
    required this.colHeaderBuilder,
    required this.rowHeaderBuilder,
    required this.cellBuilder,
    required this.legendBuilder,
  }) : super(key: key);

  //TODO add context to the builders

  /// The width of the data cells. This will act as the column width for the
  /// data columns
  final double cellWidth;

  /// The height of the data cells. This will act as the row height for the
  /// data rows.
  final double cellHeight;

  /// Width of the row header. The width of the first column.
  /// Defaults to 80
  final double rowHeaderWidth;

  /// Height of the column header. The height of the first row.
  /// Defaults to 30
  final double colsHeaderHeight;

  /// Number of data columns the [cellBuilder] will iterate over
  final int colCount;

  /// Number of data rows the [cellBuilder] will iterate over
  final int rowsCount;

  /// Builder for the columns header. The first row.
  final Widget Function(int index) colHeaderBuilder;

  /// Builder for the rows header. The first column.
  final Widget Function(int index) rowHeaderBuilder;

  /// Builder for the data cells.
  final Widget Function(int row, int col) cellBuilder;

  /// Builder for the table legend. The top-left most cell.
  final Widget Function() legendBuilder;

  @override
  _SpreadsheetTableState createState() => _SpreadsheetTableState();
}

class _SpreadsheetTableState extends State<SpreadsheetTable> {
  late ScrollController _rowHeaderController;
  late ScrollController _colHeaderController;
  late ScrollController _rowsControllerY;
  late ScrollController _rowsControllerX;
  final _controllers = LinkedScrollControllerGroup();
  final _horizontalControllers = LinkedScrollControllerGroup();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: widget.colsHeaderHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.rowHeaderWidth,
                child: widget.legendBuilder(),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _colHeaderController,
                  scrollDirection: Axis.horizontal,
                  itemExtent: widget.cellWidth,
                  itemCount: widget.colCount,
                  itemBuilder: (context, index) => SizedBox(
                    width: widget.cellWidth,
                    child: widget.colHeaderBuilder(index),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: widget.rowHeaderWidth,
                child: ListView.builder(
                  controller: _rowHeaderController,
                  itemCount: widget.rowsCount,
                  itemExtent: widget.cellHeight,
                  itemBuilder: (context, index) => SizedBox(
                    height: widget.cellHeight,
                    child: widget.rowHeaderBuilder(index),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _rowsControllerX,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: widget.colCount * widget.cellWidth,
                    child: ListView.builder(
                      itemExtent: widget.cellHeight,
                      controller: _rowsControllerY,
                      itemCount: widget.rowsCount,
                      itemBuilder: (context, index) => Row(
                        children: [
                          for (int col = 0; col < widget.colCount; col++)
                            SizedBox(
                              width: widget.cellWidth,
                              height: widget.cellHeight,
                              child: widget.cellBuilder(index, col),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _rowHeaderController = _controllers.addAndGet();
    _rowsControllerY = _controllers.addAndGet();
    _colHeaderController = _horizontalControllers.addAndGet();
    _rowsControllerX = _horizontalControllers.addAndGet();
  }
}
