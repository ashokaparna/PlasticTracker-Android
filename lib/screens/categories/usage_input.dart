import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/api_client/model/sub_category.dart';
import 'package:plastic_tracker/api_client/model/size.dart';
import 'package:plastic_tracker/api_client/model/usage.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:provider/provider.dart';

class PlasticInputUsage extends StatefulWidget {
  final Category category;
  final SubCategory subcategory;
  PlasticInputUsage({Key key, @required this.category, @required this.subcategory}) : super(key: key);
  @override
  _PlasticInputUsageState createState() => _PlasticInputUsageState(sizes: subcategory.sizes, subcategory: subcategory, category: category);
}

class _PlasticInputUsageState extends State<PlasticInputUsage> {
  Category category;
  SubCategory subcategory;
  List<Size> sizes;
  // ignore: unused_element
  _PlasticInputUsageState({Key key, @required this.sizes, this.category, this.subcategory});
  //var weightController = new TextEditingController();
  TextEditingController _w ;
  int count = 1;
  double weight = 0;
  String error = "";
  @override
  void initState() {
    _w = new TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _w?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return Scaffold(backgroundColor: Colors.blue.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.0),
          elevation: 0.0,
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop()
          ),
          title: Text('Usage Input'),
        ),
        body: Container(
          //padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if(sizes != null) plasticObjectSize(),
                addText('QUANTITY'),
                quantityInputField(),
                addText('GRAMS'),
                gramsInputField(),
                submitButton(user),
                displayErrorText(),
              ] ,
            )));
  }

  quantityInputField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: NumberInputWithIncrementDecrement(
        numberFieldDecoration: InputDecoration(
            fillColor: Colors.white,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        incIcon: Icons.add,
        decIcon: Icons.remove,
        decIconDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
          ),
        ),
        incIconDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
          ),
        ),
        controller: TextEditingController(),
        onDecrement: (val) => setState((){
          count = val;
        }),
        onSubmitted: (val) => setState((){
          count = val;
        }),
        onIncrement: (val) => setState((){
          count = val;
        }),
        buttonArrangement: ButtonArrangement.incRightDecLeft,
        incDecBgColor: Colors.white,
        initialValue: 1,
        min: 1,
        widgetContainerDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.white,
              width: 2,
            )),
      ),
    );
  }

  addText(String text) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, left:20.0,bottom: 20.0),
      child: Text(text,
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700)),
    );
  }

  gramsInputField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: NumberInputWithIncrementDecrement(
        numberFieldDecoration: InputDecoration(
            fillColor: Colors.white,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        incIcon: Icons.add,
        decIcon: Icons.remove,
        decIconDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
          ),
        ),
        incIconDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
          ),
        ),
        isInt: false,
        controller: _w,
        onDecrement: (val) => setState((){weight = val;}),
        onSubmitted: (val) => setState((){weight = val;}),
        onIncrement: (val) => setState((){weight = val;}),
        buttonArrangement: ButtonArrangement.incRightDecLeft,
        incDecBgColor: Colors.white,
        initialValue: 0,
        min: 0,
        widgetContainerDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.white,
              width: 2,
            )),
      ),
    );
  }

  plasticObjectSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addText('SIZE'),
        GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10,
            padding: EdgeInsets.only(left: 20.0,right:20.0, bottom:20.0),
            //childAspectRatio: 140.0 / 150.0,
            crossAxisCount: 4,
            children: List.generate(sizes.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      weight = sizes[index].weight;
                      _w.text = weight.toString();
                    });
                  },
                  child: Text(
                    sizes[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            })),
      ],
    );
  }

  submitButton(AppUser user){
    return Padding(
      padding: EdgeInsets.all(80.0),
      child: Center(
        child: Container(//color: Colors.white,
            width: 250.0,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)), ),
            child: TextButton(onPressed: () async {
              if(weight > 0){
                APIClient client = new APIClient(user);
                Usage usage = new Usage(category: category.name, weight: (weight*count));
                await client.addUsage(usage);
                Navigator.of(context).pop();
              }else{
                setState(() {
                  error = 'Enter a weight above 0';
                });
              }
            }, child: Text('Submit', style: TextStyle(fontSize: 18.0),))),
      ),
    );
  }

  displayErrorText() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0), textAlign: TextAlign.center,),
    );
  }
}