import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mealmarketapp/data/model/restaurant_detail_model.dart';
import 'package:mealmarketapp/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';
import '../../theme/theme.dart';

class DetailPage extends StatefulWidget {
  final String idRes;
  const DetailPage({super.key, required this.idRes});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RestaurantProvider resProvider =
          Provider.of<RestaurantProvider>(context, listen: false);
      resProvider.restaurantDetail(widget.idRes);
    });

    Widget backgroundImage(String pictureId) {
      return Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://restaurant-api.dicoding.dev/images/medium/$pictureId",
            ),
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        width: double.infinity,
        height: 214,
        margin: EdgeInsets.only(top: 236),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kWhiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95),
            ],
          ),
        ),
      );
    }

    Widget content(RestaurantDetail? restaurant) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 30,
        ),
        child: Column(
          children: [
            // Note Title
            Container(
              margin: EdgeInsets.only(top: 256),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant?.name ?? "",
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          restaurant?.city ?? "",
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(right: 2),
                        child: SvgPicture.asset('assets/icon/ic_star.svg'),
                      ),
                      Text(
                        restaurant?.rating.toString() ?? "0.0",
                        style: whiteTextStyle.copyWith(fontWeight: medium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Description
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text About
                  Text(
                    'About',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    restaurant?.description ?? "",
                    style: blackTextStyle.copyWith(
                      height: 2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Foods',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      restaurant?.menus.foods.length ?? 0,
                      (index) {
                        return Row(
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                                restaurant?.menus.foods[index].name
                                        .toString() ??
                                    "",
                                style: blackTextStyle),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Drinks',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      restaurant?.menus.drinks.length ?? 0,
                      (index) {
                        return Row(
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                                restaurant?.menus.drinks[index].name
                                        .toString() ??
                                    "",
                                style: blackTextStyle),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 40,
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return Stack(
                children: [
                  backgroundImage(
                      state.detailResult?.restaurant.pictureId ?? ""),
                  customShadow(),
                  content(state.detailResult?.restaurant),
                ],
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child:
                            SvgPicture.asset('assets/icon/ic_not_connect.svg'),
                      ),
                      Text(
                        state.message,
                        style: redTextStyle.copyWith(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
