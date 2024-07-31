import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_taxi/controller/auth_controller.dart';
import 'package:pinput/pinput.dart';

class RoundedWithShadow extends StatefulWidget {
  const RoundedWithShadow({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RoundedWithShadowState createState() => _RoundedWithShadowState();
}

class _RoundedWithShadowState extends State<RoundedWithShadow> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color.fromRGBO(70, 69, 66, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      focusNode: focusNode,
      onCompleted: (String input) {
        authController.isDecided = false;
        authController.verifyOtp(input);
      },
      defaultPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              offset: Offset(0, 3),
              blurRadius: 16,
            )
          ],
        ),
      ),
      separatorBuilder: (index) => const SizedBox(width: 10),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              offset: Offset(0, 3),
              blurRadius: 16,
            )
          ],
        ),
      ),
      showCursor: true,
      cursor: cursor,
    );
  }
}