import 'package:flutter/material.dart';

List colors = [Colors.orange, Colors.red, Colors.pink];

class AutoModalPopupScreen extends StatefulWidget {
  const AutoModalPopupScreen({Key? key}) : super(key: key);

  @override
  State<AutoModalPopupScreen> createState() => _AutoModalPopupScreenState();
}

class _AutoModalPopupScreenState extends State<AutoModalPopupScreen> {
  @override
  void didChangeDependencies() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    _showModalScreen(context, colors);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("Auto Modal Popup Screen"),
    );
  }

  _showModalScreen(context, List colors) async {
    if (colors.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 400));
      Navigator.of(context, rootNavigator: true)
          .push(
        DialogRoute(
          context: context,
          builder: (_) {
            return SimpleDialog(
              title: Text("タイトル"),
              children: [
                Container(
                  width: 400,
                  height: 500,
                  color: colors.first,
                ),
              ],
            );
          },
          barrierColor: Colors.black54,
          barrierDismissible: true,
          useSafeArea: true,
          // MaterialPageRoute(builder: (_) => SimpleDialog(),),
        ),
      )
          .whenComplete(
        () {
          print("_showModalScreenが終了");
          colors.removeAt(0);
          _showModalScreen(context, colors);
        },
      );
    } else {
      print("_showModalScreenは表示するものがありません");
    }
  }
}
