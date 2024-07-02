import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  State<NewEvent> createState() => NewEventState();
}

class NewEventState extends State<NewEvent> {
  TextEditingController eventController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool showReminderMenu = false;
  bool notValid = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? reminderOption;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> register() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fecha y hora son requeridos'),
        ),
      );
      return;
    }

    final DateTime dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    var url = Uri.parse('http://10.0.2.2:3002/api/events/new_event');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'event': eventController.text,
        'location': placeController.text,
        'description': descriptionController.text,
        'date_hour': dateTime.toIso8601String(),
        'notification_min': reminderOption?.toString() ?? '0',
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro correcto'),
        ),
      );
      eventController.clear();
      placeController.clear();
      descriptionController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de registro: ${response.statusCode}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 242, 220, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 50.0),
                child: Text(
                  'New Event',
                  style: GoogleFonts.markoOne(
                    fontSize: 57,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 8, 8, 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            TextField(
              controller: eventController,
              obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(224, 2, 114, 129),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Event',
                    labelStyle: TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(228, 199, 225, 221),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          errorText: notValid ? "Campo vacío" : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(224, 2, 114, 129),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                        ),
                        controller: TextEditingController(
                          text: selectedDate == null
                              ? ''
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(228, 199, 225, 221),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          errorText: notValid ? "Campo vacío" : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(224, 2, 114, 129),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'Hour',
                          labelStyle: TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                        ),
                        controller: TextEditingController(
                          text: selectedTime == null
                              ? ''
                              : selectedTime!.format(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: placeController,
              obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(224, 2, 114, 129),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Place',
                    labelStyle: TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(224, 2, 114, 129),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
              maxLines: 3,
            ),
            SizedBox(height: 25.0),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showReminderMenu = !showReminderMenu;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.red,
                        size: 40.0,
                      ),
                      SizedBox(width: 8.0),
                      Text('Remember me'),
                    ],
                  ),
                ),
                if (showReminderMenu)
                  Stack(
                    children: [
                       Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: showReminderMenu ? 150.0 : 0.0,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text('5 minutes before'),
                                  onTap: () {
                                    setState(() {
                                      reminderOption = 5;
                                      showReminderMenu = false;
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text('10 minutes before'),
                                  onTap: () {
                                    setState(() {
                                      reminderOption = 10;
                                      showReminderMenu = false;
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text('15 minutes before'),
                                  onTap: () {
                                    setState(() {
                                      reminderOption = 15;
                                      showReminderMenu = false;
                                    });
                                  },
                                ),
                              ],
                          ),
                    ),
                  ),
                ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 217, 235, 82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              onPressed: () {
                register();
              },
              child: Text('Save',
                style: GoogleFonts.kurale(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
             
            ),
          ],
        ),
      ),
    );
  }
}
