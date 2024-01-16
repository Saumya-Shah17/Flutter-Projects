import 'dart:async';
import 'package:flutter/material.dart';
void main()
{
  runApp(Home());
}
class Home extends StatelessWidget{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:hs(),
      ),
    );
  }
}
class hs extends StatefulWidget
{
  State<hs> createState()=> hs1();
}
class hs1 extends State<hs>
{
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => second()
            )
        )
    );
  }
  Widget build(BuildContext context)
  {
    return Container(
        color: Colors.yellow,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
class second extends StatefulWidget
{
  @override
  State<second> createState() => _sState();
}
class _sState extends State<second> {

  var a=TextEditingController();
  var t=true;
  var bar = "";
  var b=TextEditingController();
  final s=GlobalKey<FormState>();
  var m="";

  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text("Login Page"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
        ),
        body: Form(
          key:s,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent
              ),
              width: 350,
              height: 500,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Text("Enter Credentials",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(
                    height: 65,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: a,
                      validator: (val){
                        if(val!.isEmpty)
                        {
                          return "Email cannot be empty";
                        }
                        if(!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(val)){
                          return "Enter valid email";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter email id",
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (val){
                        if(val!.isEmpty)
                        {
                          return "Password cannot be empty";
                        }
                        if(val.length<8)
                        {
                          return "Must contain 8 characters";
                        }
                      },
                      controller: b,
                      obscureText: t,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  t=!t;
                                });
                              },
                              icon:Icon(t?Icons.visibility_outlined:Icons.visibility_off)),
                          hintText: "Enter password",
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            if(s.currentState!.validate())
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                                return third();
                              }));
                            }
                            else{
                              setState(() {
                                m='Error!!';
                              });
                            }
                          });
                        },
                        child: Text("Login",style: TextStyle(fontSize: 20),)),
                  ),
                  Text("$m",style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class third extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: screen1(),
    );
  }
}


class screen1 extends StatefulWidget{
  @override
  State<screen1> createState() => _screen1State();
}
class _screen1State extends State<screen1> {
  final dis = TextEditingController();
  var b = [];
  var a = [];
  final t = TextEditingController();
  var time;
  var timenow;
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.tealAccent,
        elevation: 20,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.teal,
        title: Text("TODO APP",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),),
      ),
      body: Center(child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.add_task),
            title: TextField(
              cursorColor: Colors.teal,
              decoration: InputDecoration(
                labelText: "Add Task",
                labelStyle: TextStyle(color: Colors.teal),
                border: InputBorder.none,
              ),
              controller: t,
            ),
            trailing: TextButton(
                onPressed: (){
                  setState(() {
                    a.add(t.text);
                    t.clear();
                  });
                }, child: Text("Add",style: TextStyle(color: Colors.teal),)
            ),
          ),

          Expanded(
            child: ListView.builder(
                itemCount: a.length,
                itemBuilder: (context, int  j){
                  return ListTile(
                    leading: Text("${j+1}",style: TextStyle(color: Colors.brown,fontSize: 25,fontWeight: FontWeight.bold),),
                    title:  Text.rich(
                      TextSpan(text: "",children: <InlineSpan>[
                        TextSpan(text: "${a[j]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blueGrey)),
                        //for date and time
                      ]
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.done,color: Colors.teal,),
                      onPressed: (){
                        setState(() {
                          b.add(a[j]);
                          a.remove(a[j]);
                        });
                      },
                    ),
                  );
                }),
          ),
          BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: (){
                      final t=SnackBar(content: Text("Already on Tasks Page"));
                      ScaffoldMessenger.of(context).showSnackBar(t);
                    },
                    icon: Icon(Icons.task)),
                IconButton(
                  icon: Icon(Icons.done_all),
                  onPressed: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Donescreen(arro:b);
                      }));
                    });
                  },
                ),
                IconButton(onPressed: (){
                  setState(() {
                    if(a.isNotEmpty || b.isNotEmpty) {
                      a = [];
                      b = [];
                    }
                    else{
                      final x=SnackBar(content: Text("No task available"));
                      ScaffoldMessenger.of(context).showSnackBar(x);
                    }
                  });
                },
                    icon: Icon(Icons.delete))
              ],
            ),
          )
        ],
      )),
    );
  }
}



class Donescreen extends StatefulWidget{
  var arro = [];
  Donescreen({required this.arro});
  @override
  State<Donescreen> createState() => _DoneState(comtask:arro);

}

class _DoneState extends State<Donescreen> {
  var comtask = [];
  _DoneState({required this.comtask});
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.tealAccent,
          elevation: 20,
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.teal,
          title: Text("TODO APP",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Center(child: Text("Completed Tasks ;)",style: TextStyle(fontSize: 28,color: Colors.amber),),),
              Expanded(child: ListView.builder(
                  itemCount: comtask.length,
                  itemBuilder: (context,int x){
                    return ListTile(
                      leading: Text("${x+1}",style: TextStyle(fontSize: 25,color: Colors.brown,fontWeight: FontWeight.bold),),
                      title: Text("${comtask[x]}",style: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.w500),),
                    );
                  })
              ),
              BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                        onPressed: (){
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.task)),
                    IconButton(
                      icon: Icon(Icons.done_all),
                      onPressed: (){
                        final s=SnackBar(content: Text("Already on completed"));
                        ScaffoldMessenger.of(context).showSnackBar(s);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


