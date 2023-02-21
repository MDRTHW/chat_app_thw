import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No user data found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()['email'] != widget.user.email) {
          searchResult.add(user.data() as Map);
          print(value.docs.length);
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for account '),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Account Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search_outlined),
                ),
              ],
            ),
            if (searchResult.length > 0)
              Expanded(
                  child: ListView.builder(
                      itemCount: searchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(searchResult[index]['image']),
                          ),
                          title: searchResult[index]['name'],
                          subtitle: searchResult[index]['email'],
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.message_outlined),
                          ),
                        );
                      }))
            else if (isLoading == true)
              Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}