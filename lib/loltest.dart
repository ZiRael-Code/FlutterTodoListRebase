import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FancyColorPicker()));
}

class FancyColorPicker extends StatefulWidget {
  @override
  _FancyColorPickerState createState() => _FancyColorPickerState();
}

class _FancyColorPickerState extends State<FancyColorPicker> {
  String selectedColorHex = '';

  final List<Map<String, dynamic>> colors = [
    {"name": "Red", "color": Colors.red},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Green", "color": Colors.green},
    {"name": "Yellow", "color": Colors.yellow},
    {"name": "Orange", "color": Colors.orange},
    {"name": "Purple", "color": Colors.purple},
    {"name": "Pink", "color": Colors.pink},
    {"name": "Brown", "color": Colors.brown},
    {"name": "Cyan", "color": Colors.cyan},
    {"name": "Teal", "color": Colors.teal},
  ];

  void _showColorPickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 345,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Choose a Color",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final colorItem = colors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorHex = colorItem['color'].value
                              .toRadixString(16)
                              .padLeft(8, '0')
                              .substring(2)
                              .toUpperCase();
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorItem['color'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                colorItem['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColorHex.isNotEmpty
          ? Color(int.parse('0xFF$selectedColorHex'))
          : Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: _showColorPickerDialog,
        child: Icon(Icons.edit, color: Colors.white),
      ),
      body: Center(
        child: Text(
          selectedColorHex.isNotEmpty
              ? "Selected Color: #$selectedColorHex"
              : "Choose a color",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
