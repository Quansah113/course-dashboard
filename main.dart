import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Course Dashboard",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CourseDashboardApp(), // now wrapped correctly
    );
  }
}

class CourseDashboardApp extends StatefulWidget {
  @override
  _CourseDashboardAppState createState() => _CourseDashboardAppState();
}

class _CourseDashboardAppState extends State<CourseDashboardApp> {
  int _selectedIndex = 0;
  String selectedCategory = "None";

  final List<Map<String, String>> courses = [
    {"name": "Information Security", "instructor": "Mr. J. Mensah", "icon": "📘"},
    {"name": "Research Methods", "instructor": "Dr. P. Appiahene", "icon": "🔬"},
    {"name": "Mobile Application", "instructor": "Mr. E . Botchway", "icon": "💻"},
    {"name": "Project Management", "instructor": "Dr. K. Adu", "icon": "📜"},
    {"name": "Python", "instructor": "Mr. M. J. Ayitey", "icon": "🧬"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course Dashboard")),
      body: Center(
        child: _selectedIndex == 1
            ? ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(courses[index]["icon"]!),
              title: Text(courses[index]["name"]!),
              subtitle: Text("Instructor: ${courses[index]["instructor"]}"),
            );
          },
        )
            : _selectedIndex == 2
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile Page", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to exit the app?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Page", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text("Enroll in Course"),
              ),
            ),
            SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedCategory == "None" ? null : selectedCategory,
              hint: Text("Select Category"),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: ["Science", "Arts", "Technology"].map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text("Selected: $selectedCategory"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
