import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pooly_task/edu_email_validator.dart';

class RiderSignupScreen extends StatefulWidget {
  const RiderSignupScreen({Key? key}): super(key: key);

  @override
  State<RiderSignupScreen> createState() => _RiderSignupScreenState();

}

class _RiderSignupScreenState extends State<RiderSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Widget avatar = const CircleAvatar(
    child: Text("fotoğraf seç"),
    radius: 60,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  "assets/pooly-logo-transparent.png",
                  width: 200,
                  height: 200,
                ),
                Text('Yolcu Kayıt', 
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(height: 32,),
                GestureDetector(
                  onTap: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    final Widget newAvatar = CircleAvatar(
                      backgroundImage: MemoryImage(await image!.readAsBytes()),
                      radius: 60,
                    );
                    setState(() {
                      avatar = newAvatar;
                    });
                  },
                  child: avatar,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'İsim',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Soyisim',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Yaş',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Üniversite adı',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Üniversite bölümü',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Üniversite e-posta adresi',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (EduEmailValidator.validate(value)) {
                              return null;
                            } else {
                              return "Girilen e-posta adresi uygun değildir.";
                            }
                          },
                        )
                      ],
                    )
                  )
                ),
                ElevatedButton(
                  child: const Text("Kayıt ol!"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, "/rider");
                    }
                  },
                )
              ],
            )
          ),
        )
      )
    );
  }
}