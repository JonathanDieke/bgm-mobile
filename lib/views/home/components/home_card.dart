import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/providers/daily_data_provider.dart';

class HomeCard extends StatefulWidget {
  HomeCard(
      {Key? key,
      required this.attachedView,
      required this.icon,
      required this.title})
      : super(key: key);

  String attachedView, title;
  IconData icon;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyDataProvider>(
      builder: (context, dailyDataProvider, child) {
        return dailyDataProvider.isForCurrentDay()
            ? Card(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(3.0, -1.0),
                      colors: [
                        Color(0xFFffffff),
                        Color.fromARGB(255, 224, 86, 93),
                        Color(0xFFffffff),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, widget.attachedView);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        const SizedBox(height: 50),
                        Center(
                          child: IconButton(
                            icon: FaIcon(
                              widget.icon,
                              size: 100,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, widget.attachedView);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
