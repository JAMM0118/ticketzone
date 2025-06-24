import 'package:flutter/material.dart';

class EventSalesInfo extends StatelessWidget {
  final Size size;
  final String title;
  final Color color;
  final Color colorDates;
  final String startDate;
  final String endDate;

  const EventSalesInfo({
    super.key,
    required this.colorDates,
    required this.color,
    required this.size,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.35,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                "Start: ${startDate.substring(0, 10)}",
                style: TextStyle(
                  fontSize: 10,
                  color: colorDates,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "End: ${endDate.substring(0, 10)}",
                style: TextStyle(
                  fontSize: 10,
                  color: colorDates,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}