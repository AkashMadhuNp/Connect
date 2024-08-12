  
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/cust_Category/add_Category.dart';
import 'package:first_project_app/customWidgets/cust_Category/custcategorycontainer.dart';
import 'package:first_project_app/customWidgets/custdialog.dart';
import 'package:first_project_app/customWidgets/usercontainer.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/categorymodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/home/view_category.dart';
import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {


    final List<String> names = ['Akash', 'Madhu', 'NP'];
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

    
    List <Widget> widgets=[];
    UserModel? user;

    @override
    void initState() {
      super.initState();
      _loadCurrentUser();
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

    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              
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
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),



                CarouselSlider(
          items: names.map((name) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                     gradient: LinearGradient(
            colors: [
              Colors.orange.shade100,
           Colors.orange.shade300,
           Colors.orange.shade100
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft
            ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: GoogleFonts.irishGrover(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 100.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        SizedBox(height: 10,),


        Divider(thickness: 3,),


                // CarouselSlider.builder(
                //   itemCount: (categories.length / 3).ceil(),
                //   itemBuilder: (context, index, realIndex) {
                //     int startIndex = index * 3;
                //     return Row(
                //       children: List.generate(3, (rowIndex) {
                //         int categoryIndex = startIndex + rowIndex;
                //         if (categoryIndex < categories.length) {
                //           return Expanded(
                //             child: CategoryCard(category: categories[categoryIndex]),
                //           );
                //         } else {
                //           return Expanded(child: Container());
                //         }
                //       }),
                //     );
                //   },
                //   options: CarouselOptions(
                //     height: 200,
                //     viewportFraction: 1.0,
                //     enlargeCenterPage: false,
                //     autoPlay: true,
                //     autoPlayInterval: Duration(seconds: 3),
                //     autoPlayAnimationDuration: Duration(milliseconds: 800),
                //     autoPlayCurve: Curves.fastOutSlowIn,
                //   ),
                // ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.irishGrover(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),


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
                ],
              ),
            ),
          ),
        ),
      );
    }



    void onOptionSelected(List<CategoryModel> list){
      widgets =[];

      for(var element in list){
        widgets.add(
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewCategory(category: element.categoryTitle),));
            },
            child: CustomCategoryContainer(
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (context){
                    return CustomAlertBox(
                      text: "Are you sure you want to delete this category", 
                      title: "Delete Category", 
                      onpressedCancel: () {
                        Navigator.of(context).pop();
                        },
                      onpressedDelete: () async{
                        await CategoryFunction().
                        deleteCategory(element.key).
                        then((value)=>Navigator.of(context).pop()
                        );
                        
                      }, okText: "Delete");
                  } );
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
              icon: element.categoryIcon != null
              ? _getIconData(element.categoryIcon!)
              :null,
            ),
          )
        );
      }
      
    }



    IconData _getIconData(String iconDataString){
      switch (iconDataString) {
      case 'MaterialIcons-985232':
        return Icons.person_2_rounded;
      case 'MaterialIcons-983892':
        return Icons.monitor_heart_rounded;
      case 'MaterialIcons-61843':
        return Icons.location_on_outlined;
      case 'MaterialIcons-983751':
        return Icons.work_rounded;
      case 'MaterialIcons-58780':
        return Icons.shopping_cart;
      case 'MaterialIcons-58141':
        return Icons.home_work;
      case 'MaterialIcons-57632':
        return Icons.cake;
      case 'MaterialIcons-63364':
        return Icons.food_bank_rounded;
      case 'MaterialIcons-59445':
        return Icons.campaign_sharp;
      case 'MaterialIcons-63002':
        return Icons.card_giftcard_rounded;
      case 'MaterialIcons-62127':
        return Icons.play_circle_fill_outlined;
      case 'MaterialIcons-60757':
        return Icons.time_to_leave_sharp;
      case 'MaterialIcons-984157':
        return Icons.punch_clock_sharp;
      default:
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
