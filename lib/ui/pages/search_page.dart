import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mealmarketapp/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';
import '../widgets/list_restaurant_card.dart';
import '../widgets/shimmer_restaurant_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode searchFocus = FocusNode();
  final TextEditingController searchController =
      TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    RestaurantProvider resProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: topPadding + 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: greenTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: searchController,
                onChanged: (text) {
                  resProvider.searchRestaurant(text);
                },
                style: blackTextStyle.copyWith(fontSize: 16),
                focusNode: searchFocus,
                decoration: InputDecoration(
                  hintText: "Search restaurant you want",
                  hintStyle: grayTextStyle.copyWith(fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGrayColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGreenColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: bottomPadding + 20,
                ),
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.searchState == ResultState.loading) {
                      return Column(
                        children: List.generate(10, (index) {
                          return ShimmerRestaurantList();
                        }),
                      );
                    } else if (state.searchState == ResultState.hasData) {
                      return Column(
                          children: List.generate(
                        state.searchResult?.restaurant.length ?? 0,
                        (index) {
                          return ListRestaurantCard(
                              state.searchResult!.restaurant[index]);
                        },
                      ));
                    } else if (state.searchState == ResultState.noData) {
                      return Center(
                        child: Material(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                Text(
                                  state.searchMessage,
                                  style: redTextStyle.copyWith(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state.searchState == ResultState.error) {
                      return Center(
                        child: Material(
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/icon/ic_not_connect.svg'),
                              ),
                              Text(
                                state.searchMessage,
                                style: redTextStyle.copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Material(child: Text('')),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
