part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewmodel homeViewmodel = HomeViewmodel();

  @override
  void initState() {
    homeViewmodel.getProvinceList();
    super.initState();
  }

  final List<String> couriers = ['jne', 'tiki', 'pos'];

  dynamic selectedCourier = 'jne';
  dynamic selectedProvince;
  dynamic selectedCity;

  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Hitung Ongkir",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<HomeViewmodel>(
          create: (BuildContext context) => homeViewmodel,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedCourier,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 2,
                                    hint: Text('Pilih kurir'),
                                    style: TextStyle(color: Colors.black),
                                    items: couriers.map((String courier){
                                      return DropdownMenuItem<String>(
                                        value: courier, 
                                        child: Text(courier),
                                      );
                                    }).toList(), 
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCourier = newValue;
                                      });
                                    }
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // Weight Input Field
                                Expanded(
                                  flex:3,
                                  child: TextFormField(
                                    controller: weightController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Berat (gr)',
                                    ),
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Origin",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  flex: 1, 
                                  child: Consumer<HomeViewmodel>(
                                    builder: (context, value, _) {
                                    switch (value.provinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              value.provinceList.message.toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedProvince,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih provinsi'),
                                            style: TextStyle(color: Colors.black),
                                            items: value.provinceList.data!
                                                .map<DropdownMenuItem<Province>>(
                                                    (Province value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child:
                                                    Text(value.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                selectedProvince = newValue;
                                                selectedCity = null;
                                                homeViewmodel.getCityList(selectedProvince.provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Consumer<HomeViewmodel>(
                                    builder: (context, value, _) {
                                    switch (value.cityList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Pilih provinsi terlebih dahulu"),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              value.cityList.message.toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedCity,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih kota'),
                                            style: TextStyle(color: Colors.black),
                                            items: value.cityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child:
                                                    Text(value.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedCity = newValue;
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }), 
                                )
                              ],
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Destination",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  flex: 1, 
                                  child: Consumer<HomeViewmodel>(
                                    builder: (context, value, _) {
                                    switch (value.provinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              value.provinceList.message.toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedProvince,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih provinsi'),
                                            style: TextStyle(color: Colors.black),
                                            items: value.provinceList.data!
                                                .map<DropdownMenuItem<Province>>(
                                                    (Province value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child:
                                                    Text(value.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                selectedProvince = newValue;
                                                selectedCity = null;
                                                homeViewmodel.getCityList(selectedProvince.provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Consumer<HomeViewmodel>(
                                    builder: (context, value, _) {
                                    switch (value.cityList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Pilih provinsi terlebih dahulu"),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              value.cityList.message.toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedCity,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Pilih kota'),
                                            style: TextStyle(color: Colors.black),
                                            items: value.cityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child:
                                                    Text(value.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedCity = newValue;
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }), 
                                )
                              ],
                            ),

                            const SizedBox(height: 12),
                            
                            ElevatedButton(
                              onPressed: (){
                                print('Test');
                              }, 
                              child: Text('Hitung Estimasi Harga'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                textStyle: TextStyle(fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                                )
                              )
                            )

                          ],
                        ),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Tidak ada data."),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
