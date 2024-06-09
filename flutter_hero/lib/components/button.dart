import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final bool isLoading;
  final String TextButton;

  const ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.TextButton,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading && onTap != null) {
          onTap!();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(23),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: isLoading
                  ? Colors.grey
                  : Colors.black, // Disable color change
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                TextButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
