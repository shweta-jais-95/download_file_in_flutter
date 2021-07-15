import 'package:file_downlaod_in_flutter/datamodel/item.dart';
import 'package:file_downlaod_in_flutter/utility/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> itemList = [
    Item(
        id: 1,
        name: "United Colors of Benetton Men's Striped Regular Fit Polo",
        description:
            "Care Instructions: Normal wash,Fit Type: regular fit,100% Cotton,Short sleeve,Normal wash,Regular Fit",
        imageDetails: ImageDetails(
            mimeType: "image/png",
            name: 'A.png',
            url: 'https://i.imgur.com/BoN9kdC.png'),
        price: 120.22),
    Item(
        id: 2,
        name: "Deniklo Men Polo Shirt",
        description:
            "Care Instructions: Machine Wash,Fit Type: regular fit,Material - 60% Cotton and 40% Polyester,Fit Type - Regular fit; Half sleeve Polo T-Shirt,Pattern - Striped,Fabric: Cotton polyester blend jersey fabric, bio washed",
        imageDetails: ImageDetails(
            mimeType: "image/png",
            name: 'A.png',
            url: 'https://googleflutter.com/sample_image.jpg'),
        price: 387.00),
    Item(
        id: 3,
        name: "Deniklo Men Polo Shirt",
        description:
            "Care Instructions: Machine Wash,Fit Type: regular fit,Material - 60% Cotton and 40% Polyester,Fit Type - Regular fit; Half sleeve Polo T-Shirt,Pattern - Striped,Fabric: Cotton polyester blend jersey fabric, bio washed",
        imageDetails: ImageDetails(
            mimeType: "image/png",
            name: 'A.png',
            url: 'https://googleflutter.com/sample_image.jpg'),
        price: 387.00),
    Item(
        id: 4,
        name: "United Colors of Benetton Men's Striped Regular Fit Polo",
        description:
            "Care Instructions: Normal wash,Fit Type: regular fit,100% Cotton,Short sleeve,Normal wash,Regular Fit",
        imageDetails: ImageDetails(
            mimeType: "image/png",
            name: 'A.png',
            url: 'https://i.imgur.com/BoN9kdC.png'),
        price: 120.22),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(Strings.appName),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext buildContext, int index) {
          return InkWell(
            onTap: () {},
            child: Card(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image:
                                NetworkImage(itemList[index].imageDetails.url),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemList[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            itemList[index].description,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${itemList[index].price}",
                            style: TextStyle(color: Colors.black, fontSize: 21),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: itemList.length,
      ),
    );
  }
}
