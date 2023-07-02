// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/widgets/other/delete_pop_up.dart';

import '../../base/data_grid_model.dart';
import '../../constant/enum/enums.dart';

class DataGrid extends StatelessWidget {
  final List<DataGridModel> dataSourceList;
  final List<String> titles;
  final List<String> columnNames;
  final Function(dynamic)? onRowTap;
  final void Function(dynamic)? deleteFunction;

  const DataGrid({
    Key? key,
    required this.dataSourceList,
    required this.titles,
    required this.columnNames,
    this.onRowTap,
    this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var source = DataGridSourceAdapter(
        dataSourceList.map<DataGridRow>((e) {
          return e.toDataGridRow();
        }).toList(),
        deleteFunction);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(),
        child: SfDataGrid(
            allowSorting: true,
            allowMultiColumnSorting: true,
            allowFiltering: true,
            sortingGestureType: SortingGestureType.tap,
            onCellTap: (details) {
              if (details.rowColumnIndex.rowIndex != 0) {
                int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                var row = source.effectiveRows.elementAt(selectedRowIndex);
                onRowTap!(row.getCells().first.value);
              }
            },
            columnWidthMode: ColumnWidthMode.fill,
            source: source,
            columns: [
              ...titles.asMap().entries.map((entry) => GridColumn(
                  columnName: columnNames[entry.key],
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          entry.value,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.colorScheme.primary),
                        )),
                  ))),
              if (deleteFunction != null)
                GridColumn(
                    allowSorting: false,
                    allowFiltering: false,
                    columnName: "",
                    label: const Text(""))
            ]),
      ),
    );
  }
}

class DataGridSourceAdapter extends DataGridSource {
  final List<DataGridRow> _source;
  final void Function(dynamic)? deleteFunction;
  DataGridSourceAdapter(
    this._source,
    this.deleteFunction,
  );
  @override
  List<DataGridRow> get rows => _source;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      ...row.getCells().map<Widget>((e) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: e.value is TimeOffStatus
                ? getIcon(e.value)
                : Text(e.value is DateTime
                    ? DateFormat("dd/MM/yyyy").format(e.value)
                    : e.value.toString()),
          ),
        );
      }),
      if (deleteFunction != null)
        DeletePopUp(deleteFunction: () {
          deleteFunction!(row.getCells().first.value);
        })
    ]);
  }

  Icon getIcon(dynamic status) {
    switch (status) {
      case TimeOffStatus.DENIED:
        return const Icon(Icons.close, color: Colors.red);
      case TimeOffStatus.PENDING:
        return const Icon(
          Icons.pending,
          color: Colors.grey,
        );

      default:
        return const Icon(Icons.check, color: Colors.green);
    }
  }
}
