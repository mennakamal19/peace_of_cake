// import 'package:flutter/material.dart';
// import 'package:peace_of_cake/modules/authentication/signin_screen.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class BoardingModel{
//   final String image;
//   final String title;
//   final String body;
//   BoardingModel({
//     required this.body,
//     required this.image,
//     required this.title,
//
//   });
// }
// class OnBoarding extends StatefulWidget {
//   @override
//   _OnBoardingState createState() => _OnBoardingState();
// }
//
// class _OnBoardingState extends State<OnBoarding> {
//   var boardController = PageController();
//
//   List<BoardingModel> boarding=[
//
//     BoardingModel(body:'Find the job of your dreams that matches your skills' , image:'images/onboardingone.jpg', title:'We are hiring!'),
//     BoardingModel(body:'You can do your own interview while you are at home' , image:'images/onboardingtwo.jpg', title:'Online interviews'),
//     BoardingModel(body:'Convert all Images to text, then screen reader can read it for you' , image:'images/onboardingthree.jpg', title:'OCR Enable')
//   ];
//   bool isLast = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           actions: [
//             TextButton(onPressed: ()
//             {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));},
//                 child: Text('skip',
//                   style: TextStyle(
//                       color: Theme.of(context).colorScheme.secondary
//             ),)
//             )
//           ],
//         ),
//         body:Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   onPageChanged: (int index){
//                     if(index == boarding.length-1){
//                       print('Last');
//                       setState(() {
//                         isLast=true;
//                       });
//                     }else{
//                       print('not Last');
//                       setState(() {
//                         isLast=false;
//                       });
//
//                     }
//                   },
//                   controller: boardController,
//                   physics: BouncingScrollPhysics(),
//                   itemBuilder: (context,index)=>buildBordingItem(boarding[index]),
//                   itemCount: boarding.length,
//
//                 ),
//               ),
//               SizedBox(height: 40.0),
//               Row(
//                 children: [
//                   SmoothPageIndicator(controller: boardController,
//                       effect: ExpandingDotsEffect(
//                         dotColor: Colors.grey,
//                         activeDotColor:Theme.of(context).colorScheme.secondary,
//                         dotHeight: 10,
//                         expansionFactor: 2,
//                         dotWidth: 10,
//                         spacing: 5,
//                       ),
//                       count: boarding.length),
//                   Spacer(),
//                   FloatingActionButton(onPressed:() {
//                     if(isLast)
//                     {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));
//                     }else
//                       {
//                         boardController.nextPage(duration: Duration(milliseconds: 750,),
//                           curve:Curves.fastLinearToSlowEaseIn, );
//                       }
//                     },
//                     backgroundColor: Theme.of(context).colorScheme.secondary,
//                     child: Icon(Icons.arrow_forward_ios),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//     );
//   }
//
//   Widget buildBordingItem(BoardingModel model)=>Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: Image(
//           image:AssetImage('${model.image}'),
//         ),
//       ),
//       SizedBox(height: 30.0),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('${model.title}',style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black
//           ),),
//         ],
//       ),
//       SizedBox(height: 30.0),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('${model.body}',style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               color: Colors.black
//           ),),
//         ],
//       ),
//       SizedBox(height: 30.0)
//     ],
//   );
// }
