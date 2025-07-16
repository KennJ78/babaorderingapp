# Baba Ordering Backend

A Node.js/Express backend with MongoDB for the Baba Ordering App.

## Features

- User authentication (signup/login)
- JWT token-based authentication
- Cart management
- Order management (checkout)
- MongoDB database integration
- Input validation
- Error handling

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file in the root directory with the following variables:
```
MONGODB_URI=mongodb://localhost:27017/baba_ordering
JWT_SECRET=your_jwt_secret_key_here
PORT=4000
```

3. Make sure MongoDB is running on your system

4. Start the server:
```bash
# Development mode
npm run dev

# Production mode
npm start
```

## API Endpoints

### Authentication

#### POST /api/auth/signup
Register a new user
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

#### POST /api/auth/login
Login user
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

#### GET /api/auth/profile
Get current user profile (requires authentication)

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

#### PUT /api/auth/profile
Update user profile (requires authentication)

**Headers:**
```
Authorization: Bearer <your_jwt_token>
Content-Type: application/json
```
**Sample Body:**
```json
{
  "name": "Jane Doe",
  "username": "janedoe",
  "email": "jane@example.com",
  "phoneNumber": "09171234567",
  "address": "123 New St",
  "city": "Metro City",
  "state": "Metro State",
  "zipCode": "54321",
  "profileImagePath": "/images/profile.jpg"
}
```

### Cart Management

#### GET /api/cart
Get user's cart (requires authentication)

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

#### POST /api/cart/add
Add item to cart (requires authentication)
```json
{
  "productId": "abc123",
  "name": "LED Bulb",
  "price": 49.99,
  "quantity": 2,
  "image": "https://example.com/images/led-bulb.jpg"
}
```

#### DELETE /api/cart/remove/:productId
Remove item from cart (requires authentication)

#### DELETE /api/cart/clear
Clear all items from cart (requires authentication)

### Order Management

#### POST /api/orders/checkout
Checkout items in the cart and create an order (requires authentication)

**Headers:**
```
Authorization: Bearer <your_jwt_token>
Content-Type: application/json
```
**Sample Body (all items):**
```json
{
  "customerName": "John Doe",
  "street": "123 Main St",
  "city": "Metro City",
  "postalCode": "12345",
  "phone": "09171234567",
  "deliveryOption": "Delivery",
  "deliveryFee": 50
}
```
**Sample Body (specific items):**
```json
{
  "customerName": "John Doe",
  "street": "123 Main St",
  "city": "Metro City",
  "postalCode": "12345",
  "phone": "09171234567",
  "deliveryOption": "Delivery",
  "deliveryFee": 50,
  "itemsToCheckout": ["abc123", "def456"]
}
```

**Success Response:**
```json
{
  "message": "Order placed successfully.",
  "order": {
    "_id": "...",
    "orderReference": "ORD-123456-789",
    "customerName": "John Doe",
    // ...other order details...
  }
}
```

## Authentication

All protected routes require a JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

## Error Handling

The API returns appropriate HTTP status codes and error messages:
- 200: Success
- 201: Created
- 400: Bad Request (validation errors)
- 401: Unauthorized
- 404: Not Found
- 500: Server Error 