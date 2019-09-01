import 'package:flutter/material.dart';
import 'dart:async';
import 'src/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main()
{
  runApp(homePage());
}
 
class homePage extends StatefulWidget {
  

 createState() => homePageState();
}
double total  = 0;
List<transaction> list =[
    transaction('New Shoes ',99.99)];
class homePageState extends State<homePage> {
  
  final commodity=TextEditingController();
  final amount = TextEditingController();
 // final firebase = Firestore.instance.collection("Expenses").document();
  Widget updateListView(TextEditingController text,TextEditingController amount)
   {
     setState((){
      
      
       list.add(transaction(text.text,double.parse(amount.text)));
       //updateDatabase(text.text,double.parse(amount.text));
       total=total+double.parse(amount.text);
     });
   }
  //  Future<void>  updateDatabase(item,price)async{
  //     await firebase.setData({
  //        'Item ':'$item',
  //        'amount':'$price'
  //      });
  //  }
   Widget addTransaction()
    {
      return Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           
           
           SizedBox(
             height: 20.0,
           ),
           Padding(
             padding: EdgeInsets.all(20.0),
             child: Text('Add Transaction',style: TextStyle(fontSize: 20.0,
           color: Colors.purple),),
           ),
           
           
           TextField(
             
             decoration: InputDecoration(
               labelText: 'Commodity'
             ),
             controller: commodity,
             onSubmitted: (_)
             {
               submit(commodity,amount);
             },
           ),
           TextField(
             keyboardType: TextInputType.number,
             decoration: InputDecoration(
               labelText: 'Amount'
             ),
             controller: amount,
             onSubmitted: (_){
               submit(commodity,amount);
               },
           ),
           RaisedButton(
             child: Text('Add'),
             
             onPressed: (){submit(commodity, amount);},
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
           ),

         ],
       );

    }
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.update),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (_){
                return addTransaction();
              }
            );
            })
        ],),
        
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
             width: double.infinity,
             height: 70.0,
             margin: EdgeInsets.all(20),
             decoration: BoxDecoration(
               border: Border.all(
                 color: Colors.purple,
                 
               ),
             ),
             alignment: Alignment.center,
             child: Text('Total Expense :\$${total}',style: TextStyle(fontSize:30.0 ,color: Colors.purple ),),
           ),
            // addTransaction(),
        Container(
          width: double.infinity,
          height:350.0,
          child: ListView.builder(
      itemCount:list.length ,
      itemBuilder: (context,index){
        return  Card(
          elevation: 6.0,
          child:ListTile(
            leading: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple,)
              ),
              width: 70.0,
              height: 100.0,
              margin: EdgeInsets.only(top: 6),
              alignment: Alignment.center,
            
              // padding: EdgeInsets.all(15.0),
              
              child: Text('\$${list[index].amount}',style: TextStyle(color: Colors.purple),),
            ),
            
            title: Text('${list[index].text}'),
            subtitle: Text('${DateTime.now()}'),
          ),

        );
        
        
      },
    )
        ),
          
      ],
    )
    ,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: button(updateListView),
      )
    );
    
  }
  void submit(commodity,amount)
      {
       setState(() {
        list.add(transaction(commodity.text, double.parse(amount.text))); 
        total=total+double.parse(amount.text);
        print('ok${commodity.text}');
        
       
       });
      }
 
}
class button extends StatelessWidget{
   final commodity=TextEditingController();
  final amount = TextEditingController();
  Function addtx;
  button(this.addtx);
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: (){
        showModalBottomSheet(
          context: context,
          builder: (_){
             return addTrans();
            
          }
        );
      },
    ); 
    }
   Widget addTrans()
     {
       return Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           SizedBox(
             height: 20.0,
           ),
           Padding(
             padding: EdgeInsets.all(20.0),
             child: Text('Add Transaction',style: TextStyle(fontSize: 20.0,
           color: Colors.purple),),
           ),
           
           
           TextField(
             
             decoration: InputDecoration(
               labelText: 'Commodity'
             ),
             controller: commodity,
            //  onSubmitted: (_){submit(commodity,amount);},
           ),
           TextField(
             keyboardType: TextInputType.number,
             decoration: InputDecoration(
               labelText: 'Amount'
             ),
             controller: amount,
            //  onSubmitted: (_){submit(commodity,amount);},
           ),
           RaisedButton(
             child: Text('Add'),
             
             onPressed: (){addtx(commodity, amount);},
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
           ),
         ],
       );
     }
    //  void submit(commodity,amount)
    //   {
    //    setState(() {
    //     list.add(transaction(commodity.text, double.parse(amount.text))); 
    //     total=total+double.parse(amount.text);
    //     print('ok${commodity.text}');
        
       
    //    });
    //   }
}