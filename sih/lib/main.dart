import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_flutter/qr_flutter.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Sam());
}
class Sam extends StatefulWidget
{
  State createState()=> sam();
}
class sam extends State<Sam>
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: s05(),
    );
  }
}
class s05 extends StatefulWidget
{
  @override
  State<s05> createState() => _s05State();
}
var b=TextEditingController();
class _s05State extends State<s05> {
  final s=GlobalKey<FormState>();
  var c=TextEditingController(),m="";
  var a=true;
  static String v="";
  void d()
  {
    c.dispose();
    b.dispose();
    super.dispose();
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Image.asset("assets/car.jpg",height: 400,width: 400,),
              SizedBox(height: 50,),
              Text("Phone verification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,),textAlign: TextAlign.left,),
              SizedBox(height: 20,),
              Text("Please enter your phone number to verify",style: TextStyle(fontSize: 17),),
              SizedBox(height: 50),
              Form(
                key:s,
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue
                        )
                    ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.red
                          )
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue
                        )
                    ),
                    prefixText: " +91  |  ",
                    prefixStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue
                      )
                    )
                  ),
                  keyboardType: TextInputType.phone,
                  controller: b,
                  validator: (val)
                  {
                    if(b.text.length!=10)
                      {
                        return "Enter valid phone number";
                      }
                  },
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: Colors.grey,
                  elevation: 10,
                  minimumSize: Size(50,55)
                ),
                  onPressed: () async{
                setState(() {
                  if(s.currentState!.validate()){
                    setState(() async{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+91"+b.text,
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          v=verificationId;
                          Navigator.push(context,MaterialPageRoute(builder: (context) {
                            return otp();
                          }));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    });
                  }
                });
              }, child: Text("Send OTP".toUpperCase(),style: TextStyle(fontSize: 25),))
            ],
          ),
      ),
    );
  }
}
class otp extends StatefulWidget
{
  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final FirebaseAuth auth=FirebaseAuth.instance;

  var o=TextEditingController();
  var f=0;

  Widget build(BuildContext)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Enter OTP"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  keyboardType: TextInputType.number,
                  controller: o,
                  validator: (f){
                    if(f==0)
                      return null;
                    else
                      {
                        setState(() {
                          o.clear();
                        });
                        return "OTP is incorrect";
                      }
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  length: 6,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  showCursor: true ,
                ),
                ElevatedButton(onPressed: () async {
                  try {
                    PhoneAuthCredential credential = PhoneAuthProvider
                        .credential(
                        verificationId: _s05State.v, smsCode: o.text);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return ver();
                    }));
                  }
                  catch(e)
                  {
                    f=1;
                  }
                }, child: Text("Verify"))
              ],
            ),
          ),
        ),
    );
  }
}
class ver extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          title: Text("Your unique ID"),
          centerTitle: true,
        ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              QrImageView(data: "+91"+b.text,size: 500,version: QrVersions.auto,)
            ],
          )
        ),
    );
  }
}
