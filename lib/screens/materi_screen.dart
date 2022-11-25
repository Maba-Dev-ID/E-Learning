import 'package:e_learning/widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../theme/theme.dart';
import '../helper/helper_materi.dart';
import '../widget/dropdown_loading.dart';
import 'one_materi.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  String? chosenValue;
  bool isShowCategory = false;
  bool isVisible = false;
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var materiAll = Provider.of<MapelProvider>(context, listen: false);
    var theme = Theme.of(context);
    return Scaffold(
        appBar: appbarWidget(title: "Materi", context: context),
        floatingActionButton: FloatingActionButton(
          elevation: 3,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.primaryColor,
          onPressed: _scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
        body: SafeArea(
            child: ListView(
          controller: _scrollController,
          children: [
            FutureBuilder(
              future: materiAll.getMapel(chosenValue, 'all'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const LoadingDropdown();
                } else {
                  var data = snapshot.data;
                  List<DropdownMenuItem<String>> items = data
                      .map<DropdownMenuItem<String>>((item) =>
                          DropdownMenuItem<String>(
                              value: item.id,
                              child: Text(item.category,
                                  style: const TextStyle(color: kGreen))))
                      .toList();
                  return Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(26, 0, 0, 0),
                              offset: Offset(2, 5),
                              blurRadius: 4)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Pilih Mata Kuliah"),
                        menuMaxHeight: 250,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(15),
                        value: chosenValue,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            isShowCategory = true;
                            chosenValue = value;
                          });
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            if (!isShowCategory) MateriAll(materiAll: materiAll),
            if (isShowCategory)
              MateriAll(
                materiAll: materiAll,
                id: chosenValue,
              ),
          ],
        )));
  }
}

class MateriAll extends StatelessWidget {
  final MapelProvider materiAll;
  String? id;

  MateriAll({super.key, required this.materiAll, this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: materiAll.getMateri(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: kGreenPrimary, size: 40),
              ),
            ],
          );
        }
        var d = snapshot.data;
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: List.generate(
              snapshot.data.length,
              (index) => GestureDetector(
                onTap: () {
                  materiAll.validationMateri(
                      d[index]['id'].toString(), context);
                },
                child: Card(
                  color: kGreenPrimary,
                  margin: const EdgeInsets.only(
                      bottom: 6.0, right: 10.0, left: 5.0, top: 6.0),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        minVerticalPadding: 25,
                        title: Text(d[index]['mapel']['nama'],
                            maxLines: 2,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        subtitle: Text(d[index]['judul'],
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontSize: 16)),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              transLateday(d[index]['created_at'].toString()),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                            Text(showTimeAgo(d[index]['created_at'].toString()),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70,
                            ),
                            child: Text(
                              namaDosen(
                                  d[index]['kelas_mapel']['guru']['nama'],
                                  d[index]['kelas_mapel']['guru']
                                      ['gelar_belakang']),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OneMateriScreen(d[index]['id']
                                                    .toString())));
                                  },
                                  child: Text(
                                    "detail->",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
      },
    );
  }
}
