import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocketapp_assignment/provider/rocket_data_provider.dart';
import 'package:rocketapp_assignment/screens/details_screen.dart';
import 'package:rocketapp_assignment/utils/components/custom_card.dart';
import 'package:rocketapp_assignment/utils/constants.dart';
import 'package:rocketapp_assignment/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RocketController>().fetchRocket(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RocketController>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            controller.isLoading ? 'Loading...' : 'Rockets',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            controller.fetchRocket(context: context);
          },
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
        body: Consumer<RocketController>(builder: (ctx, value, child) {
          return value.isLoading
              //before load rocket list showing circular progress indicator
              ? const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                )
              : ListView.builder(
                  itemCount: value.rockets.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final rocket = value.rockets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: CustomCard(
                        rocket: rocket,
                        onTap: () {
                          //navigate to rocket details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RocketDetailScreen(
                                id: value.rockets[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
        }));
  }
}
