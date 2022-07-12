import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel_details.dart';
import 'package:hotels/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  init(BuildContext context) {
    context
        .read<DetailsViewModel>()
        .init(uuid: ModalRoute.of(context)!.settings.arguments.toString());
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    final bool hasError = context.select((DetailsViewModel vm) => vm.hasError);
    final bool isLoading =
        context.select((DetailsViewModel vm) => vm.isLoading);
    final HotelDetails? hotelDetails =
        context.select((DetailsViewModel vm) => vm.hotelDetails);
    final String errorMessage =
        context.select((DetailsViewModel vm) => vm.errorMessage);
    final Map<String, dynamic> address = hotelDetails?.address ?? {};
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(hotelDetails?.name ?? '')),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : hasError
              ? Center(
                  child: Text(errorMessage),
                )
              : SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CarouselSlider(
                        items: List.generate(
                          hotelDetails?.photos.length ?? 0,
                          (index) => Image(
                            image: ResizeImage(
                                AssetImage(
                                    'assets/images/${hotelDetails?.photos[index]}'),
                                width: 600,
                                height: 400),
                          ),
                        ),
                        // Image.asset(
                        // 'assets/images/${hotelDetails?.photos[index]}')),
                        options: CarouselOptions(
                            enlargeCenterPage: true, disableCenter: true)),
                    _BuildAddressRow(
                        title: 'Страна', subtitle: address['country']),
                    _BuildAddressRow(title: 'Город', subtitle: address['city']),
                    _BuildAddressRow(title: 'Улица', subtitle: address['street']),
                    _BuildAddressRow(
                        title: 'Рейтинг',
                        subtitle: hotelDetails?.rating.toString() ?? 'Not found'),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Сервисы',
            style: TextStyle(
                fontSize: 30,
            ),
          ),
        ),
                    _BuildServices(
                      free: hotelDetails?.services['free'] ?? [],
                      paid: hotelDetails?.services['paid'] ?? [],
                    )
                  ]),
              ),
    );
  }
}

class _BuildAddressRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const _BuildAddressRow(
      {required this.title, required this.subtitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _BuildServices extends StatelessWidget {
  final List<String> free;
  final List<String> paid;
  const _BuildServices({required this.free, required this.paid, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Платные',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            ...List.generate(
                paid.length,
                (index) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(paid[index]))),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Бесплатно',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            ...List.generate(paid.length, (index) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(paid[index]))),
          ],
        )
      ],
    );
  }
}
