import 'package:flutter/material.dart';
import '../../../models/news_data_model.dart';
import 'package:provider/provider.dart';
import '../../../apis/news_api.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({
    Key? key,
    required this.newsData,
    required this.isFav,
  }) : super(key: key);

  final NewsDataModel newsData;
  final bool isFav;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool? newsFav;

  @override
  void initState() {
    newsFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height * 0.18,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              )
            ]),
        child: Row(
          children: [
            Container(
              // color: Colors.red,
              width: size.width * 0.2,
              child: Center(
                child: IconButton(
                  // color: Colors.amber,
                  icon: newsFav!
                      ? Icon(
                          Icons.favorite,
                          size: 35,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border_rounded,
                          size: 35,
                        ),
                  onPressed: () {
                    print("make me fav");
                    Provider.of<NewsAPI>(context, listen: false)
                        .toggleFavs(widget.newsData.id);
                    setState(() {
                      newsFav = !newsFav!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // news title
                    Container(
                      // color: Colors.red,
                      height: size.height * 0.045,
                      width: size.width * 0.7,
                      child: Text(
                        widget.newsData.title.length > 70
                            ? "${widget.newsData.title.substring(0, 70)}..."
                            : widget.newsData.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // news summary
                    Container(
                      // color: Colors.green,
                      width: size.width * 0.7,
                      height: size.height * 0.045,
                      child: Text(
                        widget.newsData.subtitle.length > 70
                            ? "${widget.newsData.subtitle.substring(0, 70)}..."
                            : widget.newsData.subtitle,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // news date
                    Container(
                      // color: Colors.amber,
                      height: size.height * 0.03,
                      width: size.width * 0.7,
                      child: Text(
                        "${widget.newsData.date}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
