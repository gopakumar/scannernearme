import 'package:flutter/material.dart';
import 'package:homepage/routes.dart';

class ScannerInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Scanner Info'),
      ),
      body: SafeArea(
          child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.navigation),
              title: Text(
                  'Address: \nABC Iphone Repair 11 Xyz Street,\n San Francisco CA 94016'),
              //trailing: Icon(Icons.more_vert),
              isThreeLine: false,
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.adjust_sharp),
              title: Text('Locate the Scanner Left to the Entrance'),
              //trailing: Icon(Icons.more_vert),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.tune),
              title: Text(
                  'Features:\n Type: Color\n Documents: A4, A5, B5, LTR, LGL, Business Card'),
              //trailing: Icon(Icons.more_vert),
              isThreeLine: false,
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.wallet),
              title: Text(
                  'Cost: \$1.00, Unlimited Scans for 2 Hours or End of busniness'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.access_time_outlined),
              title: Text('Hours: M-F 9.00 PM to 6.00 PM'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.directions_sharp),
              title: Text(
                  'Goto the above Address, Locate the Scanner and click Continue'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                  child: Text("Continue")),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
        ],
      )),
    );
  }
}


//Navigator.of(context).pushNamed('/home');