import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .021,
              ),
              const Text(
                "Section of (Transactions), helps you to find how to start a transaction, and how to execute the existence ones. It helps you from the beginning to the end, and you can all the required things you need",
                style: TextStyle(color: Color.fromARGB(255, 76, 76, 76)),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text("Types of Transactions"),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: _transactionTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor.withAlpha(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _transactionTypes[index],
                            style: const TextStyle(
                                color: Color.fromARGB(255, 78, 78, 78)),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 78, 78, 78),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  final List<String> _transactionTypes = const [
    "12th Studen Registerations",
    "New student (Waivor and Transfering) ",
    "Student's Payment",
    "Available students transactions"
  ];
}
