import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandora/helpers.dart';
import 'package:pandora/pages/pages.dart';
import 'package:pandora/widgets/glowing_action_button.dart';
import 'package:pandora/widgets/widgets.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ValueNotifier<int> pageIndex = ValueNotifier(0); //this is for change in index
  final ValueNotifier<String> appBarTitle = ValueNotifier("Messages");
  final pages = const [
      MessagesPage(),
      NotificationPage(),
      CallsPage(),
      ContactsPage(),
  ];

  final pagesTitle = const [
      "Messages", "Notifications", "Calls", "Contacts"
  ];
void onNavigationItemSelected(index){
  appBarTitle.value = pagesTitle[index];
    pageIndex.value = index;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
         title: 
       ValueListenableBuilder(valueListenable: appBarTitle, builder: (context,String text,_){
         return Text(text);
       },
      ),
      centerTitle: true,
      leadingWidth: 54,
      leading: Align(child: 
      IconBackground(icon: Icons.search, onTap:(){
        print("Implement Search");
      },),
      alignment: Alignment.centerRight,
      ),
      actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Avatar.small(url: Helpers.randomPictureUrl()),
         ),
      ],
      ),
     body:ValueListenableBuilder(valueListenable: pageIndex,
      builder:(context,int value, _){
        return pages[value];
      }),
     bottomNavigationBar: _BottomNavigationBar(onItemChange: onNavigationItemSelected,),
    );
  }

  
}

class _BottomNavigationBar extends StatefulWidget {
   const _BottomNavigationBar({
    Key? key, required this.onItemChange,
  }) : super(key: key);
  final ValueChanged<int> onItemChange;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
   var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemChange(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: brightness == Brightness.light? Colors.transparent:null,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top:16.0,left:8,right: 8),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             _NavigationBarItem(
               icon: CupertinoIcons.chat_bubble_2_fill,
               text: "messages",
               index: 0,
               isSelected: (selectedIndex == 0),
               onTap:handleItemSelected,),
             _NavigationBarItem(
               icon: CupertinoIcons.bell,
               text: "Notification",
               index: 1,
               isSelected: (selectedIndex ==1),
               onTap:handleItemSelected),
               GlowingActionButton(color: AppColors.secondary, icon: Icons.add, onPressed: (){}),
              //FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add)),
              _NavigationBarItem(
                icon: CupertinoIcons.phone,
                text: "Calls",
                index: 2,
                isSelected: (selectedIndex ==2),
                onTap: handleItemSelected),
              _NavigationBarItem(
                icon: CupertinoIcons.group,
                text: "Contacts",
                index: 3,
                isSelected: (selectedIndex ==3),
                onTap:handleItemSelected),
      
          ],
            ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.index,
    required this.text,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String text;
  final IconData icon;
  bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              //size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
