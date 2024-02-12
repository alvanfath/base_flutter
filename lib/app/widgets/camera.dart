// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:micro_frontend_danain/app/presentation/widgets/text.dart';
// import 'package:micro_frontend_danain/app/presentation/widgets/toast.dart';
// import 'package:micro_frontend_danain/app/utils/constants/app_constants.dart';

// class CameraWidget extends StatefulWidget {
//   final String camType;
//   final String title;
//   final String subtitle;
//   const CameraWidget({
//     super.key,
//     required this.camType,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   State<CameraWidget> createState() => _CameraWidgetState();
// }

// class _CameraWidgetState extends State<CameraWidget> {
//   late CameraController controller;
//   late Future<void> initializeController;

//   String? errorText;
//   void initCamera() async {
//     final cameras = await availableCameras();
//     var camera = cameras.first;

//     if (widget.camType == AppConstants.selfieCamera ||
//         widget.camType == AppConstants.selfieIdCard) {
//       camera = cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => camera,
//       );
//     }

//     controller = CameraController(
//       camera,
//       ResolutionPreset.medium,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );

//     try {
//       initializeController = controller.initialize();
//       await initializeController;
//       if (mounted) {
//         print('Akses kamera sukses');
//         setState(() {});
//       }
//     } on CameraException catch (e) {
//       setState(() {
//         errorText = 'Akses kamera tidak ditemukan: ${e.description}';
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: appbarCam(context),
//       body: bodyBuilder(controller),
//       bottomNavigationBar: buttonCapture(context),
//     );
//   }

//   Widget buttonCapture(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(height: 24),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () async {
//             try {
//               await initializeController;
//               await controller.setFlashMode(FlashMode.off);
//               final picture = await controller.takePicture();
//               final String resizedImagePath = await resizeImage(picture.path);
//               print('Gambar diambil: ${picture.path}');

//               Navigator.pop(context, resizedImagePath);
//             } catch (e) {
//               print("Error saat mengambil gambar: $e");
//               showToastBottom('Kamera Error');
//               Navigator.pop(context);
//             }
//           },
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(
//                 width: 5,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   PreferredSizeWidget appbarCam(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.black,
//       toolbarHeight: 100,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.close,
//           color: Colors.white,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       title: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidget(
//             text: widget.title,
//             fontSize: 14,
//             color: Colors.white,
//             fontWeight: AppConstants.medium,
//           ),
//           const SizedBox(height: 8),
//           TextWidget(
//             text: widget.subtitle,
//             fontSize: 11,
//             color: Colors.white,
//             fontWeight: AppConstants.regular,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bodyBuilder(CameraController camController) {
//     if (camController.value.isInitialized) {
//       return SizedBox(
//         width: MediaQuery.of(context).size.width,
//       );
//     }
//     return Center(
//       child: TextWidget(
//         text: errorText ?? '',
//         fontSize: 14,
//         fontWeight: AppConstants.regular,
//         align: AppConstants.textCenter,
//       ),
//     );
//   }

//   Widget cameraBuilder(String camWidget) {
//     switch (camWidget) {
//       case AppConstants.generalCamera:
//         return CameraPreview(controller);
//       case AppConstants.selfieCamera:
//         return selfieCam();
//       case AppConstants.idCardCamera:
//         return idCardCam();
//       case AppConstants.selfieIdCard:
//         return selfieIdCard();
//       default:
//         return CameraPreview(controller);
//     }
//   }

//   Widget selfieCam() {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         CameraPreview(controller),
//         Padding(
//           padding: const EdgeInsets.only(top: 100),
//           child: SizedBox(
//             width: 200,
//             height: 250,
//             child: CustomPaint(
//               painter: DottedEllipsePainter(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget idCardCam() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         CameraPreview(controller),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           width: MediaQuery.of(context).size.width,
//           height: 250,
//           child: DottedBorder(
//             color: Colors.white,
//             strokeWidth: 1,
//             dashPattern: [10, 6],
//             child: Container(),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget selfieIdCard() {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         CameraPreview(controller),
//         Padding(
//           padding: const EdgeInsets.only(top: 50),
//           child: Container(
//             width: 200,
//             height: 250,
//             child: CustomPaint(
//               painter: DottedEllipsePainter(),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 350),
//           child: Container(
//             width: 200,
//             height: 130,
//             child: DottedBorder(
//               color: Colors.white,
//               strokeWidth: 1,
//               dashPattern: [10, 6],
//               child: Container(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<String> resizeImage(String originalImagePath) async {
//     final file = File(originalImagePath);

//     Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
//       file.absolute.path,
//       quality: 85,
//     );
//     String resizedImagePath = originalImagePath.replaceFirst(
//       '.jpg',
//       '_resized.jpg',
//     );
//     File resizedFile = File(resizedImagePath);
//     await resizedFile.writeAsBytes(compressedBytes!);

//     return resizedImagePath;
//   }
// }

// class DottedEllipsePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     final dashWidth = 5; // Width of each dash
//     final dashSpace = 5; // Space between dashes

//     double angle = 0;
//     while (angle < 360) {
//       final startX =
//           size.width / 2 + size.width / 2 * cos(_degreesToRadians(angle));
//       final startY =
//           size.height / 2 + size.height / 2 * sin(_degreesToRadians(angle));
//       final endX = size.width / 2 +
//           (size.width / 2 + dashWidth) * cos(_degreesToRadians(angle));
//       final endY = size.height / 2 +
//           (size.height / 2 + dashWidth) * sin(_degreesToRadians(angle));

//       canvas.drawLine(
//         Offset(startX, startY),
//         Offset(endX, endY),
//         paint,
//       );
//       angle += dashWidth + dashSpace;
//     }
//   }

//   double _degreesToRadians(double degrees) {
//     return degrees * (pi / 180);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
