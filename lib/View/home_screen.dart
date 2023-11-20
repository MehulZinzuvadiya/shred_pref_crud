import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shred_pref_crud/Utils/sharedPreference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPrefDemo.sharedPrefDemo.readPref();
  }

  TextEditingController txtname = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Sharedpref Crud"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: SharedPrefDemo.sharedPrefDemo.readPref(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<String>? l1 = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: l1!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade100,
                        child: ListTile(
                          title: Text("${l1[index]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // SharedPrefDemo.sharedPrefDemo
                                    //     .deleteDataFromSharedPreferences(index);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      SharedPrefDemo.sharedPrefDemo
                                          .createpref();
                                      SharedPrefDemo.sharedPrefDemo.s1
                                          .add("hardik");
                                      setState(() {});
                                    });
                                  },
                                  icon: Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(20),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Insert Data",
                                  style: GoogleFonts.lato(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: txtname,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter title';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'enter title',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        SharedPrefDemo.sharedPrefDemo
                                            .createpref();
                                        SharedPrefDemo.sharedPrefDemo.s1
                                            .add(txtname.text);
                                        setState(() {});
                                        Navigator.of(context).pop();
                                        txtname.clear();
                                        txtmobile.clear();
                                      }
                                    },
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("Add")),
          ),
        ],
      ),
    ));
  }
}
