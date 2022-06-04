import 'dart:io';

import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:wifi_connector/wifi_connector.dart';
import 'package:air_brother/air_brother.dart';
import 'package:share_plus/share_plus.dart';
import 'package:homepage/routes.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List _scannedFilesImagesList = [];
  final List<String> _scannedFilespath = [];
  bool isPaymentDone = false;
  int paymentdue = 1;

  void _scanFiles(Connector connector) async {
    List<String> outScannedPaths = [];
    ScanParameters scanParams = ScanParameters();
    //scanParams.duplex = Duplex.FlipOnShortEdge;
    scanParams.duplex = Duplex.Simplex;
    scanParams.documentSize = MediaSize.BusinessCardLandscape;
    JobState jobState =
        await connector.performScan(scanParams, outScannedPaths);
    print("JobState: $jobState");
    print("Files Scanned: $outScannedPaths");
    int total = _scannedFilesImagesList.length;
    print("total $total");
    _scannedFilespath.add(outScannedPaths[0]);
    upatehelpMessage("Scan all the docs and then click download");
    //return outScannedPaths[0];
    setState(() {
      //_scannedFilesList.add(Text(outScannedPaths.toString()));
      _scannedFilesImagesList.removeLast();
      //_scannedFilesList.add(Image.file(File(outScannedPaths[1].toString())));
      _scannedFilesImagesList
          .add(Image.file(File(outScannedPaths[0].toString())));
    });
  }

  void sharefiles() {
    if (paymentdue > 0) {
      upatehelpMessage("Pay \$1.00 to Download Files");
      print("Pay \$$paymentdue.00");
      return;
    }
    print("sharing Files");
    print(_scannedFilespath[0]);
    if (_scannedFilespath.length > 0) {
      Share.shareFiles(_scannedFilespath.toList(), text: 'Scans');
    }
  }

  void removeScannedFile(int index) {
    _scannedFilesImagesList.removeAt(index);
    _scannedFilespath.removeAt(index);
  }

  void AddaScannedFile() {
    setState(() {
      Widget scanner = FutureBuilder(
          future: AirBrother.getNetworkDevices(5000),
          builder: (context, AsyncSnapshot<List<Connector>> snapshot) {
            print("Success");
            print("Snapshot ${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Prepairing to Scan");
            }

            if (snapshot.hasData) {
              List<Connector> connectors = snapshot.data!;

              if (connectors.isEmpty) {
                return Text("No Scanners Found");
              }
              _scanFiles(connectors[0]);
              print("Connected!");
              //return Text(path.toString());
            }

            return Text("Document Scanning in Progress");
          });

      _scannedFilesImagesList.add(scanner);
    });
  }

  final String SSID = "DIRECT-b9DS-940DW_BR1294";
  final String pwd = "70b91294";

  String helpmessage = "Once you locate the Scanner, Turn it on then Connect";

  Future<void> connectScanner() async {
    // This call to setState tells the Flutter framework that someßßßßthing has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    //_counter++;
    print("connecting to scanner");
    final isSuccess =
        await WifiConnector.connectToWifi(ssid: SSID, password: pwd);
    print(isSuccess);
    upatehelpMessage("Scanner Connected, feed the Document and click Scan");
  }

  void cardEntryComplete() {
    print("card Entry Complete");
  }

  void cardsuccess(CardDetails cd) {
    print("card Success");
    InAppPayments.completeCardEntry(onCardEntryComplete: cardEntryComplete);
    upatehelpMessage("Transaction Success");
    updatepaymentdue(0);
  }

  void cardfail() {
    print("card failed");
    upatehelpMessage("Transaction Failed");
  }

  void testpay() {
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-z3z-Uq8mSHbjdVIq8O4Wrg');
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: cardsuccess, onCardEntryCancel: cardfail);
  }

  void upatehelpMessage(String newMessage) {
    setState(() {
      helpmessage = newMessage;
    });
  }

  void updatepaymentdue(int newval) {
    setState(() {
      paymentdue = newval;
    });
  }

  @override
  Widget build(BuildContext context) {
    //String $helpmessage;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*ElevatedButton(
                child: const Text('temp Scanner Info Page'),
                onPressed: () {
                  print("Scanner Info Clicked");
                  Navigator.of(context).pushNamed('/scannerinfo');
                },
              ), */
              //HeaderContainer(),
              Container(
                margin: EdgeInsets.all(5.0),
                //width: 350.0,
                height: 90.0,
                alignment: Alignment.center,
                //color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(helpmessage),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  //width: 50.0,
                                  height: 50.0,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  //color: Color.fromARGB(255, 100, 12, 12),
                                  child: ElevatedButton(
                                    child: const Text('Connect'),
                                    onPressed: connectScanner,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  //width: 50.0,
                                  height: 50.0,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  //color: Colors.white,
                                  child: ElevatedButton(
                                    child: const Text('How to Scan'),
                                    onPressed: () {
                                      print("How to Scan Clicked");
                                      Navigator.of(context)
                                          .pushNamed('/scannerhelp');
                                    },
                                  )),
                            ),
                            Container(
                              height: 50.0,
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: ElevatedButton(
                                onPressed: testpay,
                                child: Text('\$$paymentdue.00'),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 199, 197, 197),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ListView.builder(
                          itemCount: _scannedFilesImagesList.length,
                          itemBuilder: (context, index) {
                            //return scannedfileCard(scannedFiles[scannedFiles.length - index - 1]);

                            return Dismissible(
                              background: Container(
                                color: Colors.green,
                              ),
                              key: ValueKey<Widget>(_scannedFilesImagesList[
                                  _scannedFilesImagesList.length - index - 1]),
                              onDismissed: (DismissDirection direction) {
                                _scannedFilespath.removeAt(
                                    _scannedFilesImagesList.length - index - 1);
                                setState(() {
                                  _scannedFilesImagesList.removeAt(
                                      _scannedFilesImagesList.length -
                                          index -
                                          1);
                                });
                              },
                              child: ListTile(
                                title: _scannedFilesImagesList[
                                    _scannedFilesImagesList.length - index - 1],
                              ),
                            );
                          }))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        //width: 50.0,
                        height: 50.0,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        //color: Colors.white,
                        child: ElevatedButton(
                          child: const Text('Scan..'),
                          onPressed: AddaScannedFile,
                        )),
                  ),
                  Expanded(
                    child: Container(
                        //width: 50.0,
                        height: 50.0,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //color: Color.fromARGB(255, 100, 12, 12),
                        child: ElevatedButton(
                          child: const Text('Download'),
                          onPressed: sharefiles,
                        )),
                  ),
                ],
              )
              /*FooterContainer(
                scannedClickCallback: AddaScannedFile,
                shareClickCallback: sharefiles,
              ),*/
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key? key,
  }) : super(key: key);

  final String SSID = "DIRECT-b9DS-940DW_BR1294";
  final String pwd = "70b91294";

  Future<void> connectScanner() async {
    // This call to setState tells the Flutter framework that someßßßßthing has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    //_counter++;
    print("connecting to scanner");
    final isSuccess =
        await WifiConnector.connectToWifi(ssid: SSID, password: pwd);
    print(isSuccess);
  }

  void cardEntryComplete() {
    print("card Entry Complete");
  }

  void cardsuccess(CardDetails cd) {
    print("card Success");
    InAppPayments.completeCardEntry(onCardEntryComplete: cardEntryComplete);
  }

  void cardfail() {
    print("card Success");
  }

  void testpay() {
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-z3z-Uq8mSHbjdVIq8O4Wrg');
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: cardsuccess, onCardEntryCancel: cardfail);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      //width: 350.0,
      height: 70.0,
      alignment: Alignment.center,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("No Scanner Selected"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    //width: 50.0,
                    height: 50.0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //color: Color.fromARGB(255, 100, 12, 12),
                    child: ElevatedButton(
                      child: const Text('Connect'),
                      onPressed: connectScanner,
                    )),
              ),
              Expanded(
                child: Container(
                    //width: 50.0,
                    height: 50.0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //color: Colors.white,
                    child: ElevatedButton(
                      child: const Text('How to Scan'),
                      onPressed: () {
                        print("How to Scan Clicked");
                        Navigator.of(context).pushNamed('/scannerhelp');
                      },
                    )),
              ),
              ElevatedButton(
                child: const Text('\$1.00'),
                onPressed: testpay,
              )
            ],
          )
        ],
      ),
    );
  }
}

class FooterContainer extends StatelessWidget {
  /*
  const FooterContainer({
    Key? key,
  }) : super(key: key);
  */
  const FooterContainer(
      {required this.scannedClickCallback, required this.shareClickCallback});
  final void Function() scannedClickCallback;
  final void Function() shareClickCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      //width: 350.0,
      height: 70.0,
      alignment: Alignment.center,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Click a Document to share"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    //width: 50.0,
                    height: 50.0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //color: Colors.white,
                    child: ElevatedButton(
                      child: const Text('Scan..'),
                      onPressed: scannedClickCallback,
                    )),
              ),
              Expanded(
                child: Container(
                    //width: 50.0,
                    height: 50.0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //color: Color.fromARGB(255, 100, 12, 12),
                    child: ElevatedButton(
                      child: const Text('Share'),
                      onPressed: shareClickCallback,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
/*
class ScannedFilesViewContainer extends StatefulWidget {
  ScannedFilesViewContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<ScannedFilesViewContainer> createState() =>
      _ScannedFilesViewContainerState();
}

class _ScannedFilesViewContainerState extends State<ScannedFilesViewContainer> {
  //final List _scannedFiles = ['scan1', 'scan2', 'scan3', 'scan4', 'scan5'];
  final List _scannedFiles;
  void addaScannedFile() {
    setState(() {
      _scannedFiles.add("New Item");
    });
  } */

class ScannedFilesViewContainer extends StatefulWidget {
  const ScannedFilesViewContainer({required this.scannedFiles});
  final List scannedFiles;

  @override
  State<ScannedFilesViewContainer> createState() =>
      _ScannedFilesViewContainerState();
}

class _ScannedFilesViewContainerState extends State<ScannedFilesViewContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 199, 197, 197),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListView.builder(
            itemCount: widget.scannedFiles.length,
            itemBuilder: (context, index) {
              //return scannedfileCard(scannedFiles[scannedFiles.length - index - 1]);

              return Dismissible(
                background: Container(
                  color: Colors.green,
                ),
                key: ValueKey<Widget>(widget.scannedFiles[index]),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    widget.scannedFiles.removeAt(index);
                  });
                },
                child: ListTile(
                  title: widget.scannedFiles[index],
                ),
              );
            }));
  }

  Padding scannedfileCard(Widget data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 150.0,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 199, 197, 197),
            borderRadius: BorderRadius.circular(10.0)),
        child: data,
      ),
    );
  }
}
