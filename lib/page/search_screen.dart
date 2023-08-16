import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/Model/newsModel.dart';
import 'package:provider/provider.dart';

import '../Controllers/News_provider.dart';
import '../const/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/empty_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  late final FocusNode focusNode;
  List<NewsModel> searchList = []; // Initialize with an empty list
  bool searching = false;
   List<String> searchKeywords = [
    "Football",
    "Flutter",
    "Python",
    "Weather",
    "Crypto",
    "Bitcoin",
    "Youtube",
    "Netflix",
    "Meta"
  ];
   String? searchText;
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchTextController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    newsProvider= Provider.of<NewsProvider>(context,listen: false);
    super.didChangeDependencies();
  }
late NewsProvider newsProvider;
  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      focusNode.unfocus();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                    ),
                  ),
                  Flexible(
                      child: TextField(
                    focusNode: focusNode,
                    controller: _searchTextController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                   onSubmitted: (value) {
                    setState(() {
                      searchText=value!;
                    });
                     _performSearch(value);
                   },

                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        bottom: 8 / 5,
                      ),
                      hintText: "Search",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: 
                        FloatingActionButton.small(heroTag: 'dssj',
                          onPressed: () {
                          _clearSearch();
                        },
                        child: Icon(IconlyLight.closeSquare),)
                      ),
                    ),
                  ))
                ],
              ),
            ),
            if (searchText==null && searchList.isEmpty)
              Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  itemCount: searchKeywords.length,
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: ()  {
                      _handleKeywordTap(searchKeywords[index]);
                    },
                      child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: color),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: FittedBox(child: Text(searchKeywords[index]))),
                          )),
                    );
                  },
                ),
              ),
            ), if (searchList.isEmpty && searching)
            EmptyNewsWidget(
              text: "Ops! No resuls found",
            ),
            if (searchList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: searchList[index],
                        child: const ArticlesWidget(),
                      );
                    }),
              ),
          ],
        )),
      ),
    );
  }
 void _performSearch(String value) async {
    if (_searchTextController.text.isNotEmpty) {
      searchList = await newsProvider.fetchAllSearchedNews(query: value!);

      setState(() {
        searching = true;
      });
    } else {
      setState(() {
        searchList.clear();
        searching = false;
      });
    }
  }
  void _clearSearch() {
    _searchTextController.clear();
    setState(() {
      searchText =null;
      searchList.clear();
      searching = false;
    });
  }
  void _handleKeywordTap(String keyword) async {
    searchList = await newsProvider.fetchAllSearchedNews(query: keyword);
    searching = true;
    focusNode.unfocus();
    _searchTextController.text = keyword;
    setState(() {});
  }

}
