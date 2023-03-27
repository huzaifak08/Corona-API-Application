import 'package:corona_api/libraries.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String value;
  const CustomRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.007),
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins().copyWith(fontSize: 16),
              ),
              Text(
                value,
                style: GoogleFonts.poppins().copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          const Divider()
        ],
      ),
    );
  }
}
