import 'package:flutter/material.dart';

mixin ProductSheetMixin {
  Future<T?> showCustomSheet<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return _CustomMainSheet(child: child);
      },
    );
  }
}

class _CustomMainSheet extends StatelessWidget {
  _CustomMainSheet({
    Key? key,
    required this.child,
  }) : super(key: key);
  bool netControl = false;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _BaseSheetHeader(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _BaseSheetHeader extends StatelessWidget {
  const _BaseSheetHeader();
  final _gripHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _gripHeight,
      child: Stack(
        children: [
          Divider(
            color: Colors.black26,
            thickness: 3,
            indent: MediaQuery.of(context).size.width * 0.42,
            endIndent: MediaQuery.of(context).size.width * 0.42,
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              width: 40,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop<int>(5);
                  },
                  child: const Icon(Icons.close)),
            ),
          ),
        ],
      ),
    );
  }
}