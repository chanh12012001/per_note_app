import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/user_preference.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/toast_service.dart';
import '../../login_screen.dart';
import '../input_field.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool enable = false;
  File? _image;
  UserPreferences userPreferences = UserPreferences();
  ToastService toast = ToastService();
  String _selectedSex = '';
  List<String> sexList = [
    'Nam',
    'Nữ',
    'Khác',
  ];

  @override
  void initState() {
    super.initState();

    _selectedSex = widget.user.sex!;
  }

  @override
  Widget build(BuildContext context) {
    String? name = widget.user.name;
    String? sex = widget.user.sex;
    String? email = widget.user.email;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Cá nhân',
          style: TextStyle(color: blackColor),
        ),
        actions: [
          enable
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      enable = false;
                    });
                    _updateUserInfo(
                        widget.user.userId, name, _selectedSex, email);
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      enable = true;
                    });
                  },
                  child: const Text(
                    'Sửa',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<User>(
          future: userPreferences.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // name = snapshot.data!.name;
            // sex = snapshot.data!.sex;
            // email = snapshot.data!.email;

            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imagePicker(
                            ImageSource.gallery,
                            widget.user.userId,
                          );
                        },
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: snapshot.data!.avatarUrl != null
                              ? NetworkImage(snapshot.data!.avatarUrl!)
                              : const AssetImage(
                                      'assets/images/photo_gallery.png')
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "ID: ${widget.user.userId!}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      InputField(
                        onChanged: (value) {
                          name = value;
                        },
                        enable: enable,
                        title: 'Tên',
                        hint: snapshot.data!.name!,
                      ),
                      InputField(
                        enable: false,
                        title: 'Số điện thoại',
                        hint: widget.user.phoneNumber!,
                      ),
                      InputField(
                        title: 'Giới tính',
                        hint: _selectedSex,
                        onChanged: (value) {
                          sex = value;
                        },
                        enable: false,
                        widget: enable == true
                            ? DropdownButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                iconSize: 32,
                                elevation: 4,
                                style: subTitleStyle,
                                underline: Container(height: 0),
                                onChanged: (String? value) {
                                  setState(() {
                                    sex = value;
                                    _selectedSex = value!;
                                  });
                                },
                                items: sexList.map<DropdownMenuItem<String>>(
                                    (String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value!,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  );
                                }).toList())
                            : null,
                      ),
                      InputField(
                        enable: enable,
                        onChanged: (value) {
                          email = value;
                        },
                        title: 'Email',
                        hint: snapshot.data!.email!,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "ĐĂNG XUẤT",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return MyAlertDialog(
                                title: 'Warning !!!',
                                subTitle: 'Thoát khỏi ứng dụng?',
                                action: () {
                                  userPreferences.removeUser();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      LoginScreen.routeName, (route) => false);
                                },
                              );
                            },
                          );
                          // loadingProvider.setLoading(false);
                        },
                        width: 1,
                      ),
                    ],
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ),
      ),
    );
  }

  _updateUserInfo(userId, name, sex, email) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    authProvider.updateUserInfo(userId, name, sex, email).then(
      (response) {
        toast.showToast(
          context: context,
          message: 'Cập nhật thành công',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
        setState(() {});
      },
    );
  }

  void imagePicker(ImageSource imageSource, userId) async {
    XFile? image = await ImagePicker().pickImage(source: imageSource);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      await authProvider.updateAvatar(userId, _image!);

      setState(() {});
    }
  }
}
