import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "model_class/to_do_model_class.dart";
import 'package:intl/intl.dart';

void main() => runApp(const MayApp());

class MayApp extends StatelessWidget {
  const MayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List listOfColor = const [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 249, 232, 1),
    Color.fromRGBO(250, 232, 250, 1),
  ];

  List<ToDoModelClass> listOftodoModelClass = [
    ToDoModelClass(
        title: "Lorem Ipsum is simply setting industry. ",
        description:
            "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
        date: "4 may 2000"),
  ];

  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  void save(bool todoedit, int? index) {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty) {
      if (!todoedit) {
        listOftodoModelClass.add(
          ToDoModelClass(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              date: _dateController.text.trim()),
        );
      } else {
        listOftodoModelClass[index!].title = _titleController.text.trim();
        listOftodoModelClass[index].description =
            _descriptionController.text.trim();
        listOftodoModelClass[index].date = _dateController.text.trim();
      }
      clearController();
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  void edit(bool todoedit, int index) {
    _titleController.text = listOftodoModelClass[index].title.toString();
    _descriptionController.text =
        listOftodoModelClass[index].description.toString();
    _dateController.text = listOftodoModelClass[index].date.toString();

    showBottomSheet(todoedit, index);
  }

  void remove(int? index) {
    listOftodoModelClass.removeAt(index!);
    setState(() {});
  }

  @override
  void dispose(){
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();

  }

  void showBottomSheet([bool todoedit = false, int? index]) {
    if (!todoedit) {
      _dateController.text = DateFormat.yMMMMd().format(DateTime.now()).trim();
      setState(() {});
    }

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Create Task",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, fontSize: 22)),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text("Title",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(0, 139, 148, 1))),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1)),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Description",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(0, 139, 148, 1))),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Date",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(0, 139, 148, 1))),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffix: const Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      )),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2025));

                    String formatdate = DateFormat.yMMMd().format(date!);
                    _dateController.text = formatdate.trim();
                    setState(() {});
                  },
                  keyboardType: TextInputType.none,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  save(todoedit, index);
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(0, 139, 148, 1))),
                child: Text("SAVE",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1))),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App",
        style: GoogleFonts.quicksand(
          fontWeight:FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 198, 211),
      ),
      body: ListView.builder(
          itemCount: listOftodoModelClass.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: listOfColor[index % listOfColor.length],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          spreadRadius: 1,
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  //offset:Offset(0,0
                                  blurRadius: 10,
                                  //spreadRadius:0,
                                  color: Color.fromRGBO(0, 0, 0, 0.07)),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "lib/image/picture.png",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${listOftodoModelClass[index].title}",
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: const Color.fromRGBO(0, 0, 0, 1)),
                              ),
                              const SizedBox(height: 10),
                              Text("${listOftodoModelClass[index].description}",
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          const Color.fromRGBO(84, 84, 84, 1))),
                            ]),
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          "${listOftodoModelClass[index].date}",
                          style: GoogleFonts.quicksand(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(132, 132, 132, 1)),
                        ),
                        const Spacer(),
                        Row(
                          //mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  edit(true, index);
                                },
                                child: const Icon(Icons.edit_outlined,
                                    size: 18,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                            const SizedBox(
                              width: 13,
                            ),
                            GestureDetector(
                                onTap: () {
                                  remove(index);
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                  color: Color.fromRGBO(0, 139, 148, 1),
                                ))
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet();
        },
        tooltip: " NEW ADD",
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 46,
        ),
      ),
    );
  }
}
