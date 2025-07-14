# Baba Ordering Backend

A Node.js/Express backend with MongoDB for the Baba Ordering App.

## Features

- User authentication (signup/login)
- JWT token-based authentication
- Cart management
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
PORT=5000
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
  "password": "password123",
  "phone": "1234567890",
  "address": {
    "street": "123 Main St",
    "city": "City",
    "state": "State",
    "zipCode": "12345"
  }
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

#### GET /api/auth/me
Get current user profile (requires authentication)

#### PUT /api/auth/profile
Update user profile (requires authentication)

### Cart Management

#### GET /api/cart
Get user's cart (requires authentication)

#### POST /api/cart/add
Add item to cart (requires authentication)
```json
{
  "productId": "product_id_here",
  "name": "Product Name",
  "price": 29.99,
  "quantity": 2,
  "image": "product_image_url"
}
```

#### PUT /api/cart/update/:productId
Update item quantity in cart (requires authentication)
```json
{
  "quantity": 3
}
```

#### DELETE /api/cart/remove/:productId
Remove item from cart (requires authentication)

#### DELETE /api/cart/clear
Clear all items from cart (requires authentication)

## Authentication

All protected routes require a JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

## Database Models

### User Model
- name (required)
- email (required, unique)
- password (required, hashed)
- phone (required)
- address (optional)
- role (user/admin)
- isActive (boolean)
- timestamps

### Cart Model
- userId (reference to User)
- items (array of cart items)
- totalAmount (calculated)
- itemCount (calculated)
- timestamps

## Error Handling

The API returns appropriate HTTP status codes and error messages:
- 200: Success
- 201: Created
- 400: Bad Request (validation errors)
- 401: Unauthorized
- 404: Not Found
- 500: Server Error 