import 'package:flutter/material.dart';
import 'package:homepage/routes.dart';

class ScannerHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('HELP'),
        ),
        body: SafeArea(
            child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Card(child: ListTile(title: Text('1. Locate the Scanner'))),
              Card(child: ListTile(title: Text('2. Turn On the Scanner'))),
              Card(
                  child: ListTile(
                      title: Text('3. Connect to the Scanner from the APP'))),
              Card(
                  child: ListTile(
                      title: Text(
                          '4. Click \"Join\" to connect to scanner wifi'))),
              Card(
                  child: ListTile(
                      title: Text(
                          '5.. Wait for the wifi light in the Scanner \nbecome Solid Blue'))),
              Card(
                  child: ListTile(
                      title: Text(
                          '6. Place the Document if the Scanner, Scanner will lock the document'))),
              Card(
                  child: ListTile(
                      title: Text('7. Click the Scan button in the APP'))),
              Card(
                  child: ListTile(
                      title: Text(
                          '8. Repet steps 4-5 for to Scan remaining documents'))),
              Card(
                  child: ListTile(
                      title: Text(
                          '9. Pay \$1 Then click Download button to Download the Docs'))),
              Card(
                child: ListTile(
                  leading: Icon(Icons.map_outlined),
                  title: Text(
                      'To Share your Scanner through APP, \n send a request to \'sharemydocscanner@gmail.com\' '),
                ),
              ),
            ])));
  }
}
