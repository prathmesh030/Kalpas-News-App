import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/news_data_model.dart';
import '../../apis/news_api.dart';
import './components/news_item.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSelectedMenu = true;

  void selectMenu() {
    setState(() {
      isSelectedMenu = !isSelectedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: isSelectedMenu
            ? FutureBuilder(
                future: Provider.of<NewsAPI>(context, listen: false)
                    .fetchNewsFromAPI(),
                builder: (ctx, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapShot.error != null) {
                    return Center(
                      child: Text("Something Went Wrong!"),
                    );
                  } else {
                    return Consumer<NewsAPI>(builder: (ctx, newsData, _) {
                      return Container(
                        height: size.height * 0.9,
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return NewsItem(
                              newsData: newsData.lsOfNews[i],
                              isFav: newsData.favNewsId
                                  .contains(newsData.lsOfNews[i].id),
                            );
                          },
                          itemCount: newsData.lsOfNews.length,
                        ),
                      );
                    });
                  }
                })
            : Consumer<NewsAPI>(builder: (ctx, newsData, _) {
                return Container(
                  height: size.height * 0.9,
                  child: newsData.favNewsId.length > 0
                      ? ListView.builder(
                          itemBuilder: (context, i) {
                            return NewsItem(
                              newsData: newsData.favNewsList[i],
                              isFav: newsData.favNewsId
                                  .contains(newsData.favNewsList[i].id),
                            );
                          },
                          itemCount: newsData.favNewsId.length,
                        )
                      : Center(
                          child: Text("No Favourite News Yet!"),
                        ),
                );
              }),
        bottomNavigationBar: Container(
          // color: Colors.red,

          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          width: size.width,
          height: size.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomNavBtn(
                btnIcon: Icons.list,
                btnText: "News",
                txtColor: isSelectedMenu ? Colors.white : Colors.black,
                bgColor: isSelectedMenu
                    ? Color.fromRGBO(0, 0, 139, 1)
                    : Colors.white,
                iconColor: isSelectedMenu ? Colors.white : Colors.black,
                changeScreen: selectMenu,
              ),
              bottomNavBtn(
                btnIcon: Icons.favorite,
                btnText: "Favs",
                txtColor: !isSelectedMenu ? Colors.white : Colors.black,
                bgColor: !isSelectedMenu
                    ? Color.fromRGBO(0, 0, 139, 1)
                    : Colors.white,
                iconColor: !isSelectedMenu ? Colors.white : Colors.red,
                changeScreen: selectMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class bottomNavBtn extends StatelessWidget {
  const bottomNavBtn({
    Key? key,
    required this.btnText,
    required this.btnIcon,
    required this.bgColor,
    required this.iconColor,
    required this.txtColor,
    required this.changeScreen,
  }) : super(key: key);

  final String btnText;
  final Color bgColor;
  final IconData btnIcon;
  final Color iconColor;
  final Color txtColor;
  final Function changeScreen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print("on change screen");
        changeScreen();
      },
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.49,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              btnIcon,
              color: iconColor,
              size: 40,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              btnText,
              style: TextStyle(
                  color: txtColor, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
