import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/Providers/crypto_data_provider.dart';
import 'package:crypto_currency/Ui/Ui_helper/home_page_view.dart';
import 'package:crypto_currency/Ui/Ui_helper/theme_switcher.dart';
import 'package:crypto_currency/helpers/decimalRounder.dart';
import 'package:crypto_currency/models/CryptoData.dart';
import 'package:crypto_currency/network/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageViewController = PageController();
  int defualtChoiceIndex = 0;

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];

  @override
  void initState() {
    final CryptoDataProvider cryptoDataProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoDataProvider.getTopMarketCapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CryptoDataProvider cryptoDataProvider =
        Provider.of<CryptoDataProvider>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final ThemeData themeData = Theme.of(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: const [
          ThemeSwitcher(),
        ],
        title: const Text('Crypto'),
        titleTextStyle: themeData.textTheme.titleLarge,
      ),
      drawer: const Drawer(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width - 12,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    HomePageView(controller: pageViewController),
                    Positioned(
                      bottom: 15,
                      child: SmoothPageIndicator(
                        count: HomePageView.images.length,
                        controller: pageViewController,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                        ),
                        onDotClicked: (index) {
                          pageViewController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceInOut,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.height,
                child: Marquee(
                  text: '🔊 this is place for news in application ',
                  style: themeData.textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          backgroundColor: Colors.green[700]),
                      child: const Text('buy'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        backgroundColor: Colors.red[700],
                      ),
                      child: const Text('sell'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        Wrap(
                          spacing: 8,
                          children: List.generate(_choicesList.length, (index) {
                            return ChoiceChip(
                              label: Text(
                                _choicesList[0],
                                style: themeData.textTheme.titleSmall,
                              ),
                              selected: defualtChoiceIndex == index,
                              selectedColor: Colors.lightBlue,
                              onSelected: (value) {
                                setState(() {
                                  defualtChoiceIndex =
                                      value ? index : defualtChoiceIndex;
                                  switch (index) {
                                    case 0:
                                      cryptoDataProvider.getTopMarketCapData();
                                      break;
                                    case 1:
                                      cryptoDataProvider.getTopGainersData();
                                      break;
                                    case 2:
                                      cryptoDataProvider.getTopLosersData();
                                      break;
                                  }
                                });
                              },
                            );
                          }),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height / 7),
                  child: Consumer<CryptoDataProvider>(
                    builder: (context, cryptoData, child) {
                      switch (cryptoData.state.status) {
                        case Status.LOADING:
                          return SizedBox(
                            height: 80,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white,
                                child: ListView.builder(
                                    itemCount: 50,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0, bottom: 8, left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 30,
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox(
                                              width: 70,
                                              height: 40,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                          );
                        case Status.COMPLETED:
                          List<CryptoData> dataModel =
                              cryptoData.dataFuture.data!.cryptoCurrencyList!;
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                int number = index + 1;
                                int tokenId = dataModel[index].id;
                                final Color filterColor =
                                    DecimalRounder.setColorFilter(
                                  dataModel[index].quotes![0].percentChange24h,
                                );
                                final String finalPrice =
                                    DecimalRounder.removePriceDecimals(
                                  dataModel[index].quotes![0].price,
                                );
                                final String percentChange =
                                    DecimalRounder.removePercentDecimals(
                                  dataModel[index].quotes![0].percentChange24h,
                                );

                                Color percentColor =
                                    DecimalRounder.setPercentChangesColor(
                                  dataModel[index].quotes![0].percentChange24h,
                                );
                                Icon percentIcon =
                                    DecimalRounder.setPercentChangesIcon(
                                  dataModel[index].quotes![0].percentChange24h,
                                );

                                return SizedBox(
                                  height: height * 0.075,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          number.toString(),
                                          style: themeData.textTheme.bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 15),
                                        child: CachedNetworkImage(
                                            fadeInDuration: const Duration(
                                                milliseconds: 500),
                                            height: 32,
                                            width: 32,
                                            imageUrl:
                                                "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            }),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataModel[index].name!,
                                              style:
                                                  themeData.textTheme.bodySmall,
                                            ),
                                            Text(
                                              dataModel[index].symbol!,
                                              style: themeData
                                                  .textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            filterColor,
                                            BlendMode.srcATop,
                                          ),
                                          child: SvgPicture.network(
                                            'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\$$finalPrice",
                                                style: themeData
                                                    .textTheme.bodySmall,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  percentIcon,
                                                  Text(
                                                    percentChange + "%",
                                                    style: GoogleFonts.ubuntu(
                                                        color: percentColor,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                );
                              },
                              itemCount: dataModel.length);

                        case Status.ERROR:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cryptoData.state.message),
                              CircularProgressIndicator()
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnLoadingShimmerWidget extends StatelessWidget {
  final CryptoDataProvider? cryptoDataProvider;

  const OnLoadingShimmerWidget({
    this.cryptoDataProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.white,
          child: ListView.builder(
              itemCount: cryptoDataProvider
                      ?.dataFuture.data?.cryptoCurrencyList?.length ??
                  20,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(Icons.add),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                width: 25,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(
                        width: 70,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                width: 25,
                                height: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
