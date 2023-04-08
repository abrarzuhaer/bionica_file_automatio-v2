import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  void sayHello() {
    print('Hello, my name is $name and I am $age years old.');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Test Data',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<String> questions = [
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
    'Question 5',
    'Question 6',
    'Question 7',
  ];

  final Map<String, List<String>> answers = {
    'Question 1': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 2': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 3': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 4': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 5': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 6': ['Answer 1', 'Answer 2', 'Answer 3'],
    'Question 7': ['Answer 1', 'Answer 2', 'Answer 3'],
  };

  final Map<String, String> selectedAnswers = {};

  void submitAnswers() async {
    // Get the user's home directory
    final Directory directory = await getApplicationDocumentsDirectory();
    // Create a new file in the documents directory
    final File file = File('${directory.path}/results.csv');

    // Convert the selected answers to a List<List<String>> for CSV export
    final List<List<String>> csvData = [
      ['Question', 'Selected Answer'],
      ...selectedAnswers.entries.map((entry) => [entry.key, entry.value]),
    ];

    // Write the CSV data to the file
    file.writeAsString(const ListToCsvConverter().convert(csvData));

    // Show a download link to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Results exported to ${file.path}'),
        action: SnackBarAction(
          label: 'Download',
          onPressed: () {
            // Use the platform-specific API to open the file
            Process.run('open', [file.path]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Test Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                final question = questions[index];
                final questionAnswers = answers[question]!;

                return Card(
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            question,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(),
                        ...questionAnswers.map(
                          (answer) => RadioListTile(
                            title: Text(answer),
                            value: answer,
                            groupValue: selectedAnswers[question],
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswers[question] = value!;
                              });
                            },
                          ),
                        )
                      ],
                    ));
              },
            ),
          ),
          ElevatedButton(
            onPressed: submitAnswers,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
