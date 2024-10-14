import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class OrdersPage extends StatefulWidget {
  static const id = "fdsja";
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = {};
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreOrders();
  }

  _loadFirestoreOrders() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _orders = {};

    final snap = await FirebaseFirestore.instance
        .collection('ArchivedOrders')
        .where('createdAt', isGreaterThanOrEqualTo: firstDay)
        .where('createdAt', isLessThanOrEqualTo: lastDay)
        .get();

    for (var doc in snap.docs) {
      final order = doc.data();
      final day = DateTime.utc(order['createdAt'].toDate().year,
          order['createdAt'].toDate().month, order['createdAt'].toDate().day);

      if (_orders[day] == null) {
        _orders[day] = [];
      }
      _orders[day]!.add(order);
    }
    setState(() {});
  }

  List<dynamic> _getOrdersForTheDay(DateTime day) {
    return _orders[day] ?? [];
  }

  Map<String, List<dynamic>> _groupOrdersBySection(List<dynamic> orders) {
    Map<String, List<dynamic>> groupedOrders = {};
    for (var order in orders) {
      String sectionId =
          order['id']; // Предполагается, что 'id' содержит идентификатор цеха
      if (groupedOrders[sectionId] == null) {
        groupedOrders[sectionId] = [];
      }
      groupedOrders[sectionId]!.add(order);
    }
    return groupedOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календарь заказов')),
      body: Column(
        children: [
          TableCalendar(
            eventLoader: _getOrdersForTheDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              _loadFirestoreOrders();
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              selectedDecoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children:
                    _groupOrdersBySection(_getOrdersForTheDay(_selectedDay))
                        .entries
                        .map((entry) {
                  String sectionId = entry.key;
                  List<dynamic> orders = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sectionId,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...orders.map((order) {
                        return ListTile(
                          title: Text(order['mahsulot_nomi']),
                          subtitle: Text('Количество: ${order['count']}'),
                          trailing: Icon(
                            order['isDone'] ? Icons.check_circle : Icons.cancel,
                            color: order['isDone'] ? Colors.green : Colors.red,
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
