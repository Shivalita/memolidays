import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class MemoriesComponent extends StatelessWidget {

  List<List<Souvenir>> allSouvenirs = souvenirsState.state.allSouvenirsList;
  List<Souvenir> memories = [
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/302769/pexels-photo-302769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/884979/pexels-photo-884979.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/291762/pexels-photo-291762.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
    // Post(
    //     postImage:
    //         "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
    //     title: "Vacances Rome"),
  ];

  List<Souvenir> buildSouvenirsList() {
    for (int i = 0; i < allSouvenirs.length; i++) {
      Souvenir souvenir = allSouvenirs[i][0];
      memories.add(souvenir);
    }
    return memories;
  }

  @override
  Widget build(BuildContext context) {
    bool isCategorySelected = (souvenirsState.state.selectedCategoryId != 0);
    print(isCategorySelected);

    buildSouvenirsList();

    return Container(
      child: souvenirsState.whenRebuilder(
      // initState: () => souvenirsState.setState((state) async => await state.getSouvenirsList(context)),
      onIdle: () => CircularProgressIndicator(),
      onWaiting: () => CircularProgressIndicator(),
      onError: (error) => Text(error.toString()),
      onData: () {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: memories.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/souvenir');
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image:
                                        NetworkImage(memories[i].thumbnails[0].path),
                                        // NetworkImage(memories[i].cover),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(memories[i].title),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
            }));
    }));
  }
}

  // final LocalSource localSource = LocalSource();
  // final Map<String, dynamic> idsMap = localSource.getUserIds();
  // final int userId = idsMap['memolidaysId'];

  // List<Souvenir> categorySouvenirs = await souvenirsState.state.getSouvenirsByCategory(context, categoryId, userId);
  // print(categorySouvenirs);

  // souvenirsState.setState((state) => state.selectedCategorySouvenirsList = categorySouvenirs);
  // print(souvenirsState.state.selectedCategorySouvenirsList);
  // // print(souvenirsState.state.selectedCategorySouvenirsList[0].title);
