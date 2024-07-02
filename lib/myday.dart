import 'package:flutter/material.dart';


class MyDay extends StatefulWidget {
  const MyDay({super.key});

  @override
  State<MyDay> createState() => MyDayState();
}

class MyDayState extends State<MyDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.label),
          onPressed: () {
            // Action for button
          },
        ),
        title: Text('Mi Día'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'martes 16 de abril',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              _buildTimeBlock('7 AM', [
                'Examen de Estadística',
                'Entrega de proyecto',
              ]),
              _buildTimeBlock('8 AM', [
                'Tutoría con Ariana',
                'Registro de tutoría',
              ]),
              _buildTimeBlock('9 AM', [
                'Cita con psicóloga',
              ]),
              _buildTimeBlock('10 AM', [
                'Brunch',
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for FAB
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTimeBlock(String time, List<String> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: events.map((event) => _buildEvent(event)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEvent(String event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.fiber_manual_record, size: 10),
          SizedBox(width: 8),
          Text(event),
        ],
      ),
    );
  }
}
