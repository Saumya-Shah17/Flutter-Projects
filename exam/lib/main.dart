import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main()
{
  runApp(Sam());
}
class Sam extends StatefulWidget
{
  State<Sam> createState() => s();
}
class s extends State<Sam>
{

  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(40)
          ),
          shadowColor: Colors.yellow,
          elevation: 20,
          title: Text("ToDo List"),
        ),
        body: ab(),
      ),
    );
  }
}
class ab extends StatefulWidget
{
  @override
  State<ab> createState() => _abState();
}

class _abState extends State<ab> {
  var a=[];
  var b=[];
  final t=TextEditingController();
  var chk=0;

  Widget build(BuildContext context)
  {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: Colors.red,
                        width: 5
                    )
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter a task to do',
                  ),
                  style: TextStyle(color: Colors.red,fontSize: 20),
                  controller: t,
                ),
              ),
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      shadowColor: Colors.red,
                      shape: CircleBorder()
                  ),
                  onPressed: (){
                    setState(() {
                      a.add(t.text);
                      t.clear();
                    });
                  }, child: Icon(Icons.add,size: 40,)),
            ),
          ],
        ),

        Expanded(
          child: ListView.builder(itemBuilder: (context,int i){
            return ListTile(
              leading: Text('${i+1}',style: TextStyle(color: Colors.red,fontSize: 20),),
              title: Text('${a[i]}',style: TextStyle(color: Colors.red,fontSize: 30),),
              trailing: ElevatedButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)
                    ),
                    backgroundColor: Colors.red
                ),
                onPressed: (){
                  setState(() {
                    chk=1;
                    b.add(a[i]);
                    a.remove(a[i]);
                  });
                },
                child: Icon(Icons.done_outline),
              ),
            );
          },
            itemCount: a.length,),
        ),
        TextButton(onPressed: (){
          setState(() {
            if(chk!=0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return done(b: b);
              }));
            }
            else
            {
              Fluttertoast.showToast(
                  msg: "No tasks done",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
          );
        }, child: Text("Done")),
        ElevatedButton(onPressed: (){
          setState(() {
            a=[];
            b=[];
            chk=0;
          });
        }, child: Icon(Icons.clear))
      ],
    );
  }
}
class done extends StatefulWidget
{
  var b=[];
  done({required this.b});
  State<done> createState() => d(b:b);
}
class d extends State<done>
{
  var b=[];
  d({required this.b});
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded,),
            onPressed: (){
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          title: Text("Task Done"),
        ),
        body: ListView.builder(itemBuilder: (context,int i){
          return ListTile(
            leading: Text('${i+1}',style: TextStyle(fontSize: 20),),
            title: Text("${b[i]}",style: TextStyle(fontSize: 30),),
          );
        },
          itemCount: b.length,),
      ),
    );
  }
}
