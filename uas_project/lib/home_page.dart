import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uas_project/tambah_event_page.dart';
import 'detail_event_page.dart';
import 'service.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<EventData>> eventListener;
  final EventService eventService =
      EventService(baseUrl: 'http://192.168.1.4/uas_pm');
  final TextEditingController _cariController = TextEditingController();

  var _isSearch = false;
  List<dynamic> galleryEvents = [
    {
      'name': "Konser Dewa 19",
      "photo":
          'https://ecs7.tokopedia.net/blog-tokopedia-com/uploads/2017/12/Blog_Acara-Konser-Musik-Tahunan-di-Indonesia-buat-Pecinta-Musik.jpg'
    },
    {
      'name': "Coldplay",
      "photo":
          'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/11/07/Untitled-design-2023-11-07T132711552-661464454.png'
    }
  ];

  @override
  void initState() {
    super.initState();

    eventListener = eventService.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var response = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TambahEventPage(null)));

              if (response != null && response == true) {
                setState(() {
                  eventListener = eventService.fetchEvents();
                });
              }
            },
            backgroundColor: Colors.cyan,
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: const Text(
            'EventTiketOnline',
            style: TextStyle(
                fontSize: 17, color: Colors.white, letterSpacing: 0.53),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leading: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.subject,
              color: Colors.white,
            ),
          ),
          actions: [],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Text(
                      "Galeri Event",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                // SizedBox(height: 10),
                Container(
                  height: 170,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: galleryEvents.length,
                    itemBuilder: (context, i) {
                      var galeri = galleryEvents[i];
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Image.network(galeri['photo']),
                                  Positioned(
                                      bottom: 10.0,
                                      left: 20.0,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.cyan,
                                        ),
                                        child: Text(
                                          galeri['name'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                ],
                              )));
                    },
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: _isSearch
                    ? TextFormField(
                        textAlign: TextAlign.start,
                        autocorrect: false,
                        controller: _cariController,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "cari event...",
                          hintStyle: TextStyle(fontSize: 14),
                          fillColor: Colors.white70,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isSearch = false;
                                  eventListener = eventService.fetchEvents();
                                  _cariController.clear();
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.indigo,
                              )),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (v) {
                          print("onChanged: $v");

                          setState(() {
                            _isSearch = true;
                            eventListener = eventService.searchEvent(v);
                          });
                        },
                        validator: (v) {})
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month,
                                  color: Colors.redAccent),
                              SizedBox(width: 7),
                              Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Text(
                                    "Event terdekat",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isSearch = true;
                                });
                              },
                              icon: Icon(Icons.search))
                        ],
                      )),
            SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<List<EventData>>(
                  future: eventListener,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<EventData> eventList = snapshot.data!;
                      return eventList.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_off,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 15),
                                Text("Data Pegawai tidak ditemukan.")
                              ],
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              itemCount: eventList.length,
                              itemBuilder: (context, index) {
                                eventList.sort(
                                    (a, b) => b.idEvent.compareTo(a.idEvent));
                                EventData event = eventList[index];

                                return GestureDetector(
                                    onTap: () async {
                                      var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TambahEventPage(event)));

                                      if (response != null &&
                                          response == true) {
                                        setState(() {
                                          eventListener =
                                              eventService.fetchEvents();
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3FE5E5E5),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ],
                                          color: Colors.white),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      margin: EdgeInsets.symmetric(vertical: 7),
                                      child: Row(children: [
                                        Container(
                                          height: 80,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.amber[100],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${DateFormat('MMM').format(DateTime.parse(event.dateTime.trim()))}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.cyan),
                                              ),
                                              Text(
                                                  "${DateFormat('dd').format(DateTime.parse(event.dateTime.trim()))}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${DateFormat('dd MMM, yyyy').format(DateTime.parse(event.dateTime.trim()))}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54)),
                                                  GestureDetector(
                                                      onTap: () {
                                                        _showPicker(
                                                            context, event);
                                                      },
                                                      child: Icon(
                                                        Icons.more_vert_rounded,
                                                        size: 24,
                                                        color: Colors.red,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text("${event.name}",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              SizedBox(height: 2),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: Row(children: [
                                                          Icon(
                                                            Icons.place,
                                                            color: Colors.cyan,
                                                            size: 20,
                                                          ),
                                                          Text("${event.venue}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black)),
                                                        ])),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Row(children: [
                                                          Text("Rp",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .cyan,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(width: 2),
                                                          Text("${event.price}",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .cyan)),
                                                        ]))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                      ]),
                                    ));
                              },
                            );
                    }
                  }),
            )
          ],
        )));
  }

  void _showPicker(context, EventData event) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text('Hapus data event?',
                                  style: TextStyle(
                                      // color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                        ]),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                        eventService.deleteEvent(event.idEvent).then((_) {
                          setState(() {
                            eventListener = eventService.fetchEvents();
                          });
                          final snackBar = SnackBar(
                              backgroundColor: Colors.cyan,
                              duration: Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Event berhasil dihapus",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1.4),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ya",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Icon(Icons.check, color: Colors.white)
                            ],
                          ))),
                  SizedBox(height: 10),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tidak",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Icon(Icons.close)
                            ],
                          ))),
                ],
              ),
            ),
          );
        });
  }
}
