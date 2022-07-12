import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.select((HomeViewModel vm) => vm.isLoading);
    final bool hasError = context.select((HomeViewModel vm) => vm.hasError);
    final bool oneTitleInARow =
        context.select((HomeViewModel vm) => vm.isOneTitleInARow);
    final List<HotelPreview> hotels =
        context.select((HomeViewModel vm) => vm.hotels);
    final String errorMessage =
        context.select((HomeViewModel vm) => vm.errorMessage);
    final makeOneTitleInARow = context.read<HomeViewModel>().makeOneTitleInARow;
    final makeTwoTitlesInARow =
        context.read<HomeViewModel>().makeTwoTitlesInARow;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: makeOneTitleInARow, icon: const Icon(Icons.list)),
          IconButton(
              onPressed: makeTwoTitlesInARow,
              icon: const Icon(Icons.view_module))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : hasError
              ? Center(
                  child: Text(errorMessage),
                )
              : GridView.builder(
                  clipBehavior: Clip.antiAlias,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: oneTitleInARow ? 1 : 2),
                  itemCount: hotels.length,
                  itemBuilder: (BuildContext context, index) {
                    return _BuildHotelCardWidget(index: index);
                  },
                ),
    );
  }
}

class _BuildHotelCardWidget extends StatelessWidget {
  const _BuildHotelCardWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final HotelPreview hotel = context.read<HomeViewModel>().hotels[index];
    final bool oneTitleInARow = context.read<HomeViewModel>().isOneTitleInARow;
    final navigateToDetailsScreen =
        context.read<HomeViewModel>().navigateToDetailsScreen;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                Image(
                  image: ResizeImage(
                      AssetImage('assets/images/${hotel.poster}'),
                      width: 500,
                      height: oneTitleInARow ? 400 : 325),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          hotel.name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ...oneTitleInARow
                          ? [
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    navigateToDetailsScreen(index);
                                  },
                                  child: const Text('Подробнее'))
                            ]
                          : []
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        oneTitleInARow
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  navigateToDetailsScreen(index);
                },
                child: Container(
                  width: max(height, width) * 0.485,
                  height: max(height, width) * 0.05,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: const Center(
                      child: Text(
                    'Подробнее',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
      ],
    );
  }
}
