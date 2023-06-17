import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:isolate_with_flutter/service/download_service.dart';
import 'package:isolate_with_flutter/service/get_currency_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Isolate"),
      ),
      body: FutureBuilder(
        future: CurrencyService.getCurrencyService(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.data is String) {
            return Text(snapshot.data);
          } else {
            List data = snapshot.data as List;
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]["title"]),
                );
              },
              itemCount: data.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ReceivePort receivePort = ReceivePort();
          //
          final isolate1 = await Isolate.spawn(_getFile, receivePort.sendPort);
          final isolate2 =
              await Isolate.spawn(_getCurrency, receivePort.sendPort);
          //
          final result = await receivePort.take(2).toList();
          //
          print(result);
          //
          isolate1.kill();
          isolate2.kill();
        },
      ),
    );
  }
}

void _getFile(SendPort sendPort) async {
  sendPort.send(await FileService.downloadFile());
}

void _getCurrency(SendPort sendPort) async {
  sendPort.send(await CurrencyService.getCurrencyService());
}
