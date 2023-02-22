import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_chat_app/models/user_model.dart';
import 'package:first_chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class SearchScreen2 extends StatefulWidget {
  UserModel user;
  SearchScreen2(this.user);

  @override
  _SearchScreen2State createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  // TextEditingController searchController = TextEditingController();
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.home_outlined),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(widget.user)),
              (route) => false);
        },
      ),
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.teal,
        title: Card(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search for account",
              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<dynamic, dynamic>;
                    print(data);
                    if (name.isEmpty) {
                      return ListTile(
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['image']),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                name = "";
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    currentUser: widget.user,
                                    friendId: data['uid'],
                                    friendName: data['name'],
                                    friendImage: data['image'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.message)),
                      );
                    }
                    if (data['name'].toString().startsWith(name)) {
                      return ListTile(
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['image']),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                name = "";
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    currentUser: widget.user,
                                    friendId: data['uid'],
                                    friendName: data['name'],
                                    friendImage: data['image'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.message)),
                      );
                    }
                    return Container(
                        // child: Center(child: Text("nobody found")),
                        );
                  });
        },
      ),
    );
  }
}
