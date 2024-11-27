import 'dart:ui';

import 'package:flutter/material.dart';

class Product{
   String name;
   Image image;
   String description;
   int price;

   Product(this.name, this.image, this.description, this.price);
}

List<Product> productList = [
   Product(
      "Blouse",
      Image.asset("assets/bluzon.jpg"),
      "A soft and elegant blouse, perfect for casual or formal wear.",
      120,
   ),
   Product(
      "Vest",
      Image.asset("assets/elek.jpg"),
      "A cozy and stylish vest to keep you warm in cool weather.",
      80,
   ),
   Product(
      "Jeans",
      Image.asset("assets/farmerki.jpg"),
      "Classic denim jeans, versatile and great for everyday outfits.",
      300,
   ),
   Product(
      "Jacket",
      Image.asset('assets/jakna.jpg'),
      "A durable jacket designed for both style and functionality.",
      50,
   ),
   Product(
      "Cap",
      Image.asset("assets/kapa.jpg"),
      "A comfortable cap to complete your sporty or casual look.",
      25,
   ),
   Product(
      "Coat",
      Image.asset("assets/kaput.jpg"),
      "A warm and timeless coat, perfect for chilly days.",
      150,
   ),
   Product(
      "Shirt",
      Image.asset("assets/koshula.jpg"),
      "A classic button-up shirt, great for work or social events.",
      75,
   ),
   Product(
      "Blouse",
      Image.asset("assets/maica.jpg"),
      "A lightweight blouse that's perfect for summer days.",
      100,
   ),
   Product(
      "Coat",
      Image.asset("assets/mantil.jpg"),
      "A stylish long coat for a sleek and modern appearance.",
      200,
   ),
   Product(
      "Pants",
      Image.asset("assets/pantaloni.jpg"),
      "Comfortable and durable pants for any occasion.",
      40,
   ),
];
