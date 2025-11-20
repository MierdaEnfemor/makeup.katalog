import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> products = const [
    {
      "name": "Soft Blush",
      "price": "Rp 49.000",
      "img": "assets/images/blush.jpg",
      "description": "Blush on dengan hasil akhir natural untuk pipi merona.",
    },
    {
      "name": "Eyeshadow Palette",
      "price": "Rp 129.000",
      "img": "assets/images/eyeshadow.jpg",
      "description": "Palet eyeshadow dengan warna-warna cantik dan pigmented.",
    },
    {
      "name": "Lipstick Matte",
      "price": "Rp 59.000",
      "img": "assets/images/lipstik2.jpg",
      "description": "Lipstick matte yang tahan lama dan nyaman di bibir.",
    },
    {
      "name": "Liquid Foundation",
      "price": "Rp 89.000",
      "img": "assets/images/foundation.jpg",
      "description":
          "Foundation cair dengan coverage tinggi untuk wajah mulus.",
    },
  ];

  final List<String> localBanner = [
    "assets/images/slider1.jpg",
    "assets/images/slider2.jpg",
    "assets/images/slider3.jpg",
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Untuk efek shimmer
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    // Setup shimmer animation
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );

    _shimmerController.repeat();

    // Auto slide banner
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < localBanner.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff5f8),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.face_retouching_natural, size: 28),
            SizedBox(width: 8),
            Text(
              "BeautyGlow",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Slider dengan Shimmer Effect
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Stack(
              children: [
                // Background Images
                PageView.builder(
                  controller: _pageController,
                  itemCount: localBanner.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      localBanner[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),

                // Dark Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),

                // Shimmer Effect
                AnimatedBuilder(
                  animation: _shimmerAnimation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(_shimmerAnimation.value - 1, -0.5),
                          end: Alignment(_shimmerAnimation.value, 0.5),
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.3),
                            Colors.pink.withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4, 0.6, 1.0],
                        ),
                      ),
                    );
                  },
                ),

                // Text Content
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Sparkle icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.auto_awesome,
                              color: Colors.yellow, size: 20),
                          SizedBox(width: 8),
                          Icon(Icons.auto_awesome,
                              color: Colors.yellow, size: 24),
                          SizedBox(width: 8),
                          Icon(Icons.auto_awesome,
                              color: Colors.yellow, size: 20),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Tampil Cantik Setiap Hari",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.pink,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Temukan koleksi makeup terbaik!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Page Indicators
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      localBanner.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.pink.shade300
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Title Katalog dengan dekorasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Katalog Makeup",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.pink.shade300, size: 20),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Grid Produk dengan animasi
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: products[index]["name"]!,
                  price: products[index]["price"]!,
                  img: products[index]["img"]!,
                  description: products[index]["description"]!,
                  index: index,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          name: products[index]["name"]!,
                          price: products[index]["price"]!,
                          img: products[index]["img"]!,
                          description: products[index]["description"]!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget kartu produk dengan animasi hover
class ProductCard extends StatefulWidget {
  final String name, price, img, description;
  final VoidCallback onTap;
  final int index;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.img,
    required this.description,
    required this.onTap,
    required this.index,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade100.withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Badge "NEW" atau "SALE" (random untuk variasi)
              if (widget.index == 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "HOT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Gambar Produk
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Hero(
                    tag: widget.img,
                    child: Image.asset(
                      widget.img,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Divider lucu
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.pink.shade200,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Nama Produk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 6),

              // Harga dengan background
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.price,
                  style: TextStyle(
                    color: Colors.pink.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
