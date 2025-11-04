import 'package:flutter/material.dart';

class TorchButton extends StatefulWidget {
  final Function()? onPressed;

  const TorchButton({super.key, this.onPressed});

  @override
  State<TorchButton> createState() => _TorchButtonState();
}

class _TorchButtonState extends State<TorchButton> {
  bool _isOn = false;

  void _toggleTorch() {
    setState(() {
      _isOn = !_isOn;
    });

    // Panggil fungsi dari luar (misal: cameraController.toggleTorch)
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.flash_on,
        color: _isOn ? Colors.yellow : Colors.grey,
      ),
      onPressed: _toggleTorch,
    );
  }
}
