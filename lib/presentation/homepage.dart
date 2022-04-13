import 'package:flutter/material.dart';
import 'package:untitled/data/data.dart';
import 'package:untitled/presentation/webview.dart';
import 'package:webfeed/domain/rss_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RssFeed? _feed;
  String _title = 'AlphaBank news';

  static const String loadingMessage = 'Loading Feed...';
  static const String feedLoadErrorMessage = 'Error Loading Feed.';

  late GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsPage(
              url: url,
            )));
  }

  load() async {
    updateTitle(loadingMessage);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMessage);
        return;
      }
      updateFeed(result);
      updateTitle("AlfaBank News");
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final file = await Data.tempFile;
      // Read the file
      String contents = await file.readAsString();
      return RssFeed.parse(contents);
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load();
  }

  isFeedEmpty() {
    return null == _feed || null == _feed?.items;
  }

  body() {
    return isFeedEmpty()
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  list() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                decoration: customBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Ссылка: " + _feed!.link!,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      "Описание: " + _feed!.description!,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      "RSS docs: " + _feed!.docs!,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    /*Text(
                      "Last Build Date: " + _feed!.lastBuildDate!,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: _feed!.items?.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _feed!.items?[index];
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  decoration: customBoxDecoration(),
                  child: InkWell(
                    child: ListTile(
                      title: title(item?.title),
                      subtitle: subtitle(item?.pubDate
                          .toString()
                          .substring(0, item!.pubDate.toString().length - 3)),
                      trailing: InkWell(
                        child: rightIcon(),
                        onTap: () => openFeed(item!.link!),
                      ),
                      contentPadding: const EdgeInsets.all(5.0),
                    ),
                    onTap: () => openFeed(item!.link!),
                  ),
                );
              },
            ),
          ),
        ]);
  }

  title(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: const TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  rightIcon() {
    return const Icon(
      Icons.keyboard_arrow_right,
      color: Colors.blue,
      size: 30.0,
    );
  }

  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.blue, // border color
        width: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(_title),
        ),
        body: body(),
      ),
    );
  }
}
