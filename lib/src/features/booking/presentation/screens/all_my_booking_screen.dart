// import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class AllMyBooking extends StatefulWidget {
//   final AnimationController animationController;
//
//   const AllMyBooking({Key? key, required this.animationController})
//       : super(key: key);
//
//   @override
//   State<AllMyBooking> createState() => _AllMyBookingState();
// }
//
// class _AllMyBookingState extends State<AllMyBooking>
//     with TickerProviderStateMixin {
//   late ScrollController scrollController;
//   late AnimationController _animationController;
//   var sliderImageHeight = 0.0;
//   final myController = TextEditingController();
//
//   @override
//   void initState() {
//     _animationController = AnimationController(
//         duration: const Duration(milliseconds: 0), vsync: this);
//     widget.animationController.forward();
//     scrollController = ScrollController(initialScrollOffset: 0.0);
//     scrollController.addListener(() {
//       if (mounted) {
//         if (scrollController.offset < 0) {
//           // we static set the just below half scrolling values
//           _animationController.animateTo(0.0);
//         } else if (scrollController.offset > 0.0 &&
//             scrollController.offset < sliderImageHeight) {
//           // we need around half scrolling values
//           if (scrollController.offset < ((sliderImageHeight / 1.5))) {
//             _animationController
//                 .animateTo((scrollController.offset / sliderImageHeight));
//           } else {
//             // we static set the just above half scrolling values "around == 0.64"
//             _animationController
//                 .animateTo((sliderImageHeight / 1.5) / sliderImageHeight);
//           }
//         }
//       }
//     });
//     super.initState();
//   }
//
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllBookingCubit,AllBookingStatus>(
//         builder: (context,state){
//       if(state is AllBookingStatusComplete){
//         final bookingList = state.cancelledBookings;
//         return ListView.builder(
//           controller: scrollController,
//           itemCount: state.upcomingBookings.length,
//           padding: const EdgeInsets.only(
//             top: 8 + 158 + 52.0,
//           ),
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) {
//             var count = bookingList.length > 10
//                 ? 10
//                 : bookingList.length;
//             var animation = Tween(begin: 0.0, end: 1.0)
//                 .animate(CurvedAnimation(
//                 parent: _animationController,
//                 curve: Interval(
//                     (1 / count) * index, 1.0,
//                     curve: Curves.fastOutSlowIn)));
//             _animationController.forward();
//             return Center(child: Container(child: const Text('to be added'),));
//           },
//         );
//       }
//       return const Center(child: CircularProgressIndicator(),);
//     });
//
//
//   }
//
//
//
//
//
//
// }
//
//
// /*
// BookingListView(
//               callback: () {
//
//               },
//               bookingData: bookingList[index],
//               animation: animation,
//               animationController: _animationController,
//             );
//  */
//
import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMyBooking extends StatefulWidget {
  const AllMyBooking({Key? key}) : super(key: key);

  @override
  State<AllMyBooking> createState() => _AllMyBookingState();
}

class _AllMyBookingState extends State<AllMyBooking> {
  @override
  void initState() {
    AllBookingCubit.get(context).getAllBookings('upcomming');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBookingCubit, AllBookingState>(
      builder: (context, state) {
        if (state is AllBookingStatusComplete) {
          // var list = [];
          // if(index == 0) list = state.completedBookings;
          // if(index == 1) list = state.upcomingBookings;
          // if(index == 2) list = state.cancelledBookings;
          // }
          // return List.Builder(list: list);
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Text(state.upcomingBookings[index].hotel.name),
              );
            },
            itemCount: state.upcomingBookings.length,
          );
        }
        return Container();
      },
    );
  }
}
