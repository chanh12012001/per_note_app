import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/colors.dart';
import 'package:per_note/config/dimens.dart';
import 'package:per_note/config/text_style.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/widgets/text_field_base.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        iconTheme: IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: Text(
          "Healthy ChatBot",
          style: TextStyleApp.interSemiBold_s16_w6_black1F1F1F.style,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: AppDimens.size10),
                color: AppColor.white_F6F6F6,
                height: isKeyBoard
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.78,
                child: messages.isNotEmpty
                    ? ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return chat(
                            messages[index]["message"].toString(),
                            messages[index]["data"],
                          );
                        })
                    : Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.pink_F2BEC8),
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.pink_FAE9E7,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icons/ic_welcome_chatbot.webp",
                                    width: AppDimens.size24,
                                  ),
                                  const SizedBox(width: AppDimens.size10),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Xin chào! Tôi là Chatbot, một trợ lý ảo có thể trả lời các câu hỏi liên quan đến nhiều loại bệnh. Tuy nhiên, tôi muốn nhắc lại rằng tôi chỉ là một chương trình máy tính và không thay thế được sự tư vấn y tế chuyên sâu. Đừng ngần ngại hỏi tôi về các triệu chứng, phương pháp chẩn đoán và điều trị thông thường, nhưng luôn nhớ tham khảo ý kiến của bác sĩ hoặc chuyên gia y tế để đảm bảo bạn nhận được thông tin chính xác và phù hợp với trạng thái sức khỏe của bạn.',
                                          style: TextStyleApp
                                              .interRegular_s14_w4_black1F1F1F
                                              .style
                                              .copyWith(height: 1.4),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              DateFormat("Hm")
                                                  .format(DateTime.now()),
                                              style: TextStyleApp
                                                  .interRegular_s12_w4_grey575757
                                                  .style),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const Divider(height: 1),
            Container(
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.size15),
              height: AppDimens.size70,
              color: AppColor.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppDimens.size5),
                      child: TextFieldBase(
                        controller: messageController,
                        hintText: 'Nhập tin nhắn...',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimens.size15),
                  IconButton(
                    icon: const Icon(Icons.send, size: 30, color: Colors.grey),
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        print("Empty");
                      } else {
                        setState(() {
                          messages.insert(0,
                              {"data": 1, "message": messageController.text});
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chat(String mess, int data) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/bot.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Bubble(
              radius: Radius.circular(8),
              color: data == 0 ? Colors.white : AppColor.pink_FAE9E7,
              borderColor:
                  data == 0 ? AppColor.grey_DDDDDD : AppColor.pink_F2BEC8,
              elevation: 0,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          mess,
                          style: TextStyleApp
                              .interRegular_s14_w4_black1F1F1F.style,
                        ),
                        const SizedBox(height: AppDimens.size5),
                        Text(DateFormat("Hm").format(DateTime.now()),
                            style: TextStyleApp
                                .interRegular_s10_w4_grey575757.style),
                      ],
                    ),
                  )),
            ),
          ),
          data == 1
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 30,
                  width: 30,
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
