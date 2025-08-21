import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Container,
  Typography,
  Box,
  Card,
  CardContent,
  CardMedia,
  IconButton,
  Button,
  Checkbox,
  TextField,
  Divider,
  Paper
} from '@mui/material';
import { Add, Remove, Delete, ShoppingCartCheckout } from '@mui/icons-material';
import { mockCartItems } from '../data/mockData';

const CartPage = () => {
  const [cartItems, setCartItems] = useState(mockCartItems);
  const navigate = useNavigate();

  const updateQuantity = (id, newQty) => {
    if (newQty < 1) return;
    setCartItems(items =>
      items.map(item =>
        item.id === id ? { ...item, qty: newQty } : item
      )
    );
  };

  const toggleItemCheck = (id) => {
    setCartItems(items =>
      items.map(item =>
        item.id === id ? { ...item, checked: !item.checked } : item
      )
    );
  };

  const removeItem = (id) => {
    setCartItems(items => items.filter(item => item.id !== id));
  };

  const getItemTotal = (item) => {
    const price = parseFloat(item.price.replace('₱', ''));
    return price * item.qty;
  };

  const getSubTotal = () => {
    return cartItems
      .filter(item => item.checked)
      .reduce((total, item) => total + getItemTotal(item), 0);
  };

  const getDeliveryFee = () => 50; // Fixed delivery fee

  const getTotal = () => getSubTotal() + getDeliveryFee();

  const checkedItems = cartItems.filter(item => item.checked);

  return (
    <Container maxWidth="md">
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', mb: 3 }}>
        Shopping Cart
      </Typography>

      {cartItems.length === 0 ? (
        <Box
          sx={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            minHeight: 300,
            textAlign: 'center'
          }}
        >
          <ShoppingCartCheckout sx={{ fontSize: 64, color: 'grey.400', mb: 2 }} />
          <Typography variant="h6" color="text.secondary" gutterBottom>
            Your cart is empty
          </Typography>
          <Button
            variant="contained"
            onClick={() => navigate('/')}
            sx={{ mt: 2 }}
          >
            Continue Shopping
          </Button>
        </Box>
      ) : (
        <Box>
          {cartItems.map((item) => (
            <Card key={item.id} sx={{ mb: 2 }}>
              <CardContent>
                <Box display="flex" alignItems="center">
                  <Checkbox
                    checked={item.checked}
                    onChange={() => toggleItemCheck(item.id)}
                    color="primary"
                  />
                  
                  <CardMedia
                    component="img"
                    sx={{ width: 80, height: 80, objectFit: 'cover', borderRadius: 1, ml: 1 }}
                    image={item.imagePath}
                    alt={item.name}
                    onError={(e) => {
                      e.target.src = 'https://via.placeholder.com/80x80?text=No+Image';
                    }}
                  />
                  
                  <Box sx={{ flex: 1, ml: 2 }}>
                    <Typography variant="h6" sx={{ fontWeight: 600 }}>
                      {item.name}
                    </Typography>
                    <Typography variant="h6" color="primary" sx={{ fontWeight: 'bold' }}>
                      {item.price}
                    </Typography>
                  </Box>
                  
                  <Box display="flex" alignItems="center" sx={{ mx: 2 }}>
                    <IconButton
                      onClick={() => updateQuantity(item.id, item.qty - 1)}
                      disabled={item.qty <= 1}
                    >
                      <Remove />
                    </IconButton>
                    <TextField
                      value={item.qty}
                      onChange={(e) => {
                        const value = parseInt(e.target.value) || 1;
                        updateQuantity(item.id, value);
                      }}
                      inputProps={{
                        style: { textAlign: 'center', width: '50px' },
                        min: 1
                      }}
                      variant="outlined"
                      size="small"
                    />
                    <IconButton onClick={() => updateQuantity(item.id, item.qty + 1)}>
                      <Add />
                    </IconButton>
                  </Box>
                  
                  <Typography variant="h6" sx={{ fontWeight: 'bold', minWidth: '80px', textAlign: 'right' }}>
                    ₱{getItemTotal(item).toFixed(2)}
                  </Typography>
                  
                  <IconButton
                    onClick={() => removeItem(item.id)}
                    color="error"
                    sx={{ ml: 1 }}
                  >
                    <Delete />
                  </IconButton>
                </Box>
              </CardContent>
            </Card>
          ))}

          <Paper elevation={2} sx={{ p: 3, mt: 3 }}>
            <Typography variant="h6" gutterBottom>
              Reservation Summary
            </Typography>
            <Divider sx={{ mb: 2 }} />
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
              <Typography>Subtotal ({checkedItems.length} items):</Typography>
              <Typography>₱{getSubTotal().toFixed(2)}</Typography>
            </Box>
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 2 }}>
              <Typography>Reservation Fee:</Typography>
              <Typography>₱0.00</Typography>
            </Box>
            
            <Divider sx={{ mb: 2 }} />
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 3 }}>
              <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                Total:
              </Typography>
              <Typography variant="h6" sx={{ fontWeight: 'bold' }} color="primary">
                ₱{getSubTotal().toFixed(2)}
              </Typography>
            </Box>
            
            <Button
              fullWidth
              variant="contained"
              size="large"
              disabled={checkedItems.length === 0}
              onClick={() => navigate('/reservation/receipt', { state: { items: checkedItems, subtotal: getSubTotal(), deliveryFee: 0, total: getSubTotal() } })}
              sx={{ py: 1.5 }}
            >
              Reserve Items ({checkedItems.length})
            </Button>
          </Paper>
        </Box>
      )}
    </Container>
  );
};

export default CartPage;
