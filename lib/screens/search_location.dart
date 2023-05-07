import 'package:air_quality_app/api/location_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../widgets/places.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          "Add Location",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SearchInjector(
        child: SafeArea(
            child: Consumer<LocationApi>(
          builder: (_, api, child) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(224, 221, 224, 1),
                        hintText: "Search Location",
                        hintStyle: const TextStyle(
                            fontSize: 18, color: Colors.deepPurple),
                        suffixIcon: const Icon(
                          Icons.location_city,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 3.0),
                        ),
                      ),
                      onChanged: api.handleSearch,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(235, 231, 235, 1),
                    height: 400,
                    // ignore: deprecated_member_use
                    child: StreamBuilder<List<Place>>(
                        stream: api.controllerOut,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(child: Text("No Data Found"));
                          }
                          final data = snapshot.data;

                          return Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Container(
                                child: Builder(builder: (context) {
                                  return Column(
                                    children:
                                        List.generate(data!.length, (index) {
                                      final place = data[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          onTap: () async {
                                            List<Location> location =
                                                await locationFromAddress(
                                                    place.city);

                                            //***GET LONG AND LANG FROM HERE!!! ****/

                                            print(location.last.longitude);
                                            print(location.last.latitude);
                                          },
                                          title: Text(
                                            place.city,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                          subtitle: Text(
                                            "${place.state},${place.country}",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class SearchInjector extends StatelessWidget {
  final Widget child;

  const SearchInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationApi(),
      child: child,
    );
  }
}
