import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyProject());
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Tekrar"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: TextFormFieldKullanimi(),
    );
  }
}

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String _email, _password, _userName;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          //validate işlemini ne zaman çalıştıracağını belirler.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //TextEditingController a ihtiyaç duymaz çünkü onSaved vardır
              TextFormField(
                onSaved: (gelenUserName) {
                  _userName = gelenUserName!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "yusufberkezengin",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Kullanıcı adı",
                  hintText: "Username",
                  border: OutlineInputBorder(),
                  // errorBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  // ),
                ),
                validator: (gelenUserName) {
                  if (gelenUserName!.isEmpty) {
                    return "Kullanıcı adı boş olamaz";
                  }
                  if (gelenUserName!.length < 4) {
                    return "5 karakterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(height: 10),
              TextFormField(
                onSaved: (gelenMail) {
                  _email = gelenMail!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "yusufberkezengin",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  // errorBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  // ),
                ),
                validator: (girilenEmail) {
                  if (!EmailValidator.validate(girilenEmail!)) {
                    return "Geçerli bir emaili giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (gelenSifre) {
                  _password = gelenSifre!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "yusufberkezengin",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Şifre",
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  // errorBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  // ),
                ),
                validator: (gelenPass) {
                  if (gelenPass!.isEmpty) {
                    return "Şifre boş olamaz";
                  }
                  if (gelenPass.length < 6) {
                    return "Şifre 6 haneden küçük olamaz";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),
              SizedBox(
                height: 55,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    //validate tamamlandı mı kontrol etmek için
                    bool _isValidate = _formkey.currentState!.validate();
                    if (_isValidate) {
                      //textformdield dan gelen verielri kaydetme işlemi
                      _formkey.currentState!.save();
                      String result =
                          "username: $_userName\nŞifre: $_password\nEmail: $_email";
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(result)));

                      //save işlemi tamamlandıktan sonra textformieldları temizler
                      _formkey.currentState!.reset();
                    }
                  },
                  child: Text("Onayla"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.green, width: 3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() =>
      _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {
  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;

  @override
  void initState() {
    super.initState(); //önce bunun oluşması için
    _emailController = TextEditingController(
      // text: "yusufberke1906@gmail.com",
    ); //bunu alta koyarız
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
      });
    });
  }

  @override
  void dispose() {
    _emailController
        .dispose(); //Önce bunu kapatmak istediğimiz için öne koyduk super.dispose() önüne koyduk
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,

            //Seçili gelme olayı
            autofocus: true,
            //Satır sayısı
            maxLines: maxLineCount,
            //Girilecek karakter sayısı (TC)
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefixIcon: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger) {},
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca
            onSubmitted: (String gelenDeger) {},
          ),
        ),
        TextField(),
      ],
    );
  }
}
