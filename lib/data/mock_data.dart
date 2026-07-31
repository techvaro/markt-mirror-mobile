import '../models/models.dart';

class MockData {
  // =========================================================================
  // CITIES
  // =========================================================================
  static final List<String> cities = [
    'Lagos', 'Abuja', 'Port Harcourt', 'Ibadan', 'Kano', 'Enugu',
    'Benin City', 'Onitsha', 'Abeokuta', 'Jos', 'Warri', 'Kaduna',
    'Calabar', 'Owerri', 'Akure', 'Bauchi', 'Maiduguri', 'Zaria',
  ];

  // =========================================================================
  // NIGERIAN STATES & MARKETS
  // =========================================================================
  static final List<NigerianState> nigerianStates = [
    NigerianState(name: 'Abia', markets: ['Ariaria International Market', 'Isigate Market', 'Ekeoha Market']),
    NigerianState(name: 'Adamawa', markets: ['Jimeta Main Market', 'Yola Market', 'Mubi Market']),
    NigerianState(name: 'Akwa Ibom', markets: ['Uyo Main Market', 'Ikot Ekpene Market', 'Eket Market']),
    NigerianState(name: 'Anambra', markets: ['Onitsha Main Market', 'Nkpor Market', 'Bridge Head Market']),
    NigerianState(name: 'Bauchi', markets: ['Bauchi Main Market', 'Wunti Market', 'Muda Lawal Market']),
    NigerianState(name: 'Bayelsa', markets: ['Yenagoa Main Market', 'Swali Market', 'Opolo Market']),
    NigerianState(name: 'Benue', markets: ['Wurukum Market', 'High Level Market', 'Modern Market']),
    NigerianState(name: 'Borno', markets: ['Monday Market', 'Gamboru Market', 'Bulumkutu Market']),
    NigerianState(name: 'Cross River', markets: ['Watt Market', 'Bayside Market', 'Marian Market']),
    NigerianState(name: 'Delta', markets: ['Ogbeogonogo Market', 'Igbudu Market', 'Oshimili Market']),
    NigerianState(name: 'Ebonyi', markets: ['Abakaliki Main Market', 'Kpirikpiri Market', 'New Market']),
    NigerianState(name: 'Edo', markets: ['Oba Market', 'New Benin Market', 'Uselu Market']),
    NigerianState(name: 'Ekiti', markets: ['Oja Oba Market', 'Ado Main Market', 'Ijero Market']),
    NigerianState(name: 'Enugu', markets: ['Ogbete Main Market', 'New Market', 'Artisan Market']),
    NigerianState(name: 'FCT', markets: ['Wuse Market', 'Garki Market', 'Kuje Market', 'Dei-Dei Market']),
    NigerianState(name: 'Gombe', markets: ['Gombe Main Market', 'Pantami Market', 'Malam Inna Market']),
    NigerianState(name: 'Imo', markets: ['Ekeonuwa Market', 'Relief Market', 'Orie Market']),
    NigerianState(name: 'Jigawa', markets: ['Dutse Market', 'Hadejia Market', 'Ringim Market']),
    NigerianState(name: 'Kaduna', markets: ['Kaduna Central Market', 'Kasuan Magani', 'Sabon Gari Market']),
    NigerianState(name: 'Kano', markets: ['Kurmi Market', 'Sabon Gari Market', 'Dawanau Market', 'Singa Market']),
    NigerianState(name: 'Katsina', markets: ['Katsina Main Market', 'Kofa Market', 'Yantukunya Market']),
    NigerianState(name: 'Kebbi', markets: ['Birnin Kebbi Market', 'Argungu Market', 'Zuru Market']),
    NigerianState(name: 'Kogi', markets: ['Lokoja Main Market', 'Anyigba Market', 'Okene Market']),
    NigerianState(name: 'Kwara', markets: ['Ilorin Main Market', 'Oja Oba Market', 'Mandate Market']),
    NigerianState(name: 'Lagos', markets: ['Computer Village', 'Alaba International Market', 'Trade Fair Complex', 'Balogun Market', 'Mile 12 Market']),
    NigerianState(name: 'Nasarawa', markets: ['Lafia Main Market', 'Mararaba Market', 'Karu Market']),
    NigerianState(name: 'Niger', markets: ['Minna Main Market', 'Bida Market', 'Kontagora Market']),
    NigerianState(name: 'Ogun', markets: ['Itoku Market', 'Kuto Market', 'Oke-Ilewo Market']),
    NigerianState(name: 'Ondo', markets: ['Akure Main Market', 'Oja Oba Market', 'Isinkan Market']),
    NigerianState(name: 'Osun', markets: ['Oja Oba Market', 'Dele Yes Sir Market', 'Igbona Market']),
    NigerianState(name: 'Oyo', markets: ['Bodija Market', 'Oja Oba Market', 'Sango Market', 'Gbagi Market']),
    NigerianState(name: 'Plateau', markets: ['Jos Main Market', 'Terminus Market', 'Katako Market']),
    NigerianState(name: 'Rivers', markets: ['Mile 1 Market', 'Oil Mill Market', 'Creek Road Market']),
    NigerianState(name: 'Sokoto', markets: ['Sokoto Main Market', 'Old Market', 'Tudun Wada Market']),
    NigerianState(name: 'Taraba', markets: ['Jalingo Main Market', 'Wukari Market', 'Mutum Biyu Market']),
    NigerianState(name: 'Yobe', markets: ['Damaturu Market', 'Potiskum Market', 'Ngetra Market']),
    NigerianState(name: 'Zamfara', markets: ['Gusau Market', 'Talata Mafara Market', 'Kaura Market']),
  ];

  // =========================================================================
  // MARKETS
  // =========================================================================
  static final List<Map<String, dynamic>> markets = [
    {
      'name': 'Alaba International Market',
      'location': 'Ojo, Lagos',
      'description': 'One of West Africa\'s largest electronics markets, specializing in home appliances, auto parts, and consumer electronics.',
      'rating': 4.3,
      'shopCount': 2,
    },
    {
      'name': 'Computer Village',
      'location': 'Ikeja, Lagos',
      'description': 'Nigeria\'s premier ICT market, known for cutting-edge gadgets, phones, computers, and accessories.',
      'rating': 4.6,
      'shopCount': 2,
    },
    {
      'name': 'Trade Fair Complex',
      'location': 'Badagry, Lagos',
      'description': 'A massive wholesale market complex featuring fabrics, beauty products, and general merchandise.',
      'rating': 4.1,
      'shopCount': 2,
    },
  ];

  // =========================================================================
  // SHOPS
  // =========================================================================
  static final List<Shop> shops = [
    Shop(
      id: 'shop_1',
      name: 'TechCity',
      category: 'Electronics',
      description: 'Premium electronics dealer offering the latest TVs, gaming consoles, speakers, and air conditioners at competitive prices. Authorized dealer for major brands.',
      location: 'Shop A12, Computer Village, Ikeja',
      city: 'Lagos',
      market: 'Computer Village',
      phone: '+234 802 345 6789',
      hours: 'Mon-Sat: 8AM-7PM, Sun: 10AM-4PM',
      shopNumber: 'A12',
      bannerGradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      rating: 4.8,
      reviewCount: 128,
      productCount: 4,
      images: [
        'assets/images/shops/techcity_1.jpg',
        'assets/images/shops/techcity_2.jpg',
        'assets/images/shops/techcity_3.jpg',
      ],
      verified: true,
    ),
    Shop(
      id: 'shop_2',
      name: 'PhoneHub',
      category: 'Phones',
      description: 'Your trusted source for flagship smartphones, accessories, and audio gear. We stock the latest releases from Apple, Samsung, and more.',
      location: 'Shop B5, Computer Village, Ikeja',
      city: 'Lagos',
      market: 'Computer Village',
      phone: '+234 803 456 7890',
      hours: 'Mon-Sat: 8:30AM-7PM, Sun: 11AM-4PM',
      shopNumber: 'B5',
      bannerGradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
      rating: 4.6,
      reviewCount: 95,
      productCount: 4,
      images: [
        'assets/images/shops/phonehub_1.jpg',
        'assets/images/shops/phonehub_2.jpg',
      ],
      verified: true,
    ),
    Shop(
      id: 'shop_3',
      name: 'GlobalFabrics',
      category: 'Fabrics',
      description: 'Exquisite African fabrics and lace materials sourced directly from top manufacturers. We offer Swiss lace, Vlisco Ankara, Senator materials, and Aso-Oke.',
      location: 'Shop C8, Trade Fair Complex, Badagry',
      city: 'Lagos',
      market: 'Trade Fair Complex',
      phone: '+234 805 678 9012',
      hours: 'Mon-Sat: 8AM-6PM',
      shopNumber: 'C8',
      bannerGradient: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)',
      rating: 4.5,
      reviewCount: 72,
      productCount: 4,
      images: [
        'assets/images/shops/globalfabrics_1.jpg',
        'assets/images/shops/globalfabrics_2.jpg',
      ],
      verified: true,
    ),
    Shop(
      id: 'shop_4',
      name: 'Kemis Home Appliances',
      category: 'Appliances',
      description: 'Quality home and kitchen appliances from trusted brands. We deliver freezers, fans, food processors, cookers, and more across Nigeria.',
      location: 'Shop D15, Alaba International Market, Ojo',
      city: 'Lagos',
      market: 'Alaba International Market',
      phone: '+234 806 789 0123',
      hours: 'Mon-Sat: 7AM-6:30PM, Sun: 12PM-4PM',
      shopNumber: 'D15',
      bannerGradient: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)',
      rating: 4.7,
      reviewCount: 84,
      productCount: 4,
      images: [
        'assets/images/shops/kemis_1.jpg',
        'assets/images/shops/kemis_2.jpg',
      ],
      verified: true,
    ),
    Shop(
      id: 'shop_5',
      name: 'AutoParts Pro',
      category: 'Auto',
      description: 'Reliable auto parts and accessories for all vehicle makes. From shock absorbers to tyres, spark plugs to brake pads — we keep you moving.',
      location: 'Shop E7, Alaba International Market, Ojo',
      city: 'Lagos',
      market: 'Alaba International Market',
      phone: '+234 807 890 1234',
      hours: 'Mon-Sat: 7:30AM-6PM, Sun: 10AM-3PM',
      shopNumber: 'E7',
      bannerGradient: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)',
      rating: 4.4,
      reviewCount: 56,
      productCount: 4,
      images: [
        'assets/images/shops/autoparts_1.jpg',
        'assets/images/shops/autoparts_2.jpg',
      ],
      verified: true,
    ),
    Shop(
      id: 'shop_6',
      name: 'BeautyGlow Studio',
      category: 'Beauty',
      description: 'Premium beauty and skincare products. We curate the best foundations, facial mists, lipsticks, and cleansers from top beauty brands.',
      location: 'Shop F3, Trade Fair Complex, Badagry',
      city: 'Lagos',
      market: 'Trade Fair Complex',
      phone: '+234 808 901 2345',
      hours: 'Mon-Sat: 9AM-7PM, Sun: 12PM-5PM',
      shopNumber: 'F3',
      bannerGradient: 'linear-gradient(135deg, #fccb90 0%, #d57eeb 100%)',
      rating: 4.2,
      reviewCount: 43,
      productCount: 4,
      images: [
        'assets/images/shops/beautyglow_1.jpg',
        'assets/images/shops/beautyglow_2.jpg',
      ],
      verified: false,
    ),
  ];

  // =========================================================================
  // PRODUCTS - 24 products across 6 shops
  // =========================================================================
  static final List<Product> products = [
    // --- TechCity (shop_1) ---
    Product(
      id: 'prod_1',
      shopId: 'shop_1',
      name: 'Samsung 55" 4K Smart TV',
      description: 'Ultra HD 4K Smart TV with HDR10+, built-in streaming apps, and voice control. Perfect for your living room entertainment.',
      category: 'Electronics',
      price: 450000,
      imageUrl: 'assets/images/products/tv.jpg',
      inStock: true,
      rating: 4.7,
      reviewCount: 34,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'var_1a', name: '55" 4K', type: 'Size', value: '55"', priceAdjustment: 0, stock: 10),
        ProductVariant(id: 'var_1b', name: '65" 4K', type: 'Size', value: '65"', priceAdjustment: 120000, stock: 5),
        ProductVariant(id: 'var_1c', name: '43" 4K', type: 'Size', value: '43"', priceAdjustment: -80000, stock: 8),
      ],
    ),
    Product(
      id: 'prod_2',
      shopId: 'shop_1',
      name: 'Sony PlayStation 5',
      description: 'PS5 console with DualSense wireless controller, 825GB SSD, 4K Blu-ray drive. Experience lightning-fast loading and haptic feedback.',
      category: 'Electronics',
      price: 380000,
      imageUrl: 'assets/images/products/ps5.jpg',
      inStock: true,
      rating: 4.9,
      reviewCount: 52,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'var_2a', name: 'Standard', type: 'Edition', value: 'Standard', priceAdjustment: 0, stock: 7),
        ProductVariant(id: 'var_2b', name: 'Digital', type: 'Edition', value: 'Digital', priceAdjustment: -30000, stock: 4),
      ],
    ),
    Product(
      id: 'prod_3',
      shopId: 'shop_1',
      name: 'JBL PartyBox 310',
      description: 'Portable Bluetooth party speaker with powerful JBL Pro Sound, 18-hour battery life, and dynamic light show.',
      category: 'Electronics',
      price: 210000,
      imageUrl: 'assets/images/products/jbl.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 28,
      shopName: 'TechCity',
    ),
    Product(
      id: 'prod_4',
      shopId: 'shop_1',
      name: 'LG 1.5HP Split AC',
      description: 'Inverter split air conditioner with dual cooling, energy-saving mode, and smart WiFi control. Quiet operation at just 26dB.',
      category: 'Electronics',
      price: 185000,
      imageUrl: 'assets/images/products/ac.jpg',
      inStock: true,
      rating: 4.5,
      reviewCount: 19,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'var_4a', name: '1.5HP', type: 'Capacity', value: '1.5HP', priceAdjustment: 0, stock: 12),
        ProductVariant(id: 'var_4b', name: '2HP', type: 'Capacity', value: '2HP', priceAdjustment: 45000, stock: 6),
      ],
    ),

    // --- PhoneHub (shop_2) ---
    Product(
      id: 'prod_5',
      shopId: 'shop_2',
      name: 'iPhone 15 Pro Max',
      description: 'Apple\'s flagship with A17 Pro chip, 48MP camera system, titanium design, and all-day battery life.',
      category: 'Phones',
      price: 1250000,
      imageUrl: 'assets/images/products/iphone15pm.jpg',
      inStock: true,
      rating: 4.8,
      reviewCount: 41,
      shopName: 'PhoneHub',
      variants: [
        ProductVariant(id: 'var_5a', name: '256GB', type: 'Storage', value: '256GB', priceAdjustment: 0, stock: 5),
        ProductVariant(id: 'var_5b', name: '512GB', type: 'Storage', value: '512GB', priceAdjustment: 150000, stock: 3),
        ProductVariant(id: 'var_5c', name: '1TB', type: 'Storage', value: '1TB', priceAdjustment: 350000, stock: 2),
      ],
    ),
    Product(
      id: 'prod_6',
      shopId: 'shop_2',
      name: 'Samsung Galaxy S24 Ultra',
      description: 'Galaxy AI-powered smartphone with 200MP camera, S Pen, titanium frame, and Snapdragon 8 Gen 3 processor.',
      category: 'Phones',
      price: 1150000,
      imageUrl: 'assets/images/products/s24ultra.jpg',
      inStock: true,
      rating: 4.7,
      reviewCount: 36,
      shopName: 'PhoneHub',
      variants: [
        ProductVariant(id: 'var_6a', name: '256GB', type: 'Storage', value: '256GB', priceAdjustment: 0, stock: 6),
        ProductVariant(id: 'var_6b', name: '512GB', type: 'Storage', value: '512GB', priceAdjustment: 100000, stock: 4),
      ],
    ),
    Product(
      id: 'prod_7',
      shopId: 'shop_2',
      name: 'Samsung Freepods Pro',
      description: 'True wireless earbuds with active noise cancellation, ambient sound, touch controls, and wireless charging case.',
      category: 'Phones',
      price: 25000,
      imageUrl: 'assets/images/products/freepods.jpg',
      inStock: true,
      rating: 4.3,
      reviewCount: 18,
      shopName: 'PhoneHub',
    ),
    Product(
      id: 'prod_8',
      shopId: 'shop_2',
      name: 'Anker Power Bank 20000mAh',
      description: 'High-capacity portable charger with dual USB-C ports, 60W fast charging, and digital display. Charges laptops and phones.',
      category: 'Phones',
      price: 18500,
      imageUrl: 'assets/images/products/powerbank.jpg',
      inStock: true,
      rating: 4.4,
      reviewCount: 22,
      shopName: 'PhoneHub',
    ),

    // --- GlobalFabrics (shop_3) ---
    Product(
      id: 'prod_9',
      shopId: 'shop_3',
      name: 'Premium Swiss Lace',
      description: 'High-quality Swiss lace fabric perfect for special occasions. Intricate patterns with delicatedetails.',
      category: 'Fabrics',
      price: 35000,
      imageUrl: 'assets/images/products/swiss_lace.jpg',
      inStock: true,
      rating: 4.8,
      reviewCount: 31,
      shopName: 'GlobalFabrics',
      variants: [
        ProductVariant(id: 'var_9a', name: 'White', type: 'Color', value: 'White', priceAdjustment: 0, stock: 15),
        ProductVariant(id: 'var_9b', name: 'Ivory', type: 'Color', value: 'Ivory', priceAdjustment: 2000, stock: 10),
        ProductVariant(id: 'var_9c', name: 'Champagne', type: 'Color', value: 'Champagne', priceAdjustment: 3000, stock: 8),
      ],
    ),
    Product(
      id: 'prod_10',
      shopId: 'shop_3',
      name: 'Vlisco Ankara',
      description: 'Authentic Vlisco Dutch wax print fabric. Vibrant colors and unique patterns that celebrate African heritage.',
      category: 'Fabrics',
      price: 28000,
      imageUrl: 'assets/images/products/vlisco_ankara.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 25,
      shopName: 'GlobalFabrics',
      variants: [
        ProductVariant(id: 'var_10a', name: 'Blue Sapphire', type: 'Pattern', value: 'Blue Sapphire', priceAdjustment: 0, stock: 12),
        ProductVariant(id: 'var_10b', name: 'Red Coral', type: 'Pattern', value: 'Red Coral', priceAdjustment: 0, stock: 10),
        ProductVariant(id: 'var_10c', name: 'Green Emerald', type: 'Pattern', value: 'Green Emerald', priceAdjustment: 0, stock: 8),
      ],
    ),
    Product(
      id: 'prod_11',
      shopId: 'shop_3',
      name: 'Senator Fabric',
      description: 'Premium Senator fabric for tailored outfits. Smooth texture with elegant sheen, perfect for office and formal wear.',
      category: 'Fabrics',
      price: 15000,
      imageUrl: 'assets/images/products/senator.jpg',
      inStock: true,
      rating: 4.4,
      reviewCount: 16,
      shopName: 'GlobalFabrics',
      variants: [
        ProductVariant(id: 'var_11a', name: 'Black', type: 'Color', value: 'Black', priceAdjustment: 0, stock: 20),
        ProductVariant(id: 'var_11b', name: 'Navy', type: 'Color', value: 'Navy', priceAdjustment: 0, stock: 15),
        ProductVariant(id: 'var_11c', name: 'Grey', type: 'Color', value: 'Grey', priceAdjustment: 0, stock: 12),
      ],
    ),
    Product(
      id: 'prod_12',
      shopId: 'shop_3',
      name: 'Aso-Oke (Handwoven)',
      description: 'Traditional handwoven Aso-Oke fabric made by skilled artisans. Rich textures and authentic Yoruba weaving patterns.',
      category: 'Fabrics',
      price: 12000,
      imageUrl: 'assets/images/products/aso_oke.jpg',
      inStock: true,
      rating: 4.7,
      reviewCount: 20,
      shopName: 'GlobalFabrics',
      variants: [
        ProductVariant(id: 'var_12a', name: 'Gold & Burgundy', type: 'Design', value: 'Gold & Burgundy', priceAdjustment: 0, stock: 6),
        ProductVariant(id: 'var_12b', name: 'Blue & Silver', type: 'Design', value: 'Blue & Silver', priceAdjustment: 1000, stock: 5),
      ],
    ),

    // --- Kemis Home Appliances (shop_4) ---
    Product(
      id: 'prod_13',
      shopId: 'shop_4',
      name: 'Thermocool Chest Freezer 300L',
      description: 'Energy-efficient chest freezer with 300L capacity, quick-freeze function, and adjustable thermostat. Ideal for commercial use.',
      category: 'Appliances',
      price: 285000,
      imageUrl: 'assets/images/products/freezer.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 23,
      shopName: 'Kemis Home Appliances',
      variants: [
        ProductVariant(id: 'var_13a', name: '300L', type: 'Capacity', value: '300L', priceAdjustment: 0, stock: 5),
        ProductVariant(id: 'var_13b', name: '500L', type: 'Capacity', value: '500L', priceAdjustment: 95000, stock: 3),
      ],
    ),
    Product(
      id: 'prod_14',
      shopId: 'shop_4',
      name: 'Maya Standing Fan 20"',
      description: 'Heavy-duty oscillating standing fan with 3 speed settings, adjustable height, and whisper-quiet motor.',
      category: 'Appliances',
      price: 45000,
      imageUrl: 'assets/images/products/fan.jpg',
      inStock: true,
      rating: 4.3,
      reviewCount: 15,
      shopName: 'Kemis Home Appliances',
      variants: [
        ProductVariant(id: 'var_14a', name: '20" Standing', type: 'Size', value: '20"', priceAdjustment: 0, stock: 20),
        ProductVariant(id: 'var_14b', name: '24" Standing', type: 'Size', value: '24"', priceAdjustment: 10000, stock: 12),
      ],
    ),
    Product(
      id: 'prod_15',
      shopId: 'shop_4',
      name: 'Moulinex Food Processor',
      description: 'Powerful 1000W food processor with 5L bowl, multiple blades, and pulse function. Chop, blend, and puree with ease.',
      category: 'Appliances',
      price: 85000,
      imageUrl: 'assets/images/products/processor.jpg',
      inStock: true,
      rating: 4.5,
      reviewCount: 18,
      shopName: 'Kemis Home Appliances',
    ),
    Product(
      id: 'prod_16',
      shopId: 'shop_4',
      name: 'Scanfrost Gas Cooker 4-Burner',
      description: 'Stainless steel gas cooker with 4 burners, oven, and grill. Auto-ignition and energy-efficient design.',
      category: 'Appliances',
      price: 32000,
      imageUrl: 'assets/images/products/cooker.jpg',
      inStock: true,
      rating: 4.4,
      reviewCount: 21,
      shopName: 'Kemis Home Appliances',
    ),

    // --- AutoParts Pro (shop_5) ---
    Product(
      id: 'prod_17',
      shopId: 'shop_5',
      name: 'Gabriel Shock Absorbers (Pair)',
      description: 'Premium hydraulic shock absorbers for smooth ride quality. Compatible with Toyota, Honda, and Nissan vehicles.',
      category: 'Auto',
      price: 42000,
      imageUrl: 'assets/images/products/shock.jpg',
      inStock: true,
      rating: 4.3,
      reviewCount: 14,
      shopName: 'AutoParts Pro',
      variants: [
        ProductVariant(id: 'var_17a', name: 'Front Pair', type: 'Position', value: 'Front', priceAdjustment: 0, stock: 8),
        ProductVariant(id: 'var_17b', name: 'Rear Pair', type: 'Position', value: 'Rear', priceAdjustment: 0, stock: 10),
      ],
    ),
    Product(
      id: 'prod_18',
      shopId: 'shop_5',
      name: 'Michelin Tyres 205/55R16',
      description: 'All-season radial tyres with enhanced grip, low road noise, and long tread life. Set of 4.',
      category: 'Auto',
      price: 65000,
      imageUrl: 'assets/images/products/tyres.jpg',
      inStock: true,
      rating: 4.5,
      reviewCount: 17,
      shopName: 'AutoParts Pro',
    ),
    Product(
      id: 'prod_19',
      shopId: 'shop_5',
      name: 'NGK Spark Plugs (Set of 4)',
      description: 'Iridium spark plugs for improved ignition, fuel efficiency, and engine performance. Universal fitment.',
      category: 'Auto',
      price: 12000,
      imageUrl: 'assets/images/products/spark_plugs.jpg',
      inStock: true,
      rating: 4.2,
      reviewCount: 11,
      shopName: 'AutoParts Pro',
    ),
    Product(
      id: 'prod_20',
      shopId: 'shop_5',
      name: 'Bosch Ceramic Brake Pads',
      description: 'High-performance ceramic brake pads with low dust and quiet braking. Compatible with most sedans and SUVs.',
      category: 'Auto',
      price: 18500,
      imageUrl: 'assets/images/products/brake_pads.jpg',
      inStock: true,
      rating: 4.4,
      reviewCount: 13,
      shopName: 'AutoParts Pro',
    ),

    // --- BeautyGlow Studio (shop_6) ---
    Product(
      id: 'prod_21',
      shopId: 'shop_6',
      name: 'Fenty Beauty Pro Filt\'r Foundation',
      description: 'Soft matte, long-wear foundation with 50 shades. Buildable medium-to-full coverage that looks like skin.',
      category: 'Beauty',
      price: 38000,
      imageUrl: 'assets/images/products/foundation.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 27,
      shopName: 'BeautyGlow Studio',
      variants: [
        ProductVariant(id: 'var_21a', name: '#420', type: 'Shade', value: '#420', priceAdjustment: 0, stock: 8),
        ProductVariant(id: 'var_21b', name: '#360', type: 'Shade', value: '#360', priceAdjustment: 0, stock: 6),
        ProductVariant(id: 'var_21c', name: '#440', type: 'Shade', value: '#440', priceAdjustment: 0, stock: 5),
      ],
    ),
    Product(
      id: 'prod_22',
      shopId: 'shop_6',
      name: 'MAC Fix+ Setting Mist',
      description: 'Multi-tasking setting spray that refreshes, hydrates, and finishes makeup. Infused with green tea and cucumber extracts.',
      category: 'Beauty',
      price: 15000,
      imageUrl: 'assets/images/products/mist.jpg',
      inStock: true,
      rating: 4.4,
      reviewCount: 19,
      shopName: 'BeautyGlow Studio',
    ),
    Product(
      id: 'prod_23',
      shopId: 'shop_6',
      name: 'Charlotte Tilbury Matte Revolution Lipstick',
      description: 'K.I.S.S.I.N.G lipstick with hyaluronic acid for plump, hydrated lips. Iconic matte finish in Pillow Talk.',
      category: 'Beauty',
      price: 18500,
      imageUrl: 'assets/images/products/lipstick.jpg',
      inStock: true,
      rating: 4.7,
      reviewCount: 33,
      shopName: 'BeautyGlow Studio',
      variants: [
        ProductVariant(id: 'var_23a', name: 'Pillow Talk', type: 'Shade', value: 'Pillow Talk', priceAdjustment: 0, stock: 10),
        ProductVariant(id: 'var_23b', name: 'Walk of No Shame', type: 'Shade', value: 'Walk of No Shame', priceAdjustment: 0, stock: 7),
        ProductVariant(id: 'var_23c', name: 'Very Victoria', type: 'Shade', value: 'Very Victoria', priceAdjustment: 0, stock: 5),
      ],
    ),
    Product(
      id: 'prod_24',
      shopId: 'shop_6',
      name: 'CeraVe Hydrating Facial Cleanser',
      description: 'Non-foaming hydrating cleanser with ceramides and hyaluronic acid. Gently cleanses without stripping the skin barrier.',
      category: 'Beauty',
      price: 12500,
      imageUrl: 'assets/images/products/cleanser.jpg',
      inStock: true,
      rating: 4.5,
      reviewCount: 24,
      shopName: 'BeautyGlow Studio',
    ),
  ];

  // =========================================================================
  // REVIEWS - 30 reviews (5 per shop)
  // =========================================================================
  static final List<Review> reviews = [
    // TechCity
    Review(id: 'rev_1', userName: 'Chidi Okonkwo', comment: 'Bought a PS5 from here. Best price in Lagos and they delivered same day!', rating: 5.0, date: DateTime(2026, 7, 20), reply: 'Thanks Chidi! Enjoy your PS5 🎮'),
    Review(id: 'rev_2', userName: 'Funmi Adebayo', comment: 'The TV I ordered was well packaged and the picture quality is amazing.', rating: 5.0, date: DateTime(2026, 7, 18)),
    Review(id: 'rev_3', userName: 'Emeka Nwosu', comment: 'Great customer service. They helped me pick the right AC for my apartment.', rating: 4.5, date: DateTime(2026, 7, 15)),
    Review(id: 'rev_4', userName: 'Sarah Ibrahim', comment: 'JBL speaker is fire! The bass is incredible for parties.', rating: 5.0, date: DateTime(2026, 7, 10)),
    Review(id: 'rev_5', userName: 'Tunde Ogunlesi', comment: 'Good prices but delivery took longer than expected.', rating: 4.0, date: DateTime(2026, 7, 5)),

    // PhoneHub
    Review(id: 'rev_6', userName: 'Amara Okafor', comment: 'Got my iPhone 15 Pro Max here. Authentic product with full warranty!', rating: 5.0, date: DateTime(2026, 7, 22)),
    Review(id: 'rev_7', userName: 'Yusuf Bello', comment: 'S24 Ultra at a great price. The AI features are mind-blowing.', rating: 4.5, date: DateTime(2026, 7, 19)),
    Review(id: 'rev_8', userName: 'Chioma Eze', comment: 'Freepods are comfortable and the ANC works really well.', rating: 4.0, date: DateTime(2026, 7, 14)),
    Review(id: 'rev_9', userName: 'David James', comment: 'The power bank is a lifesaver. Charges my MacBook too!', rating: 5.0, date: DateTime(2026, 7, 8)),
    Review(id: 'rev_10', userName: 'Ngozi Okoro', comment: 'Staff were knowledgeable and helpful. Will definitely return.', rating: 4.5, date: DateTime(2026, 7, 3)),

    // GlobalFabrics
    Review(id: 'rev_11', userName: 'Bisi Ogun', comment: 'The Swiss lace is absolutely stunning. Used it for my wedding dress!', rating: 5.0, date: DateTime(2026, 7, 21)),
    Review(id: 'rev_12', userName: 'Halima Abubakar', comment: 'Authentic Vlisco Ankara with vibrant colors. Love it!', rating: 5.0, date: DateTime(2026, 7, 17)),
    Review(id: 'rev_13', userName: 'Kelechi Nwoke', comment: 'Senator fabric is perfect for my office suits. Great quality.', rating: 4.5, date: DateTime(2026, 7, 12)),
    Review(id: 'rev_14', userName: 'Yetunde Akinwale', comment: 'The Aso-Oke is beautifully woven. Very authentic.', rating: 5.0, date: DateTime(2026, 7, 7)),
    Review(id: 'rev_15', userName: 'Ahmed Musa', comment: 'Wide variety of fabrics. The staff helped me pick great combinations.', rating: 4.0, date: DateTime(2026, 7, 2)),

    // Kemis Home Appliances
    Review(id: 'rev_16', userName: 'Grace Okon', comment: 'The freezer is massive and energy-efficient. Perfect for my provisions store.', rating: 5.0, date: DateTime(2026, 7, 23)),
    Review(id: 'rev_17', userName: 'Ibrahim Danjuma', comment: 'Standing fan is very powerful yet quiet. Keeps my shop cool.', rating: 4.5, date: DateTime(2026, 7, 20)),
    Review(id: 'rev_18', userName: 'Ronke Adegoke', comment: 'Food processor is a game changer in my kitchen. Worth every naira.', rating: 5.0, date: DateTime(2026, 7, 16)),
    Review(id: 'rev_19', userName: 'Michael Idowu', comment: 'The gas cooker works perfectly. Oven bakes evenly.', rating: 4.5, date: DateTime(2026, 7, 11)),
    Review(id: 'rev_20', userName: 'Fatima Umar', comment: 'Good products but the shop was a bit hard to find.', rating: 4.0, date: DateTime(2026, 7, 6)),

    // AutoParts Pro
    Review(id: 'rev_21', userName: 'Ejiro Oke', comment: 'Shock absorbers transformed my car\'s ride quality. Highly recommend.', rating: 5.0, date: DateTime(2026, 7, 22)),
    Review(id: 'rev_22', userName: 'Segun Adewale', comment: 'Michelin tyres are top quality. Great grip on wet roads.', rating: 4.5, date: DateTime(2026, 7, 18)),
    Review(id: 'rev_23', userName: 'Nnenna Obi', comment: 'Spark plugs arrived quickly. My car runs smoother now.', rating: 4.0, date: DateTime(2026, 7, 13)),
    Review(id: 'rev_24', userName: 'Tobi Akinola', comment: 'Brake pads are quiet and effective. Great value for money.', rating: 4.5, date: DateTime(2026, 7, 9)),
    Review(id: 'rev_25', userName: 'Rashidat Bello', comment: 'Knowledgeable staff. They helped me find the right parts for my Corolla.', rating: 4.0, date: DateTime(2026, 7, 4)),

    // BeautyGlow Studio
    Review(id: 'rev_26', userName: 'Temilade Fadipe', comment: 'Fenty foundation shade match was perfect. My new go-to store!', rating: 5.0, date: DateTime(2026, 7, 21)),
    Review(id: 'rev_27', userName: 'Zainab Abdullah', comment: 'MAC Fix+ is amazing. My makeup stays all day now.', rating: 4.5, date: DateTime(2026, 7, 17)),
    Review(id: 'rev_28', userName: 'Lola Ajayi', comment: 'Pillow Talk lipstick is as beautiful as everyone says. Love it!', rating: 5.0, date: DateTime(2026, 7, 12)),
    Review(id: 'rev_29', userName: 'Chinenye Ugwu', comment: 'CeraVe cleanser is gentle and effective. My acne has cleared up.', rating: 4.5, date: DateTime(2026, 7, 8)),
    Review(id: 'rev_30', userName: 'Hauwa Mohammed', comment: 'Good products but prices are a bit on the high side.', rating: 3.5, date: DateTime(2026, 7, 3)),
  ];

  // =========================================================================
  // CART ITEMS
  // =========================================================================
  static final List<CartItem> cartItems = [
    CartItem(product: ProductWithShop(id: 'prod_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, inStock: true, rating: 4.7, reviewCount: 34, shopName: 'TechCity'), variant: '55" 4K', quantity: 1),
    CartItem(product: ProductWithShop(id: 'prod_5', shopId: 'shop_2', name: 'iPhone 15 Pro Max', category: 'Phones', price: 1250000, inStock: true, rating: 4.8, reviewCount: 41, shopName: 'PhoneHub'), variant: '256GB', quantity: 1),
    CartItem(product: ProductWithShop(id: 'prod_8', shopId: 'shop_2', name: 'Anker Power Bank 20000mAh', category: 'Phones', price: 18500, inStock: true, rating: 4.4, reviewCount: 19, shopName: 'PhoneHub'), variant: 'White', quantity: 2),
  ];

  // =========================================================================
  // ORDERS
  // =========================================================================
  static final Address defaultAddress = Address(
    firstName: 'Chidi',
    lastName: 'Okeke',
    phone: '+234 802 222 3333',
    street: '42 Awolowo Road, Ikoyi',
    city: 'Lagos',
    state: 'Lagos',
  );

  static final List<Order> orders = [
    Order(
      id: 'ord_1',
      orderNumber: 'MM-2026-001',
      placedAt: DateTime(2026, 7, 25, 10, 30),
      status: OrderStatus.delivered,
      deliveryMethod: 'Standard Delivery',
      paymentMethod: 'Cash on Delivery',
      items: [
        OrderItem(productId: 'prod_2', name: 'Sony PlayStation 5', variant: 'Standard', price: 380000, quantity: 1),
        OrderItem(productId: 'prod_7', name: 'Samsung Freepods Pro', variant: '', price: 25000, quantity: 2),
      ],
      subtotal: 430000,
      deliveryFee: 2500,
      total: 432500,
      address: defaultAddress,
      estimatedDelivery: DateTime(2026, 7, 28),
    ),
    Order(
      id: 'ord_2',
      orderNumber: 'MM-2026-002',
      placedAt: DateTime(2026, 7, 27, 14, 15),
      status: OrderStatus.outForDelivery,
      deliveryMethod: 'Express Delivery',
      paymentMethod: 'Card Payment',
      items: [
        OrderItem(productId: 'prod_9', name: 'Premium Swiss Lace', variant: 'Ivory', price: 37000, quantity: 1),
        OrderItem(productId: 'prod_10', name: 'Vlisco Ankara', variant: 'Blue Sapphire', price: 28000, quantity: 2),
      ],
      subtotal: 93000,
      deliveryFee: 3500,
      total: 96500,
      address: defaultAddress,
      estimatedDelivery: DateTime(2026, 7, 28),
    ),
    Order(
      id: 'ord_3',
      orderNumber: 'MM-2026-003',
      placedAt: DateTime(2026, 7, 28, 9, 0),
      status: OrderStatus.packing,
      deliveryMethod: 'Standard Delivery',
      paymentMethod: 'Cash on Delivery',
      items: [
        OrderItem(productId: 'prod_5', name: 'iPhone 15 Pro Max', variant: '256GB', price: 1250000, quantity: 1),
        OrderItem(productId: 'prod_8', name: 'Anker Power Bank 20000mAh', variant: '', price: 18500, quantity: 1),
      ],
      subtotal: 1268500,
      deliveryFee: 0,
      total: 1268500,
      address: defaultAddress,
      estimatedDelivery: DateTime(2026, 7, 31),
    ),
    Order(
      id: 'ord_4',
      orderNumber: 'MM-2026-004',
      placedAt: DateTime(2026, 7, 26, 16, 45),
      status: OrderStatus.confirmed,
      deliveryMethod: 'Standard Delivery',
      paymentMethod: 'Transfer',
      items: [
        OrderItem(productId: 'prod_13', name: 'Thermocool Chest Freezer 300L', variant: '300L', price: 285000, quantity: 1),
      ],
      subtotal: 285000,
      deliveryFee: 5000,
      total: 290000,
      address: defaultAddress,
      estimatedDelivery: DateTime(2026, 8, 1),
    ),
    Order(
      id: 'ord_5',
      orderNumber: 'MM-2026-005',
      placedAt: DateTime(2026, 7, 20, 11, 20),
      status: OrderStatus.cancelled,
      deliveryMethod: 'Standard Delivery',
      paymentMethod: 'Cash on Delivery',
      items: [
        OrderItem(productId: 'prod_17', name: 'Gabriel Shock Absorbers (Pair)', variant: 'Front Pair', price: 42000, quantity: 2),
        OrderItem(productId: 'prod_18', name: 'Michelin Tyres 205/55R16', variant: '', price: 65000, quantity: 4),
      ],
      subtotal: 344000,
      deliveryFee: 3000,
      total: 347000,
      address: defaultAddress,
      cancellationReason: 'Changed mind - found better deal elsewhere',
    ),
  ];

  // =========================================================================
  // CONVERSATIONS (Buyer)
  // =========================================================================
  static final List<BuyerConversation> conversations = [
    BuyerConversation(id: 'conv_1', shopId: 'shop_1', shopName: 'TechCity', category: 'Electronics', lastMessage: 'Yes, we have the PS5 in stock!', time: '2m ago', unread: 2, online: true),
    BuyerConversation(id: 'conv_2', shopId: 'shop_2', shopName: 'PhoneHub', category: 'Phones', lastMessage: 'The iPhone 15 Pro Max comes with 1-year warranty.', time: '1h ago', unread: 0, online: true),
    BuyerConversation(id: 'conv_3', shopId: 'shop_3', shopName: 'GlobalFabrics', category: 'Fabrics', lastMessage: 'Swiss lace available in white, ivory, and champagne.', time: '3h ago', unread: 1, online: false),
    BuyerConversation(id: 'conv_4', shopId: 'shop_4', shopName: 'Kemis Home Appliances', category: 'Appliances', lastMessage: 'Delivery takes 2-3 business days.', time: '1d ago', unread: 0, online: false),
  ];

  // =========================================================================
  // NOTIFICATIONS (Buyer)
  // =========================================================================
  static final List<AppNotification> buyerNotifications = [
    AppNotification(id: 'notif_b1', type: 'order', title: 'Order Delivered', message: 'Your PS5 from TechCity has been delivered.', time: DateTime(2026, 7, 28, 14, 30), read: true, link: '/orders/ord_1'),
    AppNotification(id: 'notif_b2', type: 'shipping', title: 'Out for Delivery', message: 'Your Swiss Lace order is out for delivery today.', time: DateTime(2026, 7, 28, 8, 15), read: false, link: '/orders/ord_2'),
    AppNotification(id: 'notif_b3', type: 'promo', title: 'Flash Sale Alert', message: 'TechCity has a 24-hour flash sale! Up to 20% off.', time: DateTime(2026, 7, 27, 18, 0), read: false, link: '/shop/shop_1'),
    AppNotification(id: 'notif_b4', type: 'order', title: 'Order Confirmed', message: 'Your order #MM-2026-004 has been confirmed.', time: DateTime(2026, 7, 26, 17, 0), read: true, link: '/orders/ord_4'),
    AppNotification(id: 'notif_b5', type: 'system', title: 'Welcome to Market Mirror', message: 'Thank you for joining. Start exploring shops near you!', time: DateTime(2026, 7, 15, 9, 0), read: true),
  ];

  // =========================================================================
  // DISPUTES
  // =========================================================================
  static final List<Dispute> disputes = [
    Dispute(id: 'disp_1', orderId: 'ord_5', reason: 'Cancellation not processed', description: 'I cancelled my order but the refund hasn\'t been processed yet.', status: 'open', createdAt: DateTime(2026, 7, 22)),
    Dispute(id: 'disp_2', orderId: 'ord_1', reason: 'Damaged item', description: 'The PS5 box was slightly damaged upon delivery but the console works fine.', status: 'resolved', createdAt: DateTime(2026, 7, 28)),
  ];

  // =========================================================================
  // VENDOR-SPECIFIC MOCK DATA
  // =========================================================================
  static final List<Product> vendorProducts = [
    Product(
      id: 'vp_1',
      shopId: 'shop_1',
      name: 'Samsung 55" 4K Smart TV',
      description: 'Ultra HD 4K Smart TV with HDR10+, built-in streaming apps.',
      category: 'Electronics',
      price: 450000,
      imageUrl: 'assets/images/products/tv.jpg',
      inStock: true,
      rating: 4.7,
      reviewCount: 34,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'vvar_1a', name: '55" 4K', type: 'Size', value: '55"', priceAdjustment: 0, stock: 10),
        ProductVariant(id: 'vvar_1b', name: '65" 4K', type: 'Size', value: '65"', priceAdjustment: 120000, stock: 5),
      ],
    ),
    Product(
      id: 'vp_2',
      shopId: 'shop_1',
      name: 'Sony PlayStation 5',
      description: 'PS5 console with DualSense controller and 825GB SSD.',
      category: 'Electronics',
      price: 380000,
      imageUrl: 'assets/images/products/ps5.jpg',
      inStock: true,
      rating: 4.9,
      reviewCount: 52,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'vvar_2a', name: 'Standard', type: 'Edition', value: 'Standard', priceAdjustment: 0, stock: 7),
      ],
    ),
    Product(
      id: 'vp_3',
      shopId: 'shop_1',
      name: 'JBL PartyBox 310',
      description: 'Portable Bluetooth party speaker with 18-hour battery life.',
      category: 'Electronics',
      price: 210000,
      imageUrl: 'assets/images/products/jbl.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 28,
      shopName: 'TechCity',
    ),
    Product(
      id: 'vp_4',
      shopId: 'shop_1',
      name: 'LG 1.5HP Split AC',
      description: 'Inverter split air conditioner with smart WiFi control.',
      category: 'Electronics',
      price: 185000,
      imageUrl: 'assets/images/products/ac.jpg',
      inStock: true,
      rating: 4.5,
      reviewCount: 19,
      shopName: 'TechCity',
    ),
    Product(
      id: 'vp_5',
      shopId: 'shop_1',
      name: 'Apple MacBook Air M3',
      description: 'Latest MacBook Air with M3 chip, 16GB RAM, 512GB SSD.',
      category: 'Electronics',
      price: 950000,
      imageUrl: 'assets/images/products/macbook.jpg',
      inStock: false,
      rating: 4.8,
      reviewCount: 15,
      shopName: 'TechCity',
      variants: [
        ProductVariant(id: 'vvar_5a', name: '512GB', type: 'Storage', value: '512GB', priceAdjustment: 0, stock: 0),
        ProductVariant(id: 'vvar_5b', name: '1TB', type: 'Storage', value: '1TB', priceAdjustment: 150000, stock: 0),
      ],
    ),
    Product(
      id: 'vp_6',
      shopId: 'shop_1',
      name: 'Dell XPS 15 Laptop',
      description: 'Premium laptop with Intel i9, 32GB RAM, RTX 4060.',
      category: 'Electronics',
      price: 720000,
      imageUrl: 'assets/images/products/dell_xps.jpg',
      inStock: true,
      rating: 4.6,
      reviewCount: 11,
      shopName: 'TechCity',
    ),
  ];

  static final List<Order> vendorOrders = [
    Order(
      id: 'vord_1',
      orderNumber: 'MM-2026-001',
      placedAt: DateTime(2026, 7, 25, 10, 30),
      status: OrderStatus.delivered,
      deliveryMethod: 'Standard',
      paymentMethod: 'Cash on Delivery',
      items: [
        OrderItem(productId: 'prod_2', name: 'Sony PlayStation 5', variant: 'Standard', price: 380000, quantity: 1),
      ],
      subtotal: 380000,
      deliveryFee: 2500,
      total: 382500,
      address: defaultAddress,
      estimatedDelivery: DateTime(2026, 7, 28),
    ),
    Order(
      id: 'vord_2',
      orderNumber: 'MM-2026-002',
      placedAt: DateTime(2026, 7, 27, 14, 15),
      status: OrderStatus.outForDelivery,
      deliveryMethod: 'Express',
      paymentMethod: 'Card',
      items: [
        OrderItem(productId: 'prod_1', name: 'Samsung 55" 4K Smart TV', variant: '55" 4K', price: 450000, quantity: 1),
      ],
      subtotal: 450000,
      deliveryFee: 3500,
      total: 453500,
      address: Address(firstName: 'Amara', lastName: 'Okafor', phone: '+234 803 111 2222', street: '15 Admiralty Way, Lekki', city: 'Lagos', state: 'Lagos'),
      estimatedDelivery: DateTime(2026, 7, 29),
    ),
    Order(
      id: 'vord_3',
      orderNumber: 'MM-2026-003',
      placedAt: DateTime(2026, 7, 28, 11, 0),
      status: OrderStatus.packing,
      deliveryMethod: 'Standard',
      paymentMethod: 'Transfer',
      items: [
        OrderItem(productId: 'prod_3', name: 'JBL PartyBox 310', variant: '', price: 210000, quantity: 2),
        OrderItem(productId: 'prod_4', name: 'LG 1.5HP Split AC', variant: '1.5HP', price: 185000, quantity: 1),
      ],
      subtotal: 605000,
      deliveryFee: 4000,
      total: 609000,
      address: Address(firstName: 'Funmi', lastName: 'Adebayo', phone: '+234 805 555 6666', street: '8 Bourdillon Road, Ikoyi', city: 'Lagos', state: 'Lagos'),
      estimatedDelivery: DateTime(2026, 7, 31),
    ),
    Order(
      id: 'vord_4',
      orderNumber: 'MM-2026-004',
      placedAt: DateTime(2026, 7, 26, 16, 45),
      status: OrderStatus.confirmed,
      deliveryMethod: 'Standard',
      paymentMethod: 'Cash on Delivery',
      items: [
        OrderItem(productId: 'vp_6', name: 'Dell XPS 15 Laptop', variant: '', price: 720000, quantity: 1),
      ],
      subtotal: 720000,
      deliveryFee: 5000,
      total: 725000,
      address: Address(firstName: 'Emeka', lastName: 'Nwosu', phone: '+234 806 777 8888', street: '25 GRA Phase 2, Port Harcourt', city: 'Port Harcourt', state: 'Rivers'),
      estimatedDelivery: DateTime(2026, 8, 2),
    ),
  ];

  static final List<CustomerData> vendorCustomers = [
    CustomerData(id: 'cust_1', name: 'Chidi Okonkwo', email: 'chidi.okonkwo@email.com', phone: '+234 802 222 3333', address: '42 Awolowo Road, Ikoyi, Lagos', status: 'active', ordersCount: 3, totalSpend: 815000, lastOrder: DateTime(2026, 7, 25)),
    CustomerData(id: 'cust_2', name: 'Amara Okafor', email: 'amara.okafor@email.com', phone: '+234 803 111 2222', address: '15 Admiralty Way, Lekki, Lagos', status: 'active', ordersCount: 2, totalSpend: 535000, lastOrder: DateTime(2026, 7, 27)),
    CustomerData(id: 'cust_3', name: 'Funmi Adebayo', email: 'funmi.adebayo@email.com', phone: '+234 805 555 6666', address: '8 Bourdillon Road, Ikoyi, Lagos', status: 'active', ordersCount: 1, totalSpend: 609000, lastOrder: DateTime(2026, 7, 28)),
    CustomerData(id: 'cust_4', name: 'Emeka Nwosu', email: 'emeka.nwosu@email.com', phone: '+234 806 777 8888', address: '25 GRA Phase 2, Port Harcourt', status: 'active', ordersCount: 1, totalSpend: 725000, lastOrder: DateTime(2026, 7, 26)),
    CustomerData(id: 'cust_5', name: 'Sarah Ibrahim', email: 'sarah.ibrahim@email.com', phone: '+234 809 333 4444', address: '10 Ahmadu Bello Way, Abuja', status: 'inactive', ordersCount: 0, totalSpend: 0),
  ];

  static final List<AnalyticsDataPoint> vendorAnalytics = [
    AnalyticsDataPoint(label: 'Mon', value: 125000),
    AnalyticsDataPoint(label: 'Tue', value: 89000),
    AnalyticsDataPoint(label: 'Wed', value: 210000),
    AnalyticsDataPoint(label: 'Thu', value: 156000),
    AnalyticsDataPoint(label: 'Fri', value: 342000),
    AnalyticsDataPoint(label: 'Sat', value: 275000),
    AnalyticsDataPoint(label: 'Sun', value: 98000),
  ];

  static final List<Review> vendorReviews = [
    Review(id: 'vrev_1', userName: 'Chidi Okonkwo', comment: 'Bought a PS5 from here. Best price in Lagos!', rating: 5.0, date: DateTime(2026, 7, 20), reply: 'Thanks Chidi! Happy gaming 🎮'),
    Review(id: 'vrev_2', userName: 'Funmi Adebayo', comment: 'The TV I ordered was well packaged and amazing.', rating: 5.0, date: DateTime(2026, 7, 18), reply: 'We\'re glad you love it Funmi!'),
    Review(id: 'vrev_3', userName: 'Emeka Nwosu', comment: 'Great customer service. Helped me pick the right AC.', rating: 4.5, date: DateTime(2026, 7, 15)),
    Review(id: 'vrev_4', userName: 'Tunde Ogunlesi', comment: 'Good prices but delivery took longer than expected.', rating: 4.0, date: DateTime(2026, 7, 5), reply: 'Apologies for the delay Tunde. We\'ve improved our logistics since then.'),
  ];

  static final List<BuyerConversation> vendorConversations = [
    BuyerConversation(id: 'vconv_1', shopId: 'shop_1', shopName: 'TechCity', category: 'Electronics', lastMessage: 'Is the PS5 available?', time: '10m ago', unread: 1, online: true),
    BuyerConversation(id: 'vconv_2', shopId: 'shop_1', shopName: 'TechCity', category: 'Electronics', lastMessage: 'Can I get a discount on bulk order?', time: '2h ago', unread: 0, online: false),
    BuyerConversation(id: 'vconv_3', shopId: 'shop_1', shopName: 'TechCity', category: 'Electronics', lastMessage: 'Thanks for the quick delivery!', time: '1d ago', unread: 0, online: false),
  ];

  static final Map<String, List<ChatMessage>> vendorChatMessages = {
    'vconv_1': [
      ChatMessage(id: 'vm_1', senderId: 'cust', senderName: 'Chidi', content: 'Hello, is the PS5 still in stock?', timestamp: DateTime(2026, 7, 28, 10, 0)),
      ChatMessage(id: 'vm_2', senderId: 'me', senderName: 'You', content: 'Yes, we have the Standard and Digital editions available.', timestamp: DateTime(2026, 7, 28, 10, 5)),
      ChatMessage(id: 'vm_3', senderId: 'cust', senderName: 'Chidi', content: 'Great! What\'s the best price you can give me?', timestamp: DateTime(2026, 7, 28, 10, 7)),
    ],
    'vconv_2': [
      ChatMessage(id: 'vm_4', senderId: 'cust', senderName: 'Funmi', content: 'I want to buy 10 units of the JBL PartyBox for my lounge.', timestamp: DateTime(2026, 7, 28, 8, 0)),
      ChatMessage(id: 'vm_5', senderId: 'me', senderName: 'You', content: 'That\'s wonderful! We can offer a 5% discount on bulk orders.', timestamp: DateTime(2026, 7, 28, 8, 15)),
      ChatMessage(id: 'vm_6', senderId: 'cust', senderName: 'Funmi', content: 'Can you make it 10%? I\'m a regular customer.', timestamp: DateTime(2026, 7, 28, 8, 20)),
      ChatMessage(id: 'vm_7', senderId: 'me', senderName: 'You', content: 'Let me check with the manager. I\'ll get back to you.', timestamp: DateTime(2026, 7, 28, 8, 25)),
    ],
  };

  static final List<AppNotification> vendorNotifications = [
    AppNotification(id: 'vnotif_1', type: 'order', title: 'New Order', message: 'You have a new order for JBL PartyBox 310 x2 + LG AC x1.', time: DateTime(2026, 7, 28, 11, 0), read: false, link: '/vendor/orders/vord_3'),
    AppNotification(id: 'vnotif_2', type: 'order', title: 'Order Delivered', message: 'Order MM-2026-001 was marked as delivered.', time: DateTime(2026, 7, 28, 14, 30), read: true, link: '/vendor/orders/vord_1'),
    AppNotification(id: 'vnotif_3', type: 'review', title: 'New Review', message: 'Tunde Ogunlesi left a 4-star review.', time: DateTime(2026, 7, 5, 20, 0), read: true),
    AppNotification(id: 'vnotif_4', type: 'system', title: 'Shop Verified', message: 'Your shop TechCity is now verified!', time: DateTime(2026, 7, 1, 12, 0), read: true),
    AppNotification(id: 'vnotif_5', type: 'promo', title: 'Flash Sale Reminder', message: 'Your flash sale starts tomorrow. Review your settings.', time: DateTime(2026, 7, 28, 9, 0), read: false),
  ];

  static final List<TransactionData> vendorTransactions = [
    TransactionData(id: 'txn_1', orderId: 'vord_1', customerName: 'Chidi Okonkwo', amount: 382500, date: DateTime(2026, 7, 28), status: 'completed', method: 'Bank Transfer'),
    TransactionData(id: 'txn_2', orderId: 'vord_2', customerName: 'Amara Okafor', amount: 453500, date: DateTime(2026, 7, 28), status: 'pending', method: 'Card'),
    TransactionData(id: 'txn_3', orderId: 'fee_1', customerName: 'Platform Fee', amount: 15000, date: DateTime(2026, 7, 27), status: 'completed', method: 'Debit'),
    TransactionData(id: 'txn_4', orderId: 'vord_4', customerName: 'Emeka Nwosu', amount: 725000, date: DateTime(2026, 7, 26), status: 'pending', method: 'Transfer'),
    TransactionData(id: 'txn_5', orderId: 'fee_2', customerName: 'Advertising Fee', amount: 25000, date: DateTime(2026, 7, 25), status: 'completed', method: 'Debit'),
    TransactionData(id: 'txn_6', orderId: 'vord_3', customerName: 'Funmi Adebayo', amount: 210000, date: DateTime(2026, 7, 22), status: 'completed', method: 'Transfer'),
  ];

  static final List<PayoutData> vendorPayouts = [
    PayoutData(id: 'payout_1', amount: 592500, date: DateTime(2026, 7, 25), status: 'completed', method: 'GTBank'),
    PayoutData(id: 'payout_2', amount: 450000, date: DateTime(2026, 7, 18), status: 'completed', method: 'GTBank'),
    PayoutData(id: 'payout_3', amount: 780000, date: DateTime(2026, 7, 11), status: 'completed', method: 'GTBank'),
    PayoutData(id: 'payout_4', amount: 382500, date: DateTime(2026, 7, 28), status: 'pending', method: 'GTBank'),
  ];

  static final List<MarketingCoupon> vendorCoupons = [
    MarketingCoupon(id: 'coupon_1', code: 'TECH10', discountType: 'percentage', status: 'active', discountValue: 10, usageCount: 23, maxUsage: 50, validUntil: DateTime(2026, 8, 31)),
    MarketingCoupon(id: 'coupon_2', code: 'FLAT5K', discountType: 'fixed', status: 'active', discountValue: 5000, usageCount: 12, maxUsage: 30, validUntil: DateTime(2026, 8, 15)),
    MarketingCoupon(id: 'coupon_3', code: 'NEWCUST', discountType: 'percentage', status: 'scheduled', discountValue: 15, usageCount: 0, maxUsage: 100, validUntil: DateTime(2026, 9, 30)),
    MarketingCoupon(id: 'coupon_4', code: 'FREESHIP', discountType: 'shipping', status: 'expired', discountValue: 0, usageCount: 45, maxUsage: 50, validUntil: DateTime(2026, 7, 15)),
  ];

  static final List<FlashSaleData> vendorFlashSales = [
    FlashSaleData(id: 'fs_1', name: 'TechCity Mega Sale', discountPercentage: 20, startTime: DateTime(2026, 7, 29, 0, 0), endTime: DateTime(2026, 7, 29, 23, 59), status: 'scheduled'),
  ];

  static final List<SupportTicket> vendorTickets = [
    SupportTicket(id: 'ticket_1', subject: 'Payment Dispute - Order MM-2026-005', status: 'open', date: DateTime(2026, 7, 22)),
    SupportTicket(id: 'ticket_2', subject: 'Delivery Address Correction', status: 'in_progress', date: DateTime(2026, 7, 27)),
    SupportTicket(id: 'ticket_3', subject: 'Feature Request: Bulk Upload', status: 'closed', date: DateTime(2026, 7, 10)),
  ];

  static final List<HelpFaq> vendorFaqs = [
    HelpFaq(question: 'How do I process a refund?', answer: 'Go to Orders, find the order, and select "Process Refund". The amount will be deducted from your next payout.'),
    HelpFaq(question: 'How do I create a flash sale?', answer: 'Navigate to Marketing > Flash Sales and click "Create New". Set the discount percentage, products, and duration.'),
    HelpFaq(question: 'How long do payouts take?', answer: 'Payouts are processed every Friday for all completed orders from the previous week. Funds arrive within 24-48 hours.'),
    HelpFaq(question: 'Can I edit a product after it\'s live?', answer: 'Yes, you can edit product details, pricing, and stock at any time from your Products page.'),
  ];

  // =========================================================================
  // MAPPER REPORTS
  // =========================================================================
  static final Map<String, List<AnalyticsDataPoint>> mapperReports = {
    'tasks': [
      AnalyticsDataPoint(label: 'Jul 22', value: 3),
      AnalyticsDataPoint(label: 'Jul 23', value: 5),
      AnalyticsDataPoint(label: 'Jul 24', value: 2),
      AnalyticsDataPoint(label: 'Jul 25', value: 4),
      AnalyticsDataPoint(label: 'Jul 26', value: 6),
      AnalyticsDataPoint(label: 'Jul 27', value: 3),
      AnalyticsDataPoint(label: 'Jul 28', value: 1),
    ],
    'accuracy': [
      AnalyticsDataPoint(label: 'Jul 22', value: 92),
      AnalyticsDataPoint(label: 'Jul 23', value: 95),
      AnalyticsDataPoint(label: 'Jul 24', value: 88),
      AnalyticsDataPoint(label: 'Jul 25', value: 94),
      AnalyticsDataPoint(label: 'Jul 26', value: 96),
      AnalyticsDataPoint(label: 'Jul 27', value: 93),
      AnalyticsDataPoint(label: 'Jul 28', value: 97),
    ],
    'vendors': [
      AnalyticsDataPoint(label: 'Jul 22', value: 2),
      AnalyticsDataPoint(label: 'Jul 23', value: 1),
      AnalyticsDataPoint(label: 'Jul 24', value: 3),
      AnalyticsDataPoint(label: 'Jul 25', value: 0),
      AnalyticsDataPoint(label: 'Jul 26', value: 2),
      AnalyticsDataPoint(label: 'Jul 27', value: 1),
      AnalyticsDataPoint(label: 'Jul 28', value: 1),
    ],
  };

  // =========================================================================
  // BUYER USERS
  // =========================================================================
  static final List<AppUser> buyerUsers = [
    AppUser(id: 'buyer_1', name: 'Chidi Okeke', email: 'chidi.okeke@email.com', phone: '+234 802 222 3333', location: 'Lagos', role: UserRole.buyer),
    AppUser(id: 'buyer_2', name: 'Amara Okafor', email: 'amara.okafor@email.com', phone: '+234 803 111 2222', location: 'Lagos', role: UserRole.buyer),
    AppUser(id: 'buyer_3', name: 'Funmi Adebayo', email: 'funmi.adebayo@email.com', phone: '+234 805 555 6666', location: 'Abuja', role: UserRole.buyer),
  ];

  // =========================================================================
  // VENDOR USERS
  // =========================================================================
  static final List<AppUser> vendorUsers = [
    AppUser(id: 'vendor_1', name: 'James Ogunlesi', email: 'james@techcity.com', phone: '+234 802 345 6789', location: 'Ikeja, Lagos', role: UserRole.vendor),
    AppUser(id: 'vendor_2', name: 'Bola Thomas', email: 'bola@phonehub.com', phone: '+234 803 456 7890', location: 'Ikeja, Lagos', role: UserRole.vendor),
    AppUser(id: 'vendor_3', name: 'Kemi Adekunle', email: 'kemi@kemisappliances.com', phone: '+234 806 789 0123', location: 'Ojo, Lagos', role: UserRole.vendor),
  ];

  // =========================================================================
  // MAPPER USERS
  // =========================================================================
  static final List<AppUser> mapperUsers = [
    AppUser(id: 'mapper_1', name: 'Daniel Oyekunle', email: 'daniel.oyekunle@marketmirror.com', phone: '+234 701 234 5678', location: 'Lagos Mainland', role: UserRole.mapper),
    AppUser(id: 'mapper_2', name: 'Sarah Adeleke', email: 'sarah.adeleke@marketmirror.com', phone: '+234 702 345 6789', location: 'Lagos Island', role: UserRole.mapper),
  ];

  // =========================================================================
  // SHOP - RETURN HELPER
  // =========================================================================
  static Shop getShopById(String id) {
    return shops.firstWhere((s) => s.id == id, orElse: () => shops[0]);
  }

  static Product getProductById(String id) {
    return products.firstWhere((p) => p.id == id, orElse: () => products[0]);
  }

  static List<Product> getProductsByShopId(String shopId) {
    return products.where((p) => p.shopId == shopId).toList();
  }

  static List<Product> getProductsByCategory(String category) {
    if (category == 'all' || category == 'All') return products;
    return products.where((p) => p.category == category).toList();
  }

  static List<Review> getReviewsByShopId(String shopId) {
    return reviews;
  }

  static List<Shop> getShopsByMarket(String market) {
    return shops.where((s) => s.market == market).toList();
  }
}
