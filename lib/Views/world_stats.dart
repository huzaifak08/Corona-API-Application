import 'package:corona_api/Views/countries_list_screen.dart';

import '../libraries.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  StatsService statesService = StatsService();
  // Animation Controller:

  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this)
    ..repeat();

  @override
  void dispose() {
    _controller.dispose(); // Must dispose the controller:
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.09, vertical: height * 0.02),
          child: Column(
            children: [
              SizedBox(height: height * 0.01),
              FutureBuilder(
                future: statesService.fetchWorldStatesData(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recover': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          // to show in Percentage:
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(seconds: 2),
                          chartType: ChartType.ring,
                          colorList: colorList,

                          // Three Options on right(By Deafult)
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendShape: BoxShape.circle,
                            legendTextStyle: GoogleFonts.poppins(),
                            // showLegendsInRow: true,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.04),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)),
                            child: Column(
                              children: [
                                CustomRow(
                                    title: 'Total Cases',
                                    value: snapshot.data!.cases.toString()),
                                CustomRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                CustomRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                CustomRow(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                CustomRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                CustomRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),

                        // Track Countries Button:

                        InkWell(
                          onTap: () {
                            nextScreen(context, const CountriesListScreens());
                          },
                          child: Container(
                            height: height * 0.09,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style:
                                    GoogleFonts.ubuntu().copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
