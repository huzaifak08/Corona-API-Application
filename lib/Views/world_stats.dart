import '../libraries.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  // Animation Controller:

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 6), vsync: this)
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
              horizontal: width * 0.09, vertical: height * 0.04),
          child: Column(
            children: [
              SizedBox(height: height * 0.01),
              PieChart(
                dataMap: const {
                  'Total': 100,
                  'Recover': 50,
                  'Death': 50,
                },
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
                padding: EdgeInsets.symmetric(vertical: height * 0.04),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23)),
                  child: Column(
                    children: const [
                      CustomRow(title: 'Total', value: '900'),
                      CustomRow(title: 'Total', value: '1000'),
                      CustomRow(title: 'Total', value: '900'),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.09,
                decoration: BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Track Countries',
                    style: GoogleFonts.ubuntu().copyWith(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
