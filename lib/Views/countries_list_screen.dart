import 'package:corona_api/Views/details_screen.dart';

import '../libraries.dart';

class CountriesListScreens extends StatefulWidget {
  const CountriesListScreens({super.key});

  @override
  State<CountriesListScreens> createState() => _CountriesListScreensState();
}

class _CountriesListScreensState extends State<CountriesListScreens> {
  // Search Controller:
  final searchController = TextEditingController();

  StatsService statsService = StatsService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: width * 0.03),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                  hintText: 'Search with country Name',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Expanded(
                  child: FutureBuilder(
                future: statsService.fetchCountriesListData(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          // ShortCut:
                          var data = snapshot.data![index];
                          return InkWell(
                            onTap: () => nextScreen(
                                context,
                                DetailsScreen(
                                  name: data['country'],
                                  totalCases: data['cases'],
                                  totalRecovered: data['recovered'],
                                  totalDeaths: data['deaths'],
                                  todayRecovered: data['todayRecovered'],
                                  active: data['active'],
                                  critical: data['critical'],
                                  test: data['tests'],
                                  image: data['countryInfo']['flag'],
                                )),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data['countryInfo']['flag']),
                                backgroundColor: Colors.green.shade500,
                              ),
                              title: Text(data['country']),
                              subtitle:
                                  Text('Cases: ${data['cases'].toString()}'),
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          var data = snapshot.data![index];

                          return InkWell(
                            onTap: () => nextScreen(
                                context,
                                DetailsScreen(
                                  name: data['country'],
                                  totalCases: data['cases'],
                                  totalRecovered: data['recovered'],
                                  totalDeaths: data['deaths'],
                                  todayRecovered: data['todayRecovered'],
                                  active: data['active'],
                                  critical: data['critical'],
                                  test: data['tests'],
                                  image: data['countryInfo']['flag'],
                                )),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data![index]['countryInfo']['flag']),
                                backgroundColor: Colors.green.shade500,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  'Cases: ${snapshot.data![index]['cases'].toString()}'),
                            ),
                          );
                        } else {
                          const Center(
                            child: Text('No Record Found!!!'),
                          );
                        }
                      },
                    );
                  } else {
                    // Linkedin Like Loading:

                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 59,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                            ),
                            title: Container(
                                height: 10, width: 89, color: Colors.white),
                            subtitle: Container(
                                height: 10, width: 89, color: Colors.white),
                          );
                        },
                      ),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
