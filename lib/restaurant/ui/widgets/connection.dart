import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:submiss1_fundamental/restaurant/ui/screen/disconnetion_internet.dart';

class Connection extends StatefulWidget {
  final Widget child;
  const Connection({super.key, required this.child});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() {
          _connectionStatus = result;
        });
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _initializeConnectivity() async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print("Failed to check connectivity: $e");
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == ConnectivityResult.none
        ? DisconnetionInternet()
        : widget.child;
  }
}
