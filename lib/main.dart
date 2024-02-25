import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() async {
  var box = await Hive.openBox('testBox');

  box.put('name', 'David');

  print('Name: ${box.get('name')}');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse App',
      home: WarehouseScreen(),
    );
  }
}

class WarehouseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanQRScreen()),
                );
              },
              child: Text('Nhập hàng'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle báo cáo tồn kho
              },
              child: Text('Báo cáo tồn kho'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle xuất hàng
              },
              child: Text('Xuất hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanQRScreen extends StatefulWidget {
  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // Handle khi quét QR code thành công
      // Ở đây bạn có thể xử lý kết quả quét mã QR
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
