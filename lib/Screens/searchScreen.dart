
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Resources/FirebaseAuthenticationMethods.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:sadaeniswa/Widgets/CustomTiling.dart';

class SearchScreen extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<SearchScreen> {
  FirebaseAuthenticationRepository _authenticationRepository =
      new FirebaseAuthenticationRepository();
  List<UserModel> userList;

  String queryUser = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationRepository.getCurrentUser().then((FirebaseUser user) {
      _authenticationRepository
          .getAllUsersFromDB(user)
          .then((List<UserModel> list) {
        setState(() {
          userList = list;
        });
      });
    });
  }

  searchBar(BuildContext build) {
    return GradientAppBar(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.pinkAccent.shade700,
            Colors.pinkAccent.shade100,
            Colors.pinkAccent.shade400
          ]),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pushReplacementNamed(context, 'Screens/dashboard'),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.only(left: 100),
          child: TextField(
            controller: searchController,
            onChanged: (value){ setState(() {
              queryUser = value;
            });},
            cursorColor: Colors.white,
            autofocus: true,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear()),
                ),
                border: InputBorder.none,
                hintText: "Search User",
                hintStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }

  suggestionBuilder(String query) {
    final List<UserModel> suggestionList = query.isEmpty
        ? []
        : userList.where((UserModel user) {
           // String _getUserName = user.username.toLowerCase();
            String _getQuery = query.toLowerCase();
            String _getName = user.name.toLowerCase();
            //bool matchUserName = _getUserName.contains(_getQuery);
            bool matchesName = _getName.contains(_getQuery);

            return (matchesName);
          }).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        UserModel searchedUser = UserModel(
          uid: suggestionList[index].uid,
          email: suggestionList[index].email,
          state: suggestionList[index].state,
          status: suggestionList[index].status,
          profilePhoto: suggestionList[index].profilePhoto,
          name: suggestionList[index].name,

        );
return  CustomTile(
  mini: false,
  onTap: (){},
  leading: CircleAvatar(
    backgroundImage: NetworkImage(searchedUser.profilePhoto),
    backgroundColor: Colors.grey,
  ),
  title: Text(
    searchedUser.name,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold
    ),
  ),
subtitle: Text(
  searchedUser.name,
  style: TextStyle(color: Colors.green),
),
);

      }),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: searchBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: suggestionBuilder(queryUser),
      ),
    );
  }
}
