
import 'package:flutter/material.dart';

class MultifirmDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final void Function(T) onItemSelected;

  const MultifirmDialog({
    super.key,
    required this.title,
    required this.items,
    required this.itemLabelBuilder,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300), // make scrollable if long list
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ListTile.divideTiles(
                context: context,
                tiles: items.map((item) {
                  return ListTile(
                    title: Text(itemLabelBuilder(item)),
                    onTap: () {
                      Navigator.pop(context);
                      onItemSelected(item);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showMultiFirmDialog<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required String Function(T) itemLabelBuilder,
  required void Function(T) onItemSelected,
}) {
  showDialog(
    context: context,
    builder: (_) => MultifirmDialog<T>(
      title: title,
      items: items,
      itemLabelBuilder: itemLabelBuilder,
      onItemSelected: onItemSelected,
    ),
  );
}
