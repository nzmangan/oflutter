import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:queries/collections.dart';
import 'package:woc_events_mobile/Models/EventInformation.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/DateWidget.dart';
import 'package:woc_events_mobile/Pages/Events/SubWidgets/EventsDayWidget.dart';
import 'package:woc_events_mobile/Widgets/AppHeader.dart';

class EventsPage extends StatefulWidget {
  final int groupKey;
  final List<EventInformation> events;
  final bool showWarning;

  EventsPage({@required this.groupKey, @required this.events, @required this.showWarning});

  @override
  EventsPageState createState() {
    return new EventsPageState();
  }
}

class EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    var month = widget.groupKey % 100;
    var year = (widget.groupKey - month) ~/ 100;

    var text = new DateFormat('MMMM yyyy').format(DateTime(year, month, 1));

    List<Widget> slivers = [
      AppHeader(
        text: text,
        showWarning: widget.showWarning,
      ),
    ];

    int now = DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day;

    var dayEvents = new Collection(widget.events).groupBy((p) => p.date);
    EventInformation selectedDate = new Collection(widget.events).orderBy((p) => p.date).firstOrDefault((p) {
      int ed = p.date.year * 10000 + p.date.month * 100 + p.date.day;
      return now <= ed && ed - now < 100;
    });

    for (var dayEvent in dayEvents.asIterable()) {
      var events = dayEvent.select((p) => p).toList();
      bool selected = selectedDate != null && selectedDate.date == dayEvent.key;

      slivers.add(
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateWidget(
                date: dayEvent.key,
                nextEvent: selected,
              ),
              EventsDayWidget(events: events),
            ],
          ),
        ),
      );
    }

    slivers.add(
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(''),
        ),
      ),
    );

    return CustomScrollView(
      slivers: slivers,
    );
  }
}
