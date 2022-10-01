import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
import 'package:bookingapp/src/features/booking/presentation/screens/cancelled_booking.dart';
import 'package:bookingapp/src/features/booking/presentation/screens/completed_booking.dart';
import 'package:bookingapp/src/features/booking/presentation/screens/ubcomming_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AllMyBooking extends StatefulWidget {
  const AllMyBooking({Key? key}) : super(key: key);

  @override
  State<AllMyBooking> createState() => _AllMyBookingState();
}

class _AllMyBookingState extends State<AllMyBooking> {
  /// List of Tab Bar Item
  List<String> items = [
    "Upcoming",
    "Completed",
    "Cancelled",

  ];

  /// List of body icon
  List<Widget> bookingStatuses = [
    const UpcomingBooking(),
    const CompletedBooking(),
    const CancelledBooking()

  ];
  int current = 0;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllBookingCubit, AllBookingState>(
      listener: (context, state) {

        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocBuilder<AllBookingCubit, AllBookingState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[50],

              /// APPBAR
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.deepPurpleAccent[50],
                elevation: 2,
                title: Text(
                  "My Bookings",
                  style: GoogleFonts.laila(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [

                    /// CUSTOM TABBAR
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: items.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.all(5),
                                    width: 115,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: current == index
                                          ? Colors.black54
                                          : Colors.white30,
                                      borderRadius: current == index
                                          ? BorderRadius.circular(20)
                                          : BorderRadius.circular(15),
                                      border: current == index
                                          ? Border.all(
                                          color: Colors.grey, width: 2)
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        items[index],
                                        style: GoogleFonts.laila(
                                            fontWeight: current == index
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: current == index
                                                ? Colors.white
                                                : Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible: current == index,
                                    child: Container(
                                      width: 5,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurpleAccent,
                                          shape: BoxShape.circle),
                                    ))
                              ],
                            );
                          }),
                    ),

                    /// MAIN BODY
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        height: 550,
                        child: bookingStatuses[current],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}