import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Container,
  Typography,
  Box,
  Card,
  CardContent,
  TextField,
  Button,
  Radio,
  RadioGroup,
  FormControlLabel,
  FormControl,
  FormLabel,
  Divider,
  Paper,
  Alert
} from '@mui/material';
import { LocationOn, Payment, LocalShipping } from '@mui/icons-material';
import { mockCartItems } from '../data/mockData';

const CheckoutPage = () => {
  const navigate = useNavigate();
  const [deliveryInfo, setDeliveryInfo] = useState({
    customerName: '',
    street: '',
    city: '',
    postalCode: '',
    phone: ''
  });
  const [deliveryOption, setDeliveryOption] = useState('Standard');
  const [errors, setErrors] = useState({});

  const checkedItems = mockCartItems.filter(item => item.checked);
  
  const getSubTotal = () => {
    return checkedItems.reduce((total, item) => {
      const price = parseFloat(item.price.replace('₱', ''));
      return total + (price * item.qty);
    }, 0);
  };

  const getDeliveryFee = () => {
    return deliveryOption === 'Express' ? 100 : 50;
  };

  const getTotal = () => getSubTotal() + getDeliveryFee();

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setDeliveryInfo(prev => ({
      ...prev,
      [name]: value
    }));
    
    if (errors[name]) {
      setErrors(prev => ({
        ...prev,
        [name]: ''
      }));
    }
  };

  const validateForm = () => {
    const newErrors = {};
    
    if (!deliveryInfo.customerName.trim()) {
      newErrors.customerName = 'Customer name is required';
    }
    if (!deliveryInfo.street.trim()) {
      newErrors.street = 'Street address is required';
    }
    if (!deliveryInfo.city.trim()) {
      newErrors.city = 'City is required';
    }
    if (!deliveryInfo.postalCode.trim()) {
      newErrors.postalCode = 'Postal code is required';
    }
    if (!deliveryInfo.phone.trim()) {
      newErrors.phone = 'Phone number is required';
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handlePlaceOrder = () => {
    if (!validateForm()) {
      return;
    }

    const orderReference = `BABA-${new Date().getFullYear()}-${Math.floor(Math.random() * 1000).toString().padStart(3, '0')}`;
    
    navigate('/orders', {
      state: {
        orderPlaced: true,
        orderReference,
        deliveryInfo,
        deliveryOption,
        items: checkedItems,
        total: getTotal()
      }
    });
  };

  if (checkedItems.length === 0) {
    return (
      <Container maxWidth="md">
        <Box textAlign="center" py={4}>
          <Typography variant="h6" color="text.secondary">
            No items selected for checkout
          </Typography>
          <Button onClick={() => navigate('/cart')} sx={{ mt: 2 }}>
            Back to Cart
          </Button>
        </Box>
      </Container>
    );
  }

  return (
    <Container maxWidth="md">
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', mb: 3 }}>
        Checkout
      </Typography>

      <Box sx={{ display: { xs: 'block', md: 'flex' }, gap: 3 }}>
        <Box sx={{ flex: 2 }}>
          {/* Delivery Information */}
          <Card sx={{ mb: 3 }}>
            <CardContent>
              <Box display="flex" alignItems="center" sx={{ mb: 2 }}>
                <LocationOn color="primary" sx={{ mr: 1 }} />
                <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                  Delivery Information
                </Typography>
              </Box>
              
              <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: '1fr', sm: '1fr 1fr' } }}>
                <TextField
                  fullWidth
                  label="Customer Name"
                  name="customerName"
                  value={deliveryInfo.customerName}
                  onChange={handleInputChange}
                  error={!!errors.customerName}
                  helperText={errors.customerName}
                  sx={{ gridColumn: { sm: '1 / -1' } }}
                />
                
                <TextField
                  fullWidth
                  label="Street Address"
                  name="street"
                  value={deliveryInfo.street}
                  onChange={handleInputChange}
                  error={!!errors.street}
                  helperText={errors.street}
                  sx={{ gridColumn: { sm: '1 / -1' } }}
                />
                
                <TextField
                  fullWidth
                  label="City"
                  name="city"
                  value={deliveryInfo.city}
                  onChange={handleInputChange}
                  error={!!errors.city}
                  helperText={errors.city}
                />
                
                <TextField
                  fullWidth
                  label="Postal Code"
                  name="postalCode"
                  value={deliveryInfo.postalCode}
                  onChange={handleInputChange}
                  error={!!errors.postalCode}
                  helperText={errors.postalCode}
                />
                
                <TextField
                  fullWidth
                  label="Phone Number"
                  name="phone"
                  value={deliveryInfo.phone}
                  onChange={handleInputChange}
                  error={!!errors.phone}
                  helperText={errors.phone}
                  sx={{ gridColumn: { sm: '1 / -1' } }}
                />
              </Box>
            </CardContent>
          </Card>

          {/* Delivery Options */}
          <Card sx={{ mb: 3 }}>
            <CardContent>
              <Box display="flex" alignItems="center" sx={{ mb: 2 }}>
                <LocalShipping color="primary" sx={{ mr: 1 }} />
                <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                  Delivery Options
                </Typography>
              </Box>
              
              <FormControl>
                <RadioGroup
                  value={deliveryOption}
                  onChange={(e) => setDeliveryOption(e.target.value)}
                >
                  <FormControlLabel
                    value="Standard"
                    control={<Radio />}
                    label={
                      <Box>
                        <Typography variant="body1">Standard Delivery</Typography>
                        <Typography variant="body2" color="text.secondary">
                          3-5 business days • ₱50.00
                        </Typography>
                      </Box>
                    }
                  />
                  <FormControlLabel
                    value="Express"
                    control={<Radio />}
                    label={
                      <Box>
                        <Typography variant="body1">Express Delivery</Typography>
                        <Typography variant="body2" color="text.secondary">
                          1-2 business days • ₱100.00
                        </Typography>
                      </Box>
                    }
                  />
                </RadioGroup>
              </FormControl>
            </CardContent>
          </Card>
        </Box>

        {/* Order Summary */}
        <Box sx={{ flex: 1 }}>
          <Paper elevation={2} sx={{ p: 3, position: 'sticky', top: 20 }}>
            <Box display="flex" alignItems="center" sx={{ mb: 2 }}>
              <Payment color="primary" sx={{ mr: 1 }} />
              <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                Order Summary
              </Typography>
            </Box>
            
            <Divider sx={{ mb: 2 }} />
            
            {checkedItems.map((item, index) => (
              <Box key={index} display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
                <Typography variant="body2">
                  {item.name} × {item.qty}
                </Typography>
                <Typography variant="body2">
                  ₱{(parseFloat(item.price.replace('₱', '')) * item.qty).toFixed(2)}
                </Typography>
              </Box>
            ))}
            
            <Divider sx={{ my: 2 }} />
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
              <Typography>Subtotal:</Typography>
              <Typography>₱{getSubTotal().toFixed(2)}</Typography>
            </Box>
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 2 }}>
              <Typography>Delivery Fee:</Typography>
              <Typography>₱{getDeliveryFee().toFixed(2)}</Typography>
            </Box>
            
            <Divider sx={{ mb: 2 }} />
            
            <Box display="flex" justifyContent="space-between" sx={{ mb: 3 }}>
              <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                Total:
              </Typography>
              <Typography variant="h6" sx={{ fontWeight: 'bold' }} color="primary">
                ₱{getTotal().toFixed(2)}
              </Typography>
            </Box>
            
            <Button
              fullWidth
              variant="contained"
              size="large"
              onClick={handlePlaceOrder}
              sx={{ py: 1.5 }}
            >
              Place Order
            </Button>
          </Paper>
        </Box>
      </Box>
    </Container>
  );
};

export default CheckoutPage;
