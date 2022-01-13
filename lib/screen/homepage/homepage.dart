import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos/components/expandable_sidenav.dart';
import 'package:pos/screen/homepage/items_grid_view.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/model/item.dart';
import 'package:pos/screen/homepage/sortedList/sorted_itemsgridview.dart';
import 'package:pos/screen/reciept/reciept_screen.dart';
import 'package:pos/screen/settings.dart';
import 'package:pos/utils/addtocartanimation/add_to_cart_animation.dart';
import 'package:pos/utils/addtocartanimation/add_to_cart_icon.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/main_screen/sidemenu.dart';
import 'package:pos/controller/sidenav_controller.dart';
import 'package:provider/provider.dart';
import '../add_customer.dart';
import '../item/itemlist_screen.dart';
import '../item/ticketedit_screen.dart';
import '../notification/notification.dart';
import '../notificationcreditors/dropdownnotificationcrediotrs.dart';
import 'items_listview.dart';
import 'localwidget/ticket_container.dart';
import 'sortedList/soreted_itemslistview.dart';

class MenuOptions {
  String title;
  IconData icon;
  MenuOptions({required this.title, required this.icon});
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  final List<String> items = [
    'All Items',
    'Discount',
    'Drinks',
    'Snacks',
    'Alcohol'
  ];
  final List<MenuOptions> menuOptions = [
    MenuOptions(title: 'Menu', icon: Icons.fastfood),
    MenuOptions(title: 'Bills', icon: Icons.line_style),
    MenuOptions(title: 'Items', icon: Icons.list),
    MenuOptions(title: 'Creditors', icon: Icons.credit_card),
    MenuOptions(title: 'Notifications', icon: Icons.notifications),
    MenuOptions(title: 'Settings', icon: Icons.settings),
    MenuOptions(title: 'Apps', icon: Icons.app_settings_alt),
    MenuOptions(title: 'Help', icon: Icons.help)
  ];
  String dropdownValue = 'All Items';

  double sidebarPanelWidth = 60.0;
  bool tapped = false;
  bool isSearchOpen = false;

  TextEditingController _controller = TextEditingController();
  bool isvisible = false;
  late FocusNode myfocusnode;
  int searchflex = 1;
  int itemsFlex = 4;
  late Future<List<Item>> futureItem;

//animation for
  GlobalKey<CartIconKey> gkItem = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  @override
  void initState() {
    super.initState();
    futureItem =
        Provider.of<ItemsController>(context, listen: false).fetchItems();
    myfocusnode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myfocusnode.dispose();
  }

  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    List optionItems = Provider.of<SettingController>(context).optionItems;
    final List<PopupMenuItem> _popUpOptions = optionItems
        .map(
          (item) => PopupMenuItem(
            value: item,
            child: Text(item),
          ),
        )
        .toList();
    return AddToCartAnimation(
      gkItem: gkItem,
      rotation: true,
      dragToCardCurve: Curves.easeInOut,
      dragToCardDuration: const Duration(milliseconds: 500),
      previewCurve: Curves.linearToEaseOut,
      previewDuration: const Duration(milliseconds: 500),
      previewHeight: 30,
      previewWidth: 30,
      opacity: 0.85,
      initiaJump: false,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        key: Provider.of<SideNavController>(context, listen: false).scafoldKey,
        appBar: selectedIndex == 0
            ? AppBar(
                titleSpacing: 10,
                elevation: 0,
                excludeHeaderSemantics: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () => (media.width < 600)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCustomer(),
                                    ),
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            width: 600,
                                            height: 800,
                                            child: AddCustomer(),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                            child: Icon(Icons.person_add_alt_1_sharp)),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          itemBuilder: (context) => _popUpOptions,
                          onSelected: (val) {
                            if (val.toString() == 'Grid View' ||
                                val.toString() == 'List View') {
                              Provider.of<SettingController>(context,
                                      listen: false)
                                  .changeLayout();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                toolbarHeight: 80,
                title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TicketEditScreen(),
                    ));
                  },
                  child: Row(
                    children: [
                      Text(
                        'Ticket',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/Ticket White.svg',
                            color: Colors.black,
                            height: 36,
                            width: 27,
                          ),
                          Positioned(
                            key: gkItem,
                            child: Text(
                              '${Provider.of<ItemsController>(context).ticketList.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            top: 8,
                            left: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
            : AppBar(
                title: Text(
                  menuOptions[selectedIndex].title,
                  style: TextStyle(color: Colors.black),
                ),
              ),
        body: Builder(
          builder: (context) {
            switch (selectedIndex) {
              case 0:
                return newHome(media);
              case 1:
                return RecieptScreen();
              case 2:
                return ItemListScreen();
              case 3:
                return DropdownNotificationCreditor();
              case 4:
                return AddNotification();
              case 5:
                return Settings();
              case 6:
                return Center(child: Text('App'));
              case 7:
                return Center(child: Text('Help'));
              default:
            }
            return Container();
          },
        ),
        drawer: SideMenu(
          onNavIndexChanged: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIndex: selectedIndex,
          menuOptions: menuOptions,
        ),
      ),
    );
  }

  Row newHome(Size media) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              (media.width < 600)
                  ? Container(
                      margin: EdgeInsets.all(25),
                      child: TicketContainer(),
                    )
                  : Container(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                decoration: (media.width > 600)
                    ? BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x55d3d3d3),
                          offset: Offset(0, 5),
                        )
                      ])
                    : BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: kDefaultBackgroundColor,
                          width: 3,
                        ),
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (media.width > 600)
                        ? IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                if (tapped == false) {
                                  sidebarPanelWidth = sidebarPanelWidth + 60;
                                }

                                if (tapped == true) {
                                  sidebarPanelWidth = sidebarPanelWidth - 60;
                                }
                                tapped = !tapped;
                              });
                            })
                        : Container(),
                    Visibility(
                      visible: (media.width < 600) ? !isvisible : true,
                      child: Expanded(
                        flex: (media.width < 920 && media.width > 600)
                            ? 4
                            : (media.width < 600)
                                ? itemsFlex
                                : 1,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              // isExpanded: true,
                              value: dropdownValue,
                              icon: Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.arrow_drop_down),
                                ),
                              ),
                              iconSize: 35,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                                if (dropdownValue.contains('All Items')) {
                                  Provider.of<ItemsController>(context,
                                          listen: false)
                                      .filterAll();
                                } else if (dropdownValue.contains('Discount')) {
                                  Provider.of<ItemsController>(context,
                                          listen: false)
                                      .filterDiscount();
                                } else if (dropdownValue.contains('Drinks')) {
                                  Provider.of<ItemsController>(context,
                                          listen: false)
                                      .filterDrinks();
                                } else if (dropdownValue.contains('Snacks')) {
                                  Provider.of<ItemsController>(context,
                                          listen: false)
                                      .filterSnacks();
                                } else if (dropdownValue.contains('Alcohol')) {
                                  Provider.of<ItemsController>(context,
                                          listen: false)
                                      .filterAlcohol();
                                }
                              },
                              items: items
                                  .map((values) => DropdownMenuItem(
                                        child: Text(
                                          values,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        value: values,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: (media.width < 600) ? searchflex : 4,
                      // flex: searchflex,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: (media.width < 600)
                              ? BoxDecoration(
                                  border: (isSearchOpen)
                                      ? null
                                      : Border(
                                          left: BorderSide(
                                            color: kDefaultBackgroundColor,
                                            width: 3,
                                          ),
                                        ))
                              : null,
                          child: Visibility(
                            visible: isvisible,
                            maintainState: false,
                            replacement: IconButton(
                                icon: Icon(Icons.search),
                                splashRadius: 1,
                                onPressed: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                    myfocusnode.requestFocus();
                                    isSearchOpen = true;
                                  });
                                }),
                            child: TextField(
                              cursorColor: kDefaultGreen,
                              autofocus: false,
                              onEditingComplete: () {
                                setState(() {
                                  isvisible = !isvisible;
                                  itemsFlex = 4;
                                  searchflex = 0;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      myfocusnode.unfocus();
                                      setState(() {
                                        isvisible = !isvisible;
                                        isSearchOpen = !isSearchOpen;
                                      });
                                    },
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              focusNode: myfocusnode,
                              controller: _controller,
                            ),
                          ),
                        ),
                      ),
                    ),
                    (media.width > 600)
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            // width: 184,
                            // padding: EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 48, vertical: 12),
                            decoration: BoxDecoration(
                              color: kDefaultGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Open Ticket',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    (media.width > 600)
                        ? ExpandableSidenav(
                            sidebarPanelWidth: sidebarPanelWidth,
                          )
                        : Container(),
                    Provider.of<ItemsController>(context).items.length > 0
                        ? ((Provider.of<SettingController>(context,
                                    listen: false)
                                .isListLayout)
                            ? Provider.of<ItemsController>(context,
                                        listen: false)
                                    .sortedList
                                    .isEmpty
                                ? ItemsListView(
                                    futureItem: futureItem,
                                    onClick: listClick,
                                  )
                                : ItemsSoretedListView(
                                    futureItem: futureItem, onClick: listClick)
                            : (Provider.of<ItemsController>(context,
                                        listen: false)
                                    .sortedList
                                    .isNotEmpty
                                ? SortedItemsGridView(
                                    futureItem: futureItem, onClick: listClick)
                                : ItemsGridView(
                                    futureItem: futureItem,
                                    onClick: listClick,
                                  )))
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('You have no Items Yet'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child:
                                      Text('Go to items menu to add an item'),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: PrimaryButton(
                                      title: 'Go To Items',
                                      onPressed: () {
                                        setState(() {
                                          selectedIndex = 2;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        // media.width > 600 ? SidebarPayment() : Container(),
      ],
    );
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
  }
}
