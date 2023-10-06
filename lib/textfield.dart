import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {

  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  String username = "";
  String password = "";
  String payment = "";
  String date = "";

  List<String> items = [
    "Zahin.zami@gmail.com",
    "Zaheen.kenjian@gmail.",
    "PZK3759",
    "jayed@gmail.com",
    "jami@gmail.com",
    "bubalula"
  ];

  List<DropdownItem> itemslist = [
    DropdownItem("Select One", 0),
    DropdownItem("Bkash", 0),
    DropdownItem("Nagad", 0),
    DropdownItem("Rocket", 0),
    DropdownItem("Upay", 0),
  ];

  late DropdownItem? selectedDropdownItem;
  late DateTime? selectedDateTime;

  @override
  void initState() {
    selectedDropdownItem = itemslist[0];
    selectedDateTime = DateTime.now();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("This is an Example of Text Fields"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("This is a column",style: TextStyle(fontSize: 25),),
            const SizedBox(height: 20,),
            TypeAheadField(
                minCharsForSuggestions: 1,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: secondController,
                  decoration: const InputDecoration(
                    label: Text("Username"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                    ),
                  ),

                ),
                suggestionsCallback: (pattern){
                  List<String> matched = [];

                  for(int i = 0; i <items.length; i++) {
                    if(items[i].toLowerCase().contains(pattern.toLowerCase())) {
                      matched.add(items[i]);
                    }
                  }

                  return matched;

                },
                itemBuilder: (context, suggestion){
                  return Card(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(suggestion),
                  ));
                },
                onSuggestionSelected: (selectedVal){

                  secondController.text = selectedVal;
                  setState(() {

                  });

                },
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: firstController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                label: Text("Password"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<DropdownItem>(
                    value: selectedDropdownItem,
                    items: itemslist.map((DropdownItem item){
                      return DropdownMenuItem<DropdownItem>(
                          value: item,
                          child: Text(item.itemName),);
                    }).toList(),
                    onChanged: (selectedItem){
                      selectedDropdownItem = selectedItem;
                      setState(() {

                      });
                    }),
                ElevatedButton(
                    onPressed: () async {
                       selectedDateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1999),
                          lastDate: DateTime(2024));
                       setState(() {

                       });
                    },
                    child: Text("${selectedDateTime!.day}-${selectedDateTime!.month}-${selectedDateTime!.year}")),
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){

              username = "Username: ${secondController.text.trim()}";
              password = "Password: ${firstController.text.trim()}";
              payment = "Payment: ${selectedDropdownItem!.itemName}";
              date = "Date: ${selectedDateTime!.day}-${selectedDateTime!.month}-${selectedDateTime!.year}";

              setState(() {

              });
            },
              style: ButtonStyle(elevation: MaterialStateProperty.all(5)),
              child: const Text("Submit"),
            ),
            const SizedBox(height: 40,),
            Text(username, style: const TextStyle(
              fontSize: 40,
            ),),
            const SizedBox(height: 20,),
            Text(password, style: const TextStyle(
              fontSize: 40,
            ),),
            const SizedBox(height: 20,),
            Text(payment, style: const TextStyle(
              fontSize: 40,
            ),),
            const SizedBox(height: 20,),
            Text(date, style: const TextStyle(
              fontSize: 40,
            ),),
          ],
        ),
      ),
    );
  }
}

class DropdownItem{

  late String itemName;
  late int itemID;

  DropdownItem(this.itemName, this.itemID);

}
