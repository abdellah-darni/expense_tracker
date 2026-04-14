import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 250, 255),
        title: const Text(
          "The Fluid Accountant",
          style: TextStyle(
              fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/avatar.jpg"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => print("somthing"),
            icon: const Icon(Icons.settings)
            )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 246, 250, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 51, 76, 98), Color.fromARGB(255, 72, 100, 117)]
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MONTHLY SPENDING",
                        style: TextStyle(
                          color: Color.fromARGB(200,159, 185, 211),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.attach_money, color: Color.fromARGB(200,159, 185, 211) , size: 32,),
                          SizedBox(width: 0,),
                          Text(
                            "4,285.50",
                            style: TextStyle(
                              height: 1.0,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.trending_down, color: Colors.green, size: 25,),
                            SizedBox(width: 10,),
                            Text("12% less then last month", style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breakdown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "See Insghts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 78, 101),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              // Row
          ],
        ),
      ),
    );
  }
}