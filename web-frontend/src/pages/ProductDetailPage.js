import React, { useState } from 'react';
import { useLocation, useNavigate, useParams } from 'react-router-dom';
import {
  Container,
  Typography,
  Box,
  Button,
  IconButton,
  TextField,
  Paper,
  Chip
} from '@mui/material';
import { ArrowBack, Add, Remove, Receipt } from '@mui/icons-material';
import { getProductById } from '../data/mockData';

const ProductDetailPage = () => {
  const { id } = useParams();
  const location = useLocation();
  const navigate = useNavigate();
  const [quantity, setQuantity] = useState(1);

  // Get product from location state or find by ID
  const product = location.state?.product || getProductById(id);

  if (!product) {
    return (
      <Container maxWidth="md">
        <Box textAlign="center" py={4}>
          <Typography variant="h6" color="text.secondary">
            Product not found
          </Typography>
          <Button onClick={() => navigate('/')} sx={{ mt: 2 }}>
            Back to Products
          </Button>
        </Box>
      </Container>
    );
  }

  const handleQuantityChange = (newQty) => {
    if (newQty >= 1) {
      setQuantity(newQty);
    }
  };

  const price = parseFloat(product.price.replace('₱', '').replace(/,/g, ''));
  const totalPrice = price * quantity;

  return (
    <Container maxWidth="md">
      <Box sx={{ mb: 2 }}>
        <IconButton onClick={() => navigate(-1)} sx={{ mr: 1 }}>
          <ArrowBack />
        </IconButton>
        <Typography variant="h6" component="span">
          Product Details
        </Typography>
      </Box>

      <Paper elevation={2} sx={{ p: 3 }}>
        <Box
          sx={{
            display: { xs: 'block', md: 'flex' },
            gap: 4
          }}
        >
          <Box
            sx={{
              flex: 1,
              mb: { xs: 3, md: 0 }
            }}
          >
            <img
              src={product.imagePath}
              alt={product.name}
              style={{
                width: '100%',
                height: '300px',
                objectFit: 'cover',
                borderRadius: '8px'
              }}
              onError={(e) => {
                e.target.src = 'https://via.placeholder.com/400x300?text=No+Image';
              }}
            />
          </Box>

          <Box sx={{ flex: 1 }}>
            <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold' }}>
              {product.name}
            </Typography>

            <Typography variant="h5" color="primary" sx={{ fontWeight: 'bold', mb: 2 }}>
              {product.price}
            </Typography>

            <Box sx={{ mb: 3 }}>
              <Chip
                label={`Sold: ${product.soldCount}`}
                variant="outlined"
                sx={{ mr: 1 }}
              />
              <Chip
                label="In Stock"
                color="success"
                variant="outlined"
              />
            </Box>

            <Typography variant="body1" color="text.secondary" sx={{ mb: 3 }}>
              High-quality {product.name.toLowerCase()} perfect for your electrical needs. 
              Durable construction and reliable performance guaranteed.
            </Typography>

            <Box sx={{ mb: 3 }}>
              <Typography variant="subtitle1" gutterBottom>
                Quantity:
              </Typography>
              <Box display="flex" alignItems="center" sx={{ mb: 2 }}>
                <IconButton
                  onClick={() => handleQuantityChange(quantity - 1)}
                  disabled={quantity <= 1}
                >
                  <Remove />
                </IconButton>
                <TextField
                  value={quantity}
                  onChange={(e) => {
                    const value = parseInt(e.target.value) || 1;
                    handleQuantityChange(value);
                  }}
                  inputProps={{
                    style: { textAlign: 'center', width: '60px' },
                    min: 1
                  }}
                  variant="outlined"
                  size="small"
                  sx={{ mx: 1 }}
                />
                <IconButton onClick={() => handleQuantityChange(quantity + 1)}>
                  <Add />
                </IconButton>
              </Box>
            </Box>

            <Box sx={{ mb: 3 }}>
              <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                Total: ₱{totalPrice.toFixed(2)}
              </Typography>
            </Box>

            <Button
              fullWidth
              variant="contained"
              size="large"
              startIcon={<Receipt />}
              onClick={() => {
                const item = {
                  id: product.id,
                  name: product.name,
                  price: product.price,
                  imagePath: product.imagePath,
                  qty: quantity
                };
                try {
                  const raw = localStorage.getItem('reservationItems');
                  const list = raw ? JSON.parse(raw) : [];
                  const existingIndex = list.findIndex(i => i.id === item.id);
                  if (existingIndex >= 0) {
                    list[existingIndex].qty = (list[existingIndex].qty || 1) + item.qty;
                  } else {
                    list.push(item);
                  }
                  localStorage.setItem('reservationItems', JSON.stringify(list));
                } catch (e) {
                  // noop
                }
                navigate('/reservation/summary');
              }}
              sx={{ py: 1.5 }}
            >
              Add to Reservation
            </Button>
          </Box>
        </Box>
      </Paper>
    </Container>
  );
};

export default ProductDetailPage;
