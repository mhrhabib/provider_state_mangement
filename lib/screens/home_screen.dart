import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management_tutorial/providers/shoes_list_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) => IconButton(
                icon: Icon(themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
                onPressed: themeProvider.toggleTheme,
              ),
            ),
          ],
        ),
        body: Consumer<ShoesListProvider>(
          builder: (context, shoesProvider, child) => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: shoesProvider.shoesList.length,
                  itemBuilder: (context, index) {
                    final shoe = shoesProvider.shoesList[index];
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          shoesProvider.selectShoe(shoe);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  shoe.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoe.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${shoe.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  CustomElevatedButton(
                                    onPressed: () {
                                      shoesProvider.selectShoe(shoe);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${shoe.name} selected!'),
                                        ),
                                      );
                                    },
                                    text: 'Select',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (shoesProvider.currentOrder != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Selected shoe: ${shoesProvider.currentOrder!.shoes.name}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Price: \$${shoesProvider.currentOrder!.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (shoesProvider.currentOrder!.quantity > 1) {
                                shoesProvider.updateQuantity(shoesProvider.currentOrder!.quantity - 1);
                              }
                            },
                          ),
                          Text(
                            'Quantity: ${shoesProvider.currentOrder!.quantity}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              shoesProvider.updateQuantity(shoesProvider.currentOrder!.quantity + 1);
                            },
                          ),
                        ],
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          shoesProvider.placeOrder();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Placed!')),
                          );
                        },
                        text: 'Place Order',
                      ),
                    ],
                  ),
                ),
              if (shoesProvider.currentOrder == null)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Please select a shoe to order.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      );
}
