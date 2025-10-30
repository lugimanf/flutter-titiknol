import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Duration delay;

  static LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;
  String _message = "";

  void show({String message = ""}) {
    setState(() {
      _isLoading = true;
      _message = message;
    });
  }

  void hide() {
    setState(() {
      _isLoading = false;
      _message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          ),
        if (_isLoading)
          Center(
            child: FutureBuilder(
              future: Future.delayed(widget.delay),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFD7BE9D)),
                      )
                    : const SizedBox();
              },
            ),
          ),
        if (_isLoading)
          Center(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 70, bottom: 0, left: 0, right: 0),
                  child: Text(_message,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: const_fonts.fontFamilyUsed,
                          decoration: TextDecoration.none,
                          fontSize: 12))))
      ],
    );
  }
}
