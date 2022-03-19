import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class DeliverScreen extends StatefulWidget {
  const DeliverScreen({Key? key}) : super(key: key);

  @override
  State<DeliverScreen> createState() => _DeliverScreenState();
}

class _DeliverScreenState extends State<DeliverScreen> {
  SMITrigger? _trigger;
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    rootBundle.load("assets/delivery.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
        artboard,
        "StateMachine",
      );
      if (controller != null) {
        artboard.addController(controller);
        _trigger = controller.findInput<bool>("Package") as SMITrigger;
      }
      setState(() => _artboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => _packageAnimation()),
      child: Scaffold(
        backgroundColor: Color(0xFFDEE1EA),
        body: Center(
          child: Container(
            child: _artboard == null
                ? const SizedBox()
                : Rive(artboard: _artboard!),
          ),
        ),
      ),
    );
  }

  void _packageAnimation() {
    _trigger?.fire();
  }
}
