import 'package:flutter/material.dart';
import 'package:library_app/screens/login.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:library_app/utils/database_helper.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  //Chart 01 data
  List<Map<DateTime,int>> chart01 = []; //thes valuues comes with sqflie
  List<Map<String,int>> chart02 = [];

  List<Chart01Details> temp01 = [];
  List<Chart02Details> temp02 = [];

  List<charts.Series<Chart02Details,String>> seriesPieData =[];
  List<charts.Series<Chart01Details, DateTime>> seriesLineData =[];
  
  _ChartState(){
      
  }

    @override
  void initState()  {
    
     _genaratePieData();
     super.initState();
    
  }

  _genaratePieData() async{
    Databasehelper databasehelper = Databasehelper();
    var chart02Data = await databasehelper.getAllChart02Details();
    var chart01Data = await databasehelper.getAllChart01Details();

    


    setState(() {
          seriesPieData = List<charts.Series<Chart02Details, String>>();
          seriesLineData = List<charts.Series<Chart01Details, DateTime>>();
    });
    //chart02 = await databasehelper.getAllChart02Details();

    for (var item in chart02Data) {
      Map<String,int> tempMap = Map();
      String lName = (item.values.toList())[1];  
      int numLib = (item.values.toList())[0];
      tempMap[lName] = numLib; 
      chart02.add(tempMap); 
    }  

    for (var item in chart01Data) {
      Map <DateTime,int> tempMap = Map();
      String date =(item.values.toList())[1]; 
      debugPrint('DAtee ::: '+date);
      int num = (item.values.toList())[0];
      debugPrint('Number ::: '+num.toString());
      var dateList = date.split(" ");
      int year;
      int month;
      int day;
      for (var item in dateList) {
        debugPrint('ABC :: '+item);
      }
      year = int.parse(dateList[0]);
      month = int.parse(dateList[1]);
      day = int.parse(dateList[2]);
      DateTime  dateTime = DateTime(year, month, day); 
      tempMap[dateTime] = num;

      Map <DateTime,int> tempMap1 = Map();
      DateTime d2 = DateTime(2020,05,31);
      tempMap1[d2]=212;
      
      chart01.add(tempMap);

    }
   

    for (var m in chart01) {
      var value = m.values.toList();
      int a = value[0];
      debugPrint('######################  : '+a.toString());
      var key = m.keys.toList();
      DateTime b =  key[0];
      debugPrint('********************    :'+b.toString());
      Chart01Details tempChart01 = Chart01Details(b,a);
      temp01.add(tempChart01);
    }




    for (var m in chart02) {
      var value = m.values.toList();
      int a = value[0];
      var key = m.keys.toList();
      String b =  key[0];
      Chart02Details tempChart02 = Chart02Details(b,a);
      temp02.add(tempChart02);
    }





    seriesPieData.add(
      charts.Series(
        id: 'aasas',
        data: temp02,
        domainFn: (Chart02Details c2,_)=>c2.libraryName,
        measureFn: (Chart02Details c2,_)=>c2.days,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        ),
    );


    seriesLineData.add(
      charts.Series(
        //colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: temp01,
        domainFn: (Chart01Details sales, _) => sales.date,
        measureFn: (Chart01Details sales, _) => sales.num,
      ),
    );
  }

  



  @override
  Widget build(BuildContext context) {
    return LoginForm.us.lid  == null ? Center(
      child: ListView(
        
        children: <Widget>[
          Text('Hiii Userrrr')
        ],
      ),
    ): ListView(
          children: <Widget>[
              Container(
                width: 200,
                height: 250,
                child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Number of Pages Reading',
                            style: 
                            TextStyle(
                              fontSize: 15.0,
                              color: Colors.blueGrey,
                              ),),
                        
                        Expanded(
                          child: charts.TimeSeriesChart(
                            seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: true),
                            animate: false,
                            animationDuration: Duration(seconds: 1),
                            /*
                             behaviors: [
                                new charts.RangeAnnotation([
                                    new charts.RangeAnnotationSegment(new DateTime(2017, 10, 4),
                                    new DateTime(2017, 10, 7), charts.RangeAnnotationAxisType.domain),
                                    ]),
                                  ]*/
                          ),
                        ),
                      ],
                    ),
                  ),),)
              ),
                Container(
                  padding: EdgeInsets.all(10),
                  child:Align(
                    alignment: Alignment.center,
                    child:  Text(
                    'Time spent on daily tasks',style: 
                            TextStyle(
                              fontSize: 15.0,
                              color: Colors.blueGrey,
                              ),),
                  ),

                ), 
                Container(
                  width: 200,
                  height: 350,
                  padding: EdgeInsets.all(12),
                  child: charts.PieChart(seriesPieData,
        
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        animate: true,
        
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()])),
                )
                
           
                      ],
                    
         
    );
  }
}

/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.


/////////////////////////////////////////

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    ); 
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class Chart01Details{
  DateTime date;
  int num;

  Chart01Details(this.date,this.num);
}


class  Chart02Details{
  String libraryName;
  int days;

  Chart02Details(this.libraryName,this.days);
}
