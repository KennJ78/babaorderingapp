// Data from your Flutter DataService
export const categories = [
  { id: 'all', name: 'All', icon: 'all_inclusive', description: 'All products', isActive: true },
  { id: 'tools', name: 'Tools', icon: 'build', description: 'Hand tools and equipment', isActive: true },
  { id: 'switches', name: 'Switches', icon: 'power', description: 'Electrical switches and controls', isActive: true },
  { id: 'lighting', name: 'Lighting', icon: 'lightbulb', description: 'Lighting fixtures and bulbs', isActive: true },
  { id: 'circuit_breakers', name: 'Circuit Breakers', icon: 'electric_bolt', description: 'Circuit breakers and electrical protection', isActive: true },
  { id: 'wiring', name: 'Wiring', icon: 'cable', description: 'Electrical wires and cables', isActive: true },
];

export const products = [
  {
    id: 'socket_001',
    name: 'Socket',
    price: '₱299',
    soldCount: '2.1k',
    imagePath: 'assets/images/outlet_double.svg',
    categoryId: 'tools',
    description: 'High-quality electrical socket for various applications',
    rating: 4.5,
    reviewCount: 128,
    isAvailable: true
  },
  {
    id: 'longnose_001',
    name: 'Longnose Pliers',
    price: '₱450',
    soldCount: '1.8k',
    imagePath: 'assets/images/longnose.jpg',
    categoryId: 'tools',
    description: 'Precision longnose pliers for detailed work',
    rating: 4.3,
    reviewCount: 95,
    isAvailable: true
  },
  {
    id: 'switch_001',
    name: 'Switch',
    price: '₱799',
    soldCount: '3.2k',
    imagePath: 'assets/images/dimmer_switch.svg',
    categoryId: 'switches',
    description: 'Reliable electrical switch for home and commercial use',
    rating: 4.7,
    reviewCount: 203,
    isAvailable: true
  },
  {
    id: 'wire_001',
    name: 'Electrical Wire',
    price: '₱1,250',
    soldCount: '950',
    imagePath: 'assets/images/wires.jpg',
    categoryId: 'wiring',
    description: 'High-grade electrical wire for safe installations',
    rating: 4.4,
    reviewCount: 67,
    isAvailable: true
  },
  {
    id: 'measuring_tape_001',
    name: 'Measuring Tape',
    price: '₱899',
    soldCount: '1.5k',
    imagePath: 'assets/images/measuringtape.jpg',
    categoryId: 'tools',
    description: 'Accurate measuring tape for precise measurements',
    rating: 4.6,
    reviewCount: 142,
    isAvailable: true
  },
  {
    id: 'bulb_001',
    name: 'LED Bulb',
    price: '₱650',
    soldCount: '2.7k',
    imagePath: 'assets/images/bulb.jpg',
    categoryId: 'lighting',
    description: 'Energy-efficient LED bulb with long lifespan',
    rating: 4.8,
    reviewCount: 189,
    isAvailable: true
  },
  {
    id: 'circuit_breaker_001',
    name: 'Circuit Breaker',
    price: '₱1,499',
    soldCount: '890',
    imagePath: 'assets/images/circuitbreakers.jpg',
    categoryId: 'circuit_breakers',
    description: 'Safety circuit breaker for electrical protection',
    rating: 4.9,
    reviewCount: 76,
    isAvailable: true
  },
  {
    id: 'pliers_001',
    name: 'Pliers',
    price: '₱399',
    soldCount: '1.9k',
    imagePath: 'assets/images/pliers.jpg',
    categoryId: 'tools',
    description: 'Versatile pliers for various gripping tasks',
    rating: 4.2,
    reviewCount: 113,
    isAvailable: true
  },
  {
    id: 'outlet_002',
    name: 'Double Socket Outlet',
    price: '₱349',
    soldCount: '1.1k',
    imagePath: 'assets/images/gfci_outlet.svg',
    categoryId: 'switches',
    description: 'Durable double socket outlet for home and office use',
    rating: 4.5,
    reviewCount: 84,
    isAvailable: true
  },
  {
    id: 'dimmer_001',
    name: 'Dimmer Switch',
    price: '₱1,199',
    soldCount: '740',
    imagePath: 'assets/images/switch.jpg',
    categoryId: 'switches',
    description: 'Smooth dimming for LED and incandescent lighting',
    rating: 4.6,
    reviewCount: 91,
    isAvailable: true
  },
  {
    id: 'gfci_001',
    name: 'GFCI Outlet',
    price: '₱1,899',
    soldCount: '520',
    imagePath: 'assets/images/socket.jpg',
    categoryId: 'switches',
    description: 'Ground-fault circuit interrupter for wet area protection',
    rating: 4.7,
    reviewCount: 73,
    isAvailable: true
  },
  {
    id: 'led_strip_001',
    name: 'LED Strip Light 5m',
    price: '₱1,299',
    soldCount: '2.0k',
    imagePath: 'assets/images/led_strip.svg',
    categoryId: 'lighting',
    description: 'Flexible LED strip lighting for accent and task lighting',
    rating: 4.4,
    reviewCount: 156,
    isAvailable: true
  },
  {
    id: 'floodlight_001',
    name: 'LED Floodlight 50W',
    price: '₱2,499',
    soldCount: '1.3k',
    imagePath: 'assets/images/floodlight.svg',
    categoryId: 'lighting',
    description: 'Bright and energy-efficient outdoor floodlight',
    rating: 4.6,
    reviewCount: 112,
    isAvailable: true
  },
  {
    id: 'breaker_002',
    name: 'Mini Circuit Breaker 20A',
    price: '₱899',
    soldCount: '1.4k',
    imagePath: 'assets/images/mcb_20a.svg',
    categoryId: 'circuit_breakers',
    description: 'Reliable protection for residential branch circuits',
    rating: 4.8,
    reviewCount: 134,
    isAvailable: true
  },
  {
    id: 'breaker_003',
    name: 'RCD Breaker 30mA',
    price: '₱2,199',
    soldCount: '690',
    imagePath: 'assets/images/rcd_30ma.svg',
    categoryId: 'circuit_breakers',
    description: 'Residual current device for shock protection',
    rating: 4.7,
    reviewCount: 77,
    isAvailable: true
  },
  {
    id: 'wire_002',
    name: 'THHN Copper Wire 2.0mm',
    price: '₱1,050',
    soldCount: '1.1k',
    imagePath: 'assets/images/thhn_2mm.svg',
    categoryId: 'wiring',
    description: 'High-conductivity THHN copper wire for building wiring',
    rating: 4.5,
    reviewCount: 88,
    isAvailable: true
  },
  {
    id: 'wire_003',
    name: 'Coaxial Cable RG6 100m',
    price: '₱2,799',
    soldCount: '430',
    imagePath: 'assets/images/rg6_coax.svg',
    categoryId: 'wiring',
    description: 'Shielded RG6 coaxial cable for clear signal transmission',
    rating: 4.3,
    reviewCount: 56,
    isAvailable: true
  },
  {
    id: 'conduit_001',
    name: 'PVC Conduit 20mm',
    price: '₱180',
    soldCount: '2.6k',
    imagePath: 'assets/images/pvc_conduit_20mm.svg',
    categoryId: 'wiring',
    description: 'Durable PVC conduit for cable protection',
    rating: 4.4,
    reviewCount: 121,
    isAvailable: true
  },
  {
    id: 'junction_001',
    name: 'Junction Box 4x4',
    price: '₱120',
    soldCount: '3.1k',
    imagePath: 'assets/images/junction_box_4x4.svg',
    categoryId: 'wiring',
    description: 'Standard junction box for safe wire connections',
    rating: 4.5,
    reviewCount: 139,
    isAvailable: true
  },
  {
    id: 'tape_001',
    name: 'Electrical Tape 3/4" (10pcs)',
    price: '₱220',
    soldCount: '4.8k',
    imagePath: 'assets/images/electrical_tape_pack.svg',
    categoryId: 'wiring',
    description: 'Flame-retardant PVC electrical insulation tape',
    rating: 4.6,
    reviewCount: 201,
    isAvailable: true
  },
  {
    id: 'tester_001',
    name: 'Voltage Tester Pen',
    price: '₱499',
    soldCount: '2.2k',
    imagePath: 'assets/images/voltage_tester_pen.svg',
    categoryId: 'tools',
    description: 'Non-contact AC voltage detector pen',
    rating: 4.4,
    reviewCount: 109,
    isAvailable: true
  },
  {
    id: 'multimeter_001',
    name: 'Digital Multimeter',
    price: '₱1,799',
    soldCount: '980',
    imagePath: 'assets/images/digital_multimeter.svg',
    categoryId: 'tools',
    description: 'Handheld digital multimeter for electrical diagnostics',
    rating: 4.6,
    reviewCount: 92,
    isAvailable: true
  },
  {
    id: 'cable_tie_001',
    name: 'Cable Ties 200mm (100pcs)',
    price: '₱150',
    soldCount: '3.9k',
    imagePath: 'assets/images/cable_ties_pack.svg',
    categoryId: 'wiring',
    description: 'Strong nylon cable ties for cable management',
    rating: 4.5,
    reviewCount: 175,
    isAvailable: true
  }
];

// Mock cart data (from your Flutter CartService)
export const mockCartItems = [
  { id: 'switch_002', name: 'Socket', price: '₱299', imagePath: '/assets/images/socket.jpg', qty: 2, checked: true },
  { id: 'switch_001', name: 'Switch', price: '₱799', imagePath: '/assets/images/switch.jpg', qty: 1, checked: true },
  { id: 'light_001', name: 'Bulb', price: '₱650', imagePath: '/assets/images/bulb.jpg', qty: 3, checked: true },
];

// Mock users data (from your Flutter validation)
export const mockUsers = {};

// Helper functions
export const getProductsByCategory = (categoryId) => {
  if (categoryId === 'all') return products;
  return products.filter(product => product.categoryId === categoryId);
};

export const searchProducts = (query) => {
  return products.filter(product => 
    product.name.toLowerCase().includes(query.toLowerCase())
  );
};

export const getProductById = (id) => {
  return products.find(product => product.id === id);
};
