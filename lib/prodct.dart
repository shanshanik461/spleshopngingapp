import 'package:flutter/material.dart';

class Product1 extends StatefulWidget {
  const Product1({Key? key}) : super(key: key);

  @override
  State<Product1> createState() => _Product1State();
}

class _Product1State extends State<Product1> {
  List<Map<String, dynamic>> products = [
    {"name": "Airpot", "image": "assets/download (5).jpg", "price": "₹499"},
    {"name": "HP Lap", "image": "assets/download (4).jpg", "price": "₹499"},
    {"name": "Nike", "image": "assets/nike4.png", "price": "₹499"},
    {"name": "HP Lap", "image": "assets/download (4).jpg", "price": "₹499"},
    {"name": "Iphone", "image": "assets/download (3).jpg", "price": "₹499"},
    {"name": "Airpot", "image": "assets/download (5).jpg", "price": "₹499"},
  ];

  List<bool> isLikedList = List.filled(6, false); // Track the like status for each product
  List<int> selectedItems = []; // Track the indices of selected items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedItems.contains(index)) {
                  selectedItems.remove(index);
                } else {
                  selectedItems.add(index);
                }
                isLikedList[index] = !isLikedList[index]; // Toggle the like status
              });
            },
            child: buildProductCard(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedItems.isNotEmpty) {
            // At least one item is selected, navigate to the next page
            _navigateToProductDetails();
          } else {
            // No item is selected, show a snackbar or perform any other action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select at least one item.'),
              ),
            );
          }
        },
        child: Icon(Icons.favorite),
      ),
    );
  }

  void _navigateToProductDetails() {
    // Navigate to the product details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          selectedItems: selectedItems,
          products: products,
        ),
      ),
    );
  }

  Widget buildProductCard(int index) {
    final bool isSelected = selectedItems.contains(index);

    return SizedBox(
      height: 112,
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 100,
            width: 360,
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    products[index]["image"],
                    width: 80,
                    height: 80,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        products[index]["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        products[index]["price"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    isSelected ? Icons.favorite : Icons.favorite_border,
                    color: isSelected ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        selectedItems.remove(index);
                      } else {
                        selectedItems.add(index);
                      }
                      isLikedList[index] = !isLikedList[index]; // Toggle the like status
                    });
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final List<int> selectedItems;
  final List<Map<String, dynamic>> products;

  const ProductDetailsPage({
    Key? key,
    required this.selectedItems,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Products'),
      ),
      body: ListView.builder(
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          final int selectedIndex = selectedItems[index];
          return ListTile(
            title: Text(products[selectedIndex]["name"]),
            subtitle: Text(products[selectedIndex]["price"]),
            leading: Image.asset(products[selectedIndex]["image"]),
          );
        },
      ),
    );
  }
}
