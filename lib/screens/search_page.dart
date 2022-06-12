import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
              child: TextField(
                onChanged: (name) {
                  cityName = name;
                },
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  filled: true,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus() ;
                Navigator.pop(context,cityName);
              },
              child: Text('Get Weather'),
            )
          ],
        ),
      ),
    );
  }
}
