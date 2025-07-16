# Baba Ordering App

A full-stack e-commerce application built with Flutter (frontend) and Node.js/Express (backend) for ordering electrical supplies and tools.

## 🚀 Features

### Frontend (Flutter)
- **User Authentication**: Login and signup functionality
- **Product Catalog**: Browse electrical supplies and tools by categories
- **Shopping Cart**: Add/remove items with quantity management
- **User Profile**: Edit personal information and profile picture
- **Order Management**: Place orders with delivery options
- **Order Tracking**: View order history and status

### Backend (Node.js/Express)
- **RESTful API**: Complete CRUD operations for users, products, orders, and cart
- **Authentication**: JWT-based authentication with middleware
- **Database**: MongoDB with Mongoose ODM
- **File Upload**: Profile image handling
- **Order Processing**: Complete order lifecycle management

## 📁 Project Structure

```
babaorderingapp2/
├── lib/                          # Flutter frontend
│   ├── models/                   # Data models
│   │   ├── user.dart            # User model with profile management
│   │   ├── product.dart         # Product model
│   │   ├── order.dart           # Order model with delivery info
│   │   └── category.dart        # Category model
│   ├── pages/                   # UI screens
│   │   ├── LoginandSignup.dart  # Authentication screens
│   │   ├── home_screen.dart     # Main product catalog
│   │   ├── cart_screen.dart     # Shopping cart
│   │   ├── profile_screen.dart  # User profile
│   │   ├── edit_profile_screen.dart # Profile editing
│   │   ├── checkout_screen.dart # Order checkout
│   │   └── order_screen.dart    # Order management
│   └── services/                # API services
├── backend/                     # Node.js backend
│   ├── models/                  # Database models
│   │   ├── User.js             # User model with extended profile fields
│   │   ├── Order.js            # Order model with items and delivery
│   │   └── Cart.js             # Cart model
│   ├── routes/                 # API routes
│   │   ├── auth.js             # Authentication routes
│   │   └── cart.js             # Cart management routes
│   ├── middleware/             # Custom middleware
│   │   └── auth.js             # JWT authentication middleware
│   ├── server.js               # Express server setup
│   └── config.env              # Environment configuration
└── assets/                     # Static assets
    └── images/                 # Product images and icons
```

## 🛠️ Backend API Documentation

### Authentication Endpoints

#### POST `/api/auth/signup`
Register a new user account.
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "123456"
}
```

#### POST `/api/auth/login`
Authenticate user and get JWT token.
```json
{
  "email": "john@example.com",
  "password": "123456"
}
```

#### GET `/api/auth/profile`
Get current user's profile (requires authentication).
**Headers:** `Authorization: Bearer <JWT_TOKEN>`

#### PUT `/api/auth/profile`
Update user profile information (requires authentication).
**Headers:** `Authorization: Bearer <JWT_TOKEN>`
```json
{
  "name": "John Smith",
  "username": "johnsmith",
  "phoneNumber": "+1234567890",
  "address": "123 Main Street",
  "city": "New York",
  "state": "NY",
  "zipCode": "10001",
  "profileImagePath": "/uploads/profile.jpg"
}
```

### Cart Endpoints

#### GET `/api/cart`
Get user's cart items (requires authentication).

#### POST `/api/cart/add`
Add item to cart (requires authentication).
```json
{
  "productId": "product_id_here",
  "quantity": 2
}
```

#### PUT `/api/cart/update`
Update cart item quantity (requires authentication).
```json
{
  "productId": "product_id_here",
  "quantity": 3
}
```

#### DELETE `/api/cart/remove/:productId`
Remove item from cart (requires authentication).

### Order Endpoints

#### POST `/api/orders`
Create a new order (requires authentication).
```json
{
  "customerName": "John Doe",
  "street": "123 Main Street",
  "city": "New York",
  "postalCode": "10001",
  "phone": "+1234567890",
  "deliveryOption": "Standard",
  "totalAmount": 150.00,
  "deliveryFee": 10.00,
  "items": [
    {
      "productId": "product_id",
      "productName": "Wire Cutter",
      "quantity": 2,
      "price": 25.00,
      "totalPrice": 50.00
    }
  ]
}
```

#### GET `/api/orders`
Get user's order history (requires authentication).

## 🗄️ Database Models

### User Model
```javascript
{
  name: String (required),
  username: String,
  email: String (required, unique),
  password: String (required, hashed),
  profileImagePath: String,
  address: String,
  city: String,
  state: String,
  zipCode: String,
  phoneNumber: String,
  timestamps: true
}
```

### Order Model
```javascript
{
  orderReference: String (unique, auto-generated),
  customerName: String (required),
  street: String (required),
  city: String (required),
  postalCode: String (required),
  phone: String (required),
  deliveryOption: String (required),
  totalAmount: Number (required),
  deliveryFee: Number (required),
  items: [{
    productId: String,
    productName: String,
    quantity: Number,
    price: Number,
    totalPrice: Number
  }],
  orderDate: Date (default: now),
  status: String (enum: Pending, Confirmed, Processing, Shipped, Delivered, Cancelled),
  userId: ObjectId (ref: User),
  timestamps: true
}
```

## 🚀 Getting Started

### Prerequisites
- Node.js (v14 or higher)
- MongoDB (running locally or cloud instance)
- Flutter SDK (for frontend development)

### Backend Setup

1. **Install dependencies:**
```bash
cd backend
npm install
```

2. **Configure environment:**
Create `config.env` file in backend directory:
```env
MONGODB_URI=mongodb://localhost:27017/baba_ordering
JWT_SECRET=your_jwt_secret_key_here
PORT=4000
```

3. **Start the server:**
```bash
npm start
```

The backend will run on `http://localhost:4000`

### Frontend Setup

1. **Install Flutter dependencies:**
```bash
flutter pub get
```

2. **Run the app:**
```bash
flutter run
```

## 🧪 Testing with Postman

### 1. Create a Postman Collection
- Collection Name: "Baba Ordering API"
- Base URL: `http://localhost:4000`

### 2. Set up Environment Variables
- `base_url`: `http://localhost:4000`
- `token`: (will be set after login)

### 3. Test Flow
1. **Register User** → POST `/api/auth/signup`
2. **Login** → POST `/api/auth/login` (auto-save token)
3. **Get Profile** → GET `/api/auth/profile`
4. **Update Profile** → PUT `/api/auth/profile`
5. **Add to Cart** → POST `/api/cart/add`
6. **Create Order** → POST `/api/orders`

### 4. Authentication Headers
For protected routes, add:
```
Authorization: Bearer {{token}}
```

## 🔧 Key Features Implemented

### User Profile Management
- Complete profile CRUD operations
- Profile image upload support
- Email uniqueness validation
- JWT-based authentication

### Order System
- Automatic order reference generation
- Complete order lifecycle management
- Delivery information tracking
- Order status updates

### Shopping Cart
- Add/remove items
- Quantity management
- User-specific cart storage

## 📱 Frontend Features

### Authentication Screens
- Login and signup forms
- Form validation
- Error handling

### Product Catalog
- Category-based browsing
- Product details
- Image display

### Profile Management
- Edit personal information
- Profile picture upload
- Address management

### Order Management
- Checkout process
- Order confirmation
- Order history

## 🔒 Security Features

- Password hashing with bcrypt
- JWT token authentication
- Protected routes with middleware
- Input validation and sanitization
- Email uniqueness validation

## 🚀 Deployment

### Backend Deployment
- Configure production MongoDB URI
- Set secure JWT secret
- Use environment variables for configuration
- Deploy to platforms like Heroku, Railway, or AWS

### Frontend Deployment
- Build for target platforms (Android, iOS, Web)
- Configure API endpoints for production
- Deploy to app stores or web hosting

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 📞 Support

For support and questions, please open an issue in the repository.
