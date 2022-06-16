import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final messageController = TextEditingController();
  List<Map> messages = List.empty(growable: true);
  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/json/heathychatbot-ulhx-71b0a0b3b619.json")
        .build();
    DialogFlow dialogFlow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 218, 228, 243),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 205, 245),
        title: const Text("Chat bot"),
      ),
      body: Column(
        children: [
          // Center(
          //   child: Container(
          //     padding: EdgeInsets.only(top: 15, bottom: 10),
          //     child: Text(
          //       "Today, ${DateFormat("Hm").format(DateTime.now())}",
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // ),
          Container(
            height: isKeyBoard
                ? MediaQuery.of(context).size.height * 0.45
                : MediaQuery.of(context).size.height * 0.78,
            child: Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => chat(
                    messages[index]["message"].toString(),
                    messages[index]["data"]),
              ),
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
            child: ListTile(
              title: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: whiteColor,
                ),
                padding: const EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: "Enter a Message...",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  onChanged: (value) {},
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.blue,
                ),
                onPressed: () {
                  if (messageController.text.isEmpty) {
                    print("Empty");
                  } else {
                    setState(() {
                      messages.insert(
                          0, {"data": 1, "message": messageController.text});
                    });
                    response(messageController.text);
                    messageController.clear();
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chat(String mess, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/bot.png"),
                  ),
                )
              : Container(),
          Padding(
              padding: EdgeInsets.all(10),
              child: Bubble(
                radius: Radius.circular(15),
                color: data == 0
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 183, 214, 240),
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          mess,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              )),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/avt_default.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
