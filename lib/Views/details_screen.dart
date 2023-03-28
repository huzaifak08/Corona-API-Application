import 'package:corona_api/libraries.dart';

class DetailsScreen extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      critical,
      todayRecovered,
      test;
  const DetailsScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalRecovered,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.07),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString()),
                      CustomRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString()),
                      CustomRow(
                          title: 'Total Death',
                          value: widget.totalDeaths.toString()),
                      CustomRow(
                          title: 'Active Cases',
                          value: widget.active.toString()),
                      CustomRow(
                          title: 'Critical Cases',
                          value: widget.critical.toString()),
                      CustomRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      CustomRow(
                          title: 'Tests Performed',
                          value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
