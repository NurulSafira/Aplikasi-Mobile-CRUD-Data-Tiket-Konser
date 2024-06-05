import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'model.dart';
import 'service.dart';

class TambahEventPage extends StatefulWidget {
  final EventData? event;

  TambahEventPage(this.event);

  @override
  _TambahEventPageState createState() => _TambahEventPageState();
}

class _TambahEventPageState extends State<TambahEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priceTaxController = TextEditingController();
  final EventService eventService =
      EventService(baseUrl: 'http://192.168.1.4/uas_pm');
  String _category = 'Musik';
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      _nameController.text = widget.event!.name;
      _venueController.text = widget.event!.venue;
      _descriptionController.text = widget.event!.description;
      _priceController.text =
          "${(widget.event!.price - (widget.event!.price * 20 / 100))}"
              .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      ;
      _priceTaxController.text = widget.event!.price.toString();
      _category = widget.event!.category;
      _selectedDate = DateTime.parse(widget.event!.dateTime.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          'EventTiketOnline',
          style:
              TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: InkWell(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      autocorrect: false,
                      controller: _nameController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Nama Event",
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
                        prefixIcon: Icon(
                          Icons.event,
                          color: Colors.cyan,
                        ),
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Nama Event harus diisi";
                        }
                      })),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: widget.event == null
                          ? DateTime.now()
                          : DateTime.parse(widget.event!.dateTime),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2099),
                    ).then((value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.cyan,
                        ),
                        SizedBox(width: 10),
                        Text(_selectedDate != null
                            ? "${DateFormat('dd MMMM yyyy').format(_selectedDate!)}"
                            : "Pilih Tanggal")
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.subject,
                        color: Colors.cyan,
                      ),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _category,
                        underline: SizedBox(),
                        items: <String>[
                          'Musik',
                          'seni',
                          'E-Sports',
                          'kuliner',
                          'edukasi',
                          'budaya',
                          'olahraga',
                          'hiburan',
                          'otomotif',
                          'film',
                          'teknologi',
                          'fashion'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      autocorrect: false,
                      controller: _venueController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Venue",
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
                        prefixIcon: Icon(
                          Icons.place,
                          color: Colors.cyan,
                        ),
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Venue harus diisi";
                        }
                      })),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Harga Jual Tiket",
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
                        prefixIcon: Icon(
                          Icons.receipt,
                          color: Colors.cyan,
                        ),
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
                        setState(() {
                          _priceTaxController.text =
                              "${(int.parse(_priceController.text) + (int.parse(_priceController.text) * 20 / 100))}"
                                  .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
                        });
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Harga Jual Tiket harus diisi";
                        }
                      })),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      autocorrect: false,
                      controller: _priceTaxController,
                      enabled: false,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Harga Tiket Setelah Pajak 20%",
                        labelStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        hintStyle: TextStyle(fontSize: 14),
                        fillColor: Colors.amber,
                        filled: true,
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.receipt,
                          color: Colors.white,
                        ),
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
                      validator: (v) {})),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      autocorrect: false,
                      maxLines: 5,
                      controller: _descriptionController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Deskripsi",
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Deskripsi harus diisi";
                        }
                      })),
              SizedBox(height: 25),
              Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      child: Text("Simpan", style: TextStyle(fontSize: 18)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.cyan)))),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        checkForm();
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Future checkForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState?.save();

    EventData eventData = EventData(
      idEvent: 0,
      name: _nameController.text,
      category: _category,
      dateTime: _selectedDate.toString(),
      description: _descriptionController.text,
      price: int.parse(_priceTaxController.text),
      venue: _venueController.text,
    );

    if (widget.event != null) {
      eventService.updateEvent(widget.event!.idEvent, eventData).then((_) {
        _nameController.clear();
        _descriptionController.clear();
        _venueController.clear();
        _priceController.clear();
        _priceTaxController.clear();

        Navigator.of(context).pop(true);
        //
        final snackBar = SnackBar(
            backgroundColor: Colors.cyan,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Event berhasil di update",
              style: TextStyle(fontSize: 14, color: Colors.white, height: 1.4),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      eventService.createEvent(eventData).then((_) {
        _nameController.clear();
        _descriptionController.clear();
        _venueController.clear();
        _priceController.clear();
        _priceTaxController.clear();
        //
        Navigator.of(context).pop(true);
        //
        final snackBar = SnackBar(
            backgroundColor: Colors.cyan,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Event berhasil ditambahkan",
              style: TextStyle(fontSize: 14, color: Colors.white, height: 1.4),
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}
