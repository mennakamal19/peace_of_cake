// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// class ViewCV extends StatefulWidget {
//
//
//   @override
//   _ViewCVState createState() => _ViewCVState();
// }
//
// class _ViewCVState extends State<ViewCV> {
//   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
//   Future<void> listExample() async {
//     firebase_storage.ListResult result =
//     await firebase_storage.FirebaseStorage.instance.ref().child('playground').listAll();
//
//     result.items.forEach((firebase_storage.Reference ref) {
//       print('Found file: $ref');
//     });
//
//     result.prefixes.forEach((firebase_storage.Reference ref) {
//       print('Found directory: $ref');
//     });
//   }
//   Future<void> downloadURLExample() async {
//     String downloadURL = await firebase_storage.FirebaseStorage.instance
//         .ref('playground/some-file.pdf')
//         .getDownloadURL();
//     print(downloadURL);
//     PDFDocument doc = await PDFDocument.fromURL(downloadURL);
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDF(doc)));  //Notice the Push Route once this is done.
//   }
//   @override
//   void initState() {
//
//     super.initState();
//     listExample();
//     downloadURLExample();
//     print("All done!");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(
//       ),
//     );
//   }
// }
//
// class ViewPDF extends StatefulWidget {
//   PDFDocument document;
//   ViewPDF(this.document);
//   @override
//   _ViewPDFState createState() => _ViewPDFState();
// }
//
// class _ViewPDFState extends State<ViewPDF> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: PDFViewer(document: widget.document));
//   }
// }