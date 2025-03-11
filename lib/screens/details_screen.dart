import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocketapp_assignment/provider/rocket_data_provider.dart';
import 'package:rocketapp_assignment/utils/constants.dart';

class RocketDetailScreen extends StatefulWidget {
  String id;
  RocketDetailScreen({required this.id});

  @override
  State<RocketDetailScreen> createState() => _RocketDetailScreenState();
}

class _RocketDetailScreenState extends State<RocketDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<RocketController>()
        .fetchRocketDetails(id: widget.id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          title: Consumer<RocketController>(
            builder: (context, value, child) =>
                value.isLoading ? Text('') : Text(value.detail!.name),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<RocketController>(builder: (ctx, value, child) {
            return value.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 26),
                        //use single child scrollview widget for scroll images
                        SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                value.detail!.flickrImages.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: defaultPadding),
                                  child: Center(
                                    child: Container(
                                      height: 200,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(value
                                                  .detail!.flickrImages[index]
                                                  .toString()),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Text(
                          'Active Status: ${value.detail!..active.toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Cost per launch: ${value.detail!.costPerLaunch.toString()}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Success Rate : ${value.detail!.successRatePct.toString()}%',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Divider(),
                        Text(
                          'Description: ${value.detail!.description.toString()}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        Divider(),
                        Text(
                          'Wikipedia: ${value.detail!.wikipedia.toString()}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        Divider(),
                        Text(
                          'Height : ${value.detail!.height.meters.toString()}m ${value.detail!.height.feet.toString()}ft',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Diameter: ${value.detail!.height.meters.toString()}m ${value.detail!.height.feet.toString()}ft',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  );
          }),
        ));
  }
}
