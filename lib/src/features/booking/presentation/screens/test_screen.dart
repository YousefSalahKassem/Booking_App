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