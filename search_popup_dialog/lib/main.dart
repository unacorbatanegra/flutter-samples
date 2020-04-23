import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PopupSearchMenu(),
    );
  }
}

class Modelo {
  String description;
  double value;
  int id;

  Modelo({this.description, this.value, this.id});
}

class PopupSearchMenu extends StatefulWidget {
  List<Modelo> filteredList;

  @override
  _PopupSearchMenuState createState() => _PopupSearchMenuState();
}

class _PopupSearchMenuState extends State<PopupSearchMenu> {

  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Popup Search Menu Demo"),
        ),
        body: Container(
          child: Center(
            child:
                Text(
                  selectedItem != null ? selectedItem : "Selected Item",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey  
                  ),
                ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return MyDialog(
                    onValuePicked: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                    },
                  );
                });
          },
          child: Icon(Icons.alarm),
        ),
        resizeToAvoidBottomInset: false);
  }
}

class MyDialog extends StatefulWidget {
  final ValueChanged<String> onValuePicked;
  List<Modelo> list = [
    Modelo(description: "Banana", value: 10, id: 1),
    Modelo(description: "Manzana", value: 8, id: 1),
    Modelo(description: "Pera", value: 8, id: 1),
    Modelo(description: "Melon", value: 8, id: 1),
    Modelo(description: "Sandía", value: 9, id: 1),
    Modelo(description: "Melocoton", value: 10, id: 1),
    Modelo(description: "Cereza", value: 25, id: 1),
    Modelo(description: "Frutilla", value: 67, id: 1),
    Modelo(description: "Limon", value: 89, id: 1),
    Modelo(description: "Naranja", value: 16, id: 1),
    Modelo(description: "Mandarina", value: 17, id: 1),
    Modelo(description: "Lima", value: 23, id: 1),
    Modelo(description: "Mango", value: 90, id: 1),
  ];

  MyDialog({Key key, this.onValuePicked}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<Modelo> filteredList;
  @override
  void initState() {
    filteredList = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Search Item",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(hintText: 'Search'),
                onChanged: (value) {
                  setState(() {
                    filteredList = widget.list
                        .where((element) => element.description
                            .toLowerCase()
                            .startsWith(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: _listView(context, widget.onValuePicked),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listView(BuildContext context, ValueChanged<String> onValuePicked) {
    return filteredList.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: filteredList
                .map((item) => ListTile(
                      title: Text(item.description),
                      subtitle: Text("Value ${item.value}"),
                      leading: Icon(Icons.fastfood),
                      onTap: () {
                        onValuePicked(item.description);
                        filteredList = widget.list;
                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          )
        : Center(
            child: Text("Nothing found"),
          );
  }
}
