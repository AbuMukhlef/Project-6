import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tickets_app/core/all_file.dart';
import 'package:tickets_app/screens/add_reservation/add_reservation_bloc.dart';
import 'package:tickets_app/utils/img_converter.dart';
import '../../model/room.dart';

class AddReservationScreen extends StatelessWidget {
  const AddReservationScreen({super.key, required this.room});
  final Room room;
  final int total = 250;

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReservationBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddReservationBloc>();
        return Scaffold(
          body: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child:
                            ImgConverter.imageFromBase64String(room.imgData)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: IconButton(
                      onPressed: () => _navigateBack(context),
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 40),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(room.title)
                                .styled(size: 18, weight: FontWeight.bold),
                            Text('\$${room.price} / Night')
                                .styled(size: 18, weight: FontWeight.bold),
                          ],
                        ),
                      ),
                      Text(room.description)
                          .styled(size: 14, weight: FontWeight.w300),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Date:'),
                          Text(
                              '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}'),
                          IconButton(
                            onPressed: () => (),
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nights:'),
                          BlocBuilder<AddReservationBloc, AddReservationState>(
                            builder: (context, state) {
                              return NumberPicker(
                                value: (state is UpdateNightsState)
                                    ? state.nights
                                    : bloc.initialNightsValue,
                                axis: Axis.horizontal,
                                selectedTextStyle: const TextStyle(
                                    color: C.accent, fontSize: 24),
                                itemWidth: 30,
                                minValue: 1,
                                maxValue: 10,
                                onChanged: (value) => bloc.add(
                                    SelectNightsEvent(
                                        roomPrice: room.price,
                                        numNights: value)),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:').styled(),
                    BlocBuilder<AddReservationBloc, AddReservationState>(
                      builder: (context, state) {
                        return Text((state is UpdateNightsState)
                            ? '\$${state.totalPrice}'
                            : '${room.price}');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: MyButton(text: 'Confirm Booking', onPressed: () => ()),
              )
            ],
          ),
        );
      }),
    );
  }
}