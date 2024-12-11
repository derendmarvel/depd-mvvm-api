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
    homeViewmodel.getOriginProvinceList();
    homeViewmodel.getDestinationProvinceList();
    super.initState();
  }

  final List<String> couriers = ['jne', 'tiki', 'pos'];

  dynamic selectedCourier = 'jne';
  dynamic selectedProvinceOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedProvinceDestination;
  dynamic selectedCityDestination;

  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Calculate Shipping Cost",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Courier",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedCourier,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 2,
                                      hint: Text('Pilih kurir'),
                                      style: TextStyle(color: Colors.black),
                                      items: couriers.map((String courier) {
                                        return DropdownMenuItem<String>(
                                          value: courier,
                                          child: Text(courier),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCourier = newValue;
                                        });
                                      }),
                                ),

                                const SizedBox(width: 20),

                                // Weight Input Field
                                Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      controller: weightController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Weight (gr)',
                                          labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ))
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
                                    switch (value.originProvinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value
                                              .originCityList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedProvinceOrigin,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Select province'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value
                                                .originProvinceList.data!
                                                .map<DropdownMenuItem<Province>>(
                                                    (Province value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                selectedProvinceOrigin =
                                                    newValue;
                                                selectedCityOrigin = null;
                                                homeViewmodel.getOriginCityList(
                                                    selectedProvinceOrigin
                                                        .provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  flex: 1,
                                  child: Consumer<HomeViewmodel>(
                                      builder: (context, value, _) {
                                    switch (value.originCityList.status) {
                                      case Status.notStarted:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Please select a province"),
                                        );
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value
                                              .originCityList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedCityOrigin,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Select city'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value.originCityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                    value.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedCityOrigin = newValue;
                                              });
                                            });
                                      default:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Please select a province"),
                                        );
                                    }
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
                                      builder: (context1, value1, _) {
                                    switch (
                                        value1.destinationProvinceList.status) {
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value1
                                              .destinationProvinceList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedProvinceDestination,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Select province'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value1
                                                .destinationProvinceList.data!
                                                .map<
                                                        DropdownMenuItem<
                                                            Province>>(
                                                    (Province value1) {
                                              return DropdownMenuItem(
                                                value: value1,
                                                child: Text(
                                                    value1.province.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue1) {
                                              setState(() {
                                                // selectedDataProvince = newValue;
                                                selectedProvinceDestination =
                                                    newValue1;
                                                selectedCityDestination = null;
                                                homeViewmodel
                                                    .getDestinationCityList(
                                                        selectedProvinceDestination
                                                            .provinceId);
                                              });
                                            });
                                      default:
                                    }
                                    return Container();
                                  }),
                                ),
                                
                                const SizedBox(width: 16),

                                Expanded(
                                  flex: 1,
                                  child: Consumer<HomeViewmodel>(
                                      builder: (context1, value1, _) {
                                    switch (value1.destinationCityList.status) {
                                      case Status.notStarted:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Please select a province"),
                                        );
                                      case Status.loading:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(value1
                                              .destinationCityList.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        return DropdownButton(
                                            isExpanded: true,
                                            value: selectedCityDestination,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            elevation: 2,
                                            hint: Text('Select city'),
                                            style:
                                                TextStyle(color: Colors.black),
                                            items: value1
                                                .destinationCityList.data!
                                                .map<DropdownMenuItem<City>>(
                                                    (City value1) {
                                              return DropdownMenuItem(
                                                value: value1,
                                                child: Text(
                                                    value1.cityName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue1) {
                                              setState(() {
                                                selectedCityDestination =
                                                    newValue1;
                                              });
                                            });
                                      default:
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Please select a province"),
                                        );
                                    }
                                  }),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),
                            
                            ElevatedButton(
                              onPressed: () async {
                                // Validate inputs
                                if (selectedCityOrigin == null ||
                                    selectedCityDestination == null ||
                                    weightController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Please fill in all required fields."),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }

                                final originCityId = selectedCityOrigin.cityId;
                                final destinationCityId = selectedCityDestination.cityId;
                                final weight = int.tryParse(weightController.text) ?? 0;
                                final courier = selectedCourier;

                                // Call calculateOngkir method
                                await homeViewmodel.calculateOngkir(
                                  origin: originCityId,
                                  destination: destinationCityId,
                                  weight: weight,
                                  courier: courier,
                                );

                                // Check for errors
                                if (homeViewmodel.shippingCostList.status == Status.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(homeViewmodel.shippingCostList.message!),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: Text('Calculate estimated cost'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                textStyle: TextStyle(fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: Container(
                      child: Consumer<HomeViewmodel>(
                        builder: (context, value, _) {
                          if (value.shippingCostList.status == Status.notStarted){
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                value.shippingCostList.status == Status.error
                                    ? value.shippingCostList.message!
                                    : "Please fill in all the columns.",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            );
                          } else if (value.shippingCostList.status == Status.loading) {
                              return Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                          } else if (value.shippingCostList.data != null &&
                              value.shippingCostList.data!.isNotEmpty) {
                            return ListView.builder(
                              itemCount: value.shippingCostList.data!.length,
                              itemBuilder: (context, index) {
                                final costResponse = value.shippingCostList.data![index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        "Courier: ${costResponse.name}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    ...costResponse.costs!.map((cost) => Card(
                                      elevation: 2.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: 
                                                Text("${cost.description} (${cost.service})",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              minVerticalPadding: 0,
                                              contentPadding: EdgeInsets.all(0),
                                              minTileHeight: 0,
                                            ),
                                            ...cost.cost!.map((detail) => Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Cost: Rp ${NumberFormat("#,##0").format(detail.value)},00"),
                                                      Text(
                                                        "Estimated arrival: ${detail.etd}",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 12
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          ],
                                        ),
                                      )),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                value.shippingCostList.status == Status.error
                                    ? value.shippingCostList.message!
                                    : "There is no data available.",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
