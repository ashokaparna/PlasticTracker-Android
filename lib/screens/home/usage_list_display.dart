import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:plastic_tracker/api_client/model/usage.dart';
import 'package:plastic_tracker/data/get_usage_list.dart';
import 'package:intl/intl.dart';
import 'package:plastic_tracker/shared/loading.dart';

class PlasticUsageList extends StatefulWidget {
  PlasticUsageList({
    Key key,
    this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;
  @override
  _PlasticUsageListState createState() => _PlasticUsageListState();
}

class _PlasticUsageListState extends State<PlasticUsageList> {

  Map<String,List<Usage>> dailyUsageList;
  void initState(){
    super.initState();
    _getUsage();
  }

  Future<void> _getUsage() async {
    var res = await getUsageList();
    setState(() {
      dailyUsageList = res;
    });
  }
  @override
  Widget build(BuildContext context) {
    return dailyUsageList == null ? Loading() : GroupListView(
      controller: widget.scrollController,
      sectionsCount: dailyUsageList.keys.toList().length,
      countOfItemInSection: (int section) {
        return dailyUsageList.values.toList()[section].length;
      },
      itemBuilder: (BuildContext context, IndexPath index) {
        Usage usage =
        dailyUsageList.values.toList()[index.section][index.index];
        return Card(
          shape: new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.grey, width: 0.3)
          ),
          elevation: 0.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Container(
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usage.category,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    "Weight  |  " +
                        usage.weight.toString() + "g", style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      groupHeaderBuilder: (BuildContext context, int section) {
        DateTime date = DateFormat('yyyy_M_d').parse(dailyUsageList.keys.toList()[section]);
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(DateFormat('MMMEd').format(date), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)));
      },
      separatorBuilder: (context, index) => SizedBox(height: 0),
      sectionSeparatorBuilder: (context, section) => SizedBox(height: 0),
    );

  }


}

