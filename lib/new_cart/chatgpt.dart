import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MedicineProduct {
  final String name;
  final String imageUrl;

  MedicineProduct({required this.name, required this.imageUrl});
}

final List<MedicineProduct> products = [
  MedicineProduct(
      name: "Product 1", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 2", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 3", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 4", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 5", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 6", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 7", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 8", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 9", imageUrl: "https://via.placeholder.com/150"),
  MedicineProduct(
      name: "Product 10", imageUrl: "https://via.placeholder.com/150"),
];

class CustomScrollViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomScrollView Example"),
      ),
      body: CustomScrollView(
        slivers: [
          // Carousel image slider
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage("https://via.placeholder.com/350x150"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage("https://via.placeholder.com/350x150"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage("https://via.placeholder.com/350x150"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Horizontal scrollable list
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(5),
                      width: 100,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          "Item ${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
          // Grid view of medicine products
          // Grid view of medicine products
          SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              products.length,
              (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          products[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "\$${products[index].name}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {},
      ),
    );
  }
}
