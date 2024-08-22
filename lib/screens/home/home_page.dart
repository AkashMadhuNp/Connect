  
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/cust_Category/add_Category.dart';
import 'package:first_project_app/customWidgets/cust_Category/custcategorycontainer.dart';
import 'package:first_project_app/customWidgets/custdialog.dart';
import 'package:first_project_app/customWidgets/usercontainer.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/categorymodel.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/calenderScreen/calender_screen.dart';
import 'package:first_project_app/screens/home/view_category.dart';
import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {


  List<TaskModel> todaysTasks = [];
  String currentDate = '';

  

    
    List <Widget> widgets=[];
    UserModel? user;

    @override
    void initState() {
      super.initState();
      _loadCurrentUser();
      _fetchTodaysTasks();
      CategoryFunction().currentUserCategory(userKey!);
      CategoryFunction().getCategory();
      
    }

    Future<void> _loadCurrentUser() async {
      userKey = await UserFunctions().getCurrentUserKey();
      if (userKey != null) {
        await UserFunctions().getUser();
        setState(() {});
      }
    }
bool _isLoading = false;

    Future<void> _fetchTodaysTasks() async {
  setState(() => _isLoading = true);
  try {
    await TaskFunctions().getCurrentUsertaskOnSelectedDay(DateTime.now());
    setState(() {
      todaysTasks = currentUserTaskOnSelecteDdayNotifier.value;
    });
  } catch (e) {
    
    print('Error fetching tasks: $e');
  } finally {
    setState(() => _isLoading = false);
  }
}

    @override
    Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      final isWeb = width > 600;
      return SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height,
              width: width,
              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow.shade100,
                    Colors.yellow.shade100,
                    Colors.yellow.shade100
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(20)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: userListNotifier,
                    builder: (BuildContext context, List<UserModel> userList, Widget?_) {
                      if (userKey == null || userList.isEmpty) {
                        return const Usercontainer(
                          text: "Hello User!",
                          img: '',
                          color: Colors.transparent,
                          items: [],
                        );
                      }
                      int index = int.parse(userKey!);
                      if (index < 0 || index >= userList.length) {
                        return const Usercontainer(
                          text: "Hello User!",
                          img: '',
                          color: Colors.transparent,
                          items: [],
                        );
                      }
                      return Usercontainer(
                        text: userList[index].name != null
                          ? 'Hello ${userList[index].name}'
                          : "Hello User!",
                        img: userList[index].userImage ?? '',
                        color: Colors.transparent,
                        items:const [],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),


                  Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Today's Tasks",
                    style: GoogleFonts.irishGrover(
                      color: Colors.orange,
                      fontSize:isWeb ? 25: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),


                if(isWeb)
                SizedBox(
                  height: 200,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: todaysTasks.isNotEmpty
                        ? todaysTasks.map((task) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                          Color.fromARGB(255, 232, 203, 249),
                                  Color.fromARGB(255, 252, 219, 205),
                                  Colors.blue.shade100
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            task.Tasktitle ?? '',
                                             style:GoogleFonts.irishGrover(
                                              fontSize: isWeb ? 30 : 20,
                                              fontWeight: FontWeight.w500,
                                              foreground: Paint()
                                                              ..shader = const LinearGradient(
                                                                colors: [Colors.blue, Colors.purple],
                                                              ).
                                                              createShader(
                                                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
                                                                )
                                          ),
                                          
                                          // Text(
                                          //   task.startTime ?? '',
                                          //   style: GoogleFonts.irishGrover(
                                          //     fontSize: 14.0,
                                          //   ),
                                          // ),
                                          ),
                                        ),
                  
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            task.startTime ?? '',
                                            style: GoogleFonts.irishGrover(
                                              fontSize: isWeb ? 20 : 14,
                                              color: Colors.grey.shade900,
                                              letterSpacing: 2
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList()
                        : [
                            Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        
                                        Colors.orange.shade100,
                                        Colors.orange.shade200
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No tasks scheduled',
                                      style: GoogleFonts.irishGrover(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 76, 61, 79)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                  ),
                ),

              if(!isWeb)

                SizedBox(
                  height: 100,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 100.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: todaysTasks.isNotEmpty
                        ? todaysTasks.map((task) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                          Color.fromARGB(255, 232, 203, 249),
                                  Color.fromARGB(255, 252, 219, 205),
                                  Colors.blue.shade100
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          task.Tasktitle ?? '',
                                           style:GoogleFonts.irishGrover(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ).
                    createShader(
                      const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
                      )
                                        ),
                                        
                                        // Text(
                                        //   task.startTime ?? '',
                                        //   style: GoogleFonts.irishGrover(
                                        //     fontSize: 14.0,
                                        //   ),
                                        // ),
                                        ),
                  
                                        Text(
                                          task.startTime ?? '',
                                          style: GoogleFonts.irishGrover(
                                            fontSize: 14.0,
                                            color: Colors.grey.shade900,
                                            letterSpacing: 2
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList()
                        : [
                            Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        
                                        Colors.orange.shade100,
                                        Colors.orange.shade200
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No tasks scheduled',
                                      style: GoogleFonts.irishGrover(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 76, 61, 79)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                  ),
                ),
                
        


                Divider(thickness: 2,),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.irishGrover(
                        color: Colors.orange,
                        fontSize: isWeb? 25 : 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

                  if(isWeb)


                  Expanded(
                    child: ValueListenableBuilder(
                    valueListenable: currentUserCategoryNotifier, 
                    builder: (context, categoryList, _){
                      CategoryFunction().currentUserCategory(userKey!);
                      onOptionSelected(categoryList);
                      return GridView(
                        shrinkWrap: false,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                          
                          children: [
                            ...widgets,
                           GestureDetector(
                                 onTap: () {
                                showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                return CustomDialogBox();
                                                },
                                            );
                                        },
                            child:  Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AddCategory(),
                            ),
                          )
                          ],
                          );

                    }
                    )
                    ),

                    if(!isWeb)
                    Expanded(
                    child: ValueListenableBuilder(
                    valueListenable: currentUserCategoryNotifier, 
                    builder: (context, categoryList, _){
                      CategoryFunction().currentUserCategory(userKey!);
                      onOptionSelected(categoryList);
                      return GridView(
                        shrinkWrap: false,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                          
                          children: [
                            ...widgets,
                           GestureDetector(
                                 onTap: () {
                                showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                return CustomDialogBox();
                                                },
                                            );
                                        },
                            child:  AddCategory(),
                          )
                          ],
                          );

                    }
                    )
                    ),

                    SizedBox(height: 10,),
                ]
              ),
            ),
          )),
        );
      
    }

void onOptionSelected(List<CategoryModel> list) {
  widgets = [];

  for (var element in list) {
    widgets.add(
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewCategory(category: element.categoryTitle),
            ),
          );
        },
        child: CustomCategoryContainer(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertBox(
                  text: "Are you sure you want to delete this category",
                  title: "Delete Category",
                  onpressedCancel: () {
                    Navigator.of(context).pop();
                  },
                  onpressedDelete: () async {
                    await CategoryFunction().deleteCategory(element.key).then((value) => Navigator.of(context).pop());
                  },
                  okText: "Delete",
                );
              },
            );
          },
          category: element.categoryTitle,
          text: SizedBox(
            width: 100,
            child: Text(
              element.categoryTitle,
              style: GoogleFonts.irishGrover(
                color: Colors.black,
                fontSize: 15,
                letterSpacing: 3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          text2: '',
          text3: '',
          //icon: element.categoryIcon != null ? _getIconData(element.categoryIcon!) : null,
          icon: Icons.tab,
        ),
      ),
    );
  }

  widgets.add(
    GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox();
          },
        );
      },
      child: AddCategory(),
    ),
  );
}


  //   IconData _getIconData(String iconDataString){
  //     switch (iconDataString) {
  //     case 'MaterialIcons-985232':
  //       return Icons.person_2_rounded;
  //     case 'MaterialIcons-983892':
  //       return Icons.monitor_heart_rounded;
  //     case 'MaterialIcons-61843':
  //       return Icons.location_on_outlined;
  //     case 'MaterialIcons-983751':
  //       return Icons.work_rounded;
  //     case 'MaterialIcons-58780':
  //       return Icons.shopping_cart;
  //     case 'MaterialIcons-58141':
  //       return Icons.home_work;
  //     case 'MaterialIcons-57632':
  //       return Icons.cake;
  //     case 'MaterialIcons-63364':
  //       return Icons.food_bank_rounded;
  //     case 'MaterialIcons-59445':
  //       return Icons.campaign_sharp;
  //     case 'MaterialIcons-63002':
  //       return Icons.card_giftcard_rounded;
  //     case 'MaterialIcons-62127':
  //       return Icons.play_circle_fill_outlined;
  //     case 'MaterialIcons-60757':
  //       return Icons.time_to_leave_sharp;
  //     case 'MaterialIcons-984157':
  //       return Icons.punch_clock_sharp;
  //     default:
  //       return Icons.tab;

  //   }
  // }


IconData _getIconData(String iconDataString) {
  final parts = iconDataString.split('-');
  if (parts.length == 2) {
    final fontFamily = 'MaterialIcons';
    final codePoint = int.parse(parts[1]);
    return IconData(codePoint, fontFamily: fontFamily, fontPackage: 'material_icons');
  } else {
    // Handle the case where the iconDataString is not in the expected format
    return Icons.tab;
  }
}

  initializeUserKey()async{
    String? currentkey = await UserFunctions().getCurrentUserKey();
    return currentkey;
  }


  initializeUser()async{
    UserModel? user = await UserFunctions().getCurrentUser(await initializeUserKey());
    return user;
  }

  }
