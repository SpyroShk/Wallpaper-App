import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getApiData();
  }

  List urlData = [];
  void getApiData() async {
    final url = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=kRkCaTUi1hwmiYRxTOyyGX_Bt-PWIh_BJKU4DBPe9o4");
    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
      // print(urlData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEE2),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leadingWidth: 60,
        // leading: IconButton(
        //     icon: SvgPicture.asset('assets/icons/Arrow left 1.svg'),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     }),
        title: const Text(
          'Wallpaper',
          style: TextStyle(
            color: Color(0xFF403B36),
            fontWeight: FontWeight.w900,
            fontSize: 50,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.more_vert_rounded,
        //       color: Color(0xFF403B36),
        //     ),
        //   ),
        //   const SizedBox(width: 10)
        // ],
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: urlData == null
            ? const CircularProgressIndicator()
            : MasonryGridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: urlData.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        child: Image.network(
                          urlData[index]['urls']['regular'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
