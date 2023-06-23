import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/screens/widgets/task_to_do/add_new_task.dart';
import 'package:per_note/screens/widgets/task_to_do/task_to_do.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  const CategoryScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CategoryScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              "Loại công việc",
              style: headingStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: FutureBuilder<List<Category>>(
                  future: categoryProvider.getCategoriesList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.hasError}");
                    }
                    return snapshot.hasData
                        ? GridView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) =>
                                index == snapshot.data!.length
                                    ? AddNewTask(
                                        reload: reload,
                                      )
                                    : TaskToDo(
                                        category: snapshot.data![index],
                                        reload: reload,
                                      ))
                        : const Center(
                            child: ColorLoader(),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> reload() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Việc cần làm'),
        content: Text('Thành công'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    return "";
  }
}
