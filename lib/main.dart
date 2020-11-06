import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simple Interacting application",
        home: MyHome(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue,
          accentColor: Colors.green,
        ),
      ),
    );

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _currencies = ["Dinars", "Dollars", "Euros", "Rouble"];
  final _mininmumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principales = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController terms = TextEditingController();

  var display_result = '';
  var _formKey = GlobalKey<FormState>();

  // TextEditingController principales = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.display1;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("My Bank App"),
        centerTitle: true,
        elevation: 0.0,
        // backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              TextFormField(
                controller: principales,
                keyboardType: TextInputType.number,
                style: textstyle,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a valid price";
                  }
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: "Principles",
                  hintText: 'Enter Principal e.g. 1500',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: rate,
                keyboardType: TextInputType.number,
                style: textstyle,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a valid price";
                  }
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color:Colors.red,fontSize: 25.2),
                  labelText: "Rate of Interest",
                  hintText: 'In Persent',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: terms,
                      keyboardType: TextInputType.number,
                      style: textstyle,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please,Enter a valid parameter";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Terms",
                        hintText: 'Time in years',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemChange(newValueSelected);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: _mininmumPadding, top: _mininmumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorLight,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            this.display_result = _calculateTotal();
                          }
                          setState(() {
                            this.display_result = _calculateTotal();
                          });
                        },
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            _resetFunction();
                          });
                        },
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_mininmumPadding * 2),
                child: Text(
                  this.display_result,
                  style: textstyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownItemChange(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotal() {
    double principles = double.parse(principales.text);
    double get_rate = double.parse(rate.text);
    double get_term = double.parse(terms.text);

    double total_calculation =
        principles + (principles * get_rate * get_term) / 100;
    String result =
        'After $get_term years, your investment will be worth $total_calculation $_currentItemSelected';

    return result;
  }

  void _resetFunction() {
    principales.text = "";
    rate.text = "";
    terms.text = "";
    display_result = "";
    _currentItemSelected = _currencies[0];
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/rsb.jpg');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_mininmumPadding * 10),
    );
  }
}
