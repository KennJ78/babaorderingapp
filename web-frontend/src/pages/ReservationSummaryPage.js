import React, { useEffect, useState } from 'react';
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
  TextField,
  Divider,
  Paper
} from '@mui/material';
import { Add, Remove, Delete, ReceiptLong } from '@mui/icons-material';
import ReservationService from '../services/ReservationService';

const ReservationSummaryPage = () => {
  const navigate = useNavigate();
  const [items, setItems] = useState(ReservationService.getItems());

  useEffect(() => {
    const handler = () => setItems(ReservationService.getItems());
    window.addEventListener('reservationUpdated', handler);
    return () => window.removeEventListener('reservationUpdated', handler);
  }, []);

  const updateQty = (id, qty) => ReservationService.updateQuantity(id, qty);
  const removeItem = (id) => ReservationService.removeItem(id);

  const subtotal = ReservationService.getSubtotal();

  return (
    <Container maxWidth="md">
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', mb: 3 }}>
        Reservation Summary
      </Typography>

      {items.length === 0 ? (
        <Box textAlign="center" sx={{ py: 6 }}>
          <Typography color="text.secondary" sx={{ mb: 2 }}>No items selected.</Typography>
          <Button variant="contained" onClick={() => navigate('/')}>Browse Products</Button>
        </Box>
      ) : (
        <Box>
          {items.map((item) => (
            <Card key={item.id} sx={{ mb: 2 }}>
              <CardContent>
                <Box display="flex" alignItems="center">
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
                    <Typography variant="h6" sx={{ fontWeight: 600 }}>{item.name}</Typography>
                    <Typography variant="h6" color="primary" sx={{ fontWeight: 'bold' }}>{item.price}</Typography>
                  </Box>

                  <Box display="flex" alignItems="center" sx={{ mx: 2 }}>
                    <IconButton onClick={() => updateQty(item.id, (item.qty || 1) - 1)} disabled={(item.qty || 1) <= 1}>
                      <Remove />
                    </IconButton>
                    <TextField
                      value={item.qty || 1}
                      onChange={(e) => {
                        const value = parseInt(e.target.value) || 1;
                        updateQty(item.id, value);
                      }}
                      inputProps={{ style: { textAlign: 'center', width: '50px' }, min: 1 }}
                      variant="outlined"
                      size="small"
                    />
                    <IconButton onClick={() => updateQty(item.id, (item.qty || 1) + 1)}>
                      <Add />
                    </IconButton>
                  </Box>

                  <Typography variant="h6" sx={{ fontWeight: 'bold', minWidth: '80px', textAlign: 'right' }}>
                    ₱{(parseFloat(String(item.price).replace('₱', '').replace(/,/g, '')) * (item.qty || 1)).toFixed(2)}
                  </Typography>

                  <IconButton onClick={() => removeItem(item.id)} color="error" sx={{ ml: 1 }}>
                    <Delete />
                  </IconButton>
                </Box>
              </CardContent>
            </Card>
          ))}

          <Paper elevation={2} sx={{ p: 3, mt: 3 }}>
            <Typography variant="h6" gutterBottom>Summary</Typography>
            <Divider sx={{ mb: 2 }} />

            <Box display="flex" justifyContent="space-between" sx={{ mb: 2 }}>
              <Typography>Subtotal</Typography>
              <Typography>₱{subtotal.toFixed(2)}</Typography>
            </Box>

            <Box display="flex" gap={2} sx={{ mb: 2 }}>
              <Button
                variant="outlined"
                onClick={() => navigate('/')}
              sx={{ borderColor: '#d32f2f', color: '#d32f2f' }}
              >
                Continue Browsing
              </Button>
            </Box>

            <Button
              fullWidth
              variant="contained"
              size="large"
              startIcon={<ReceiptLong />}
              onClick={() => navigate('/reservation/receipt', {
                state: { items, subtotal, deliveryFee: 0, total: subtotal }
              })}
              sx={{ py: 1.5 }}
            >
              Confirm Reservation
            </Button>
          </Paper>
        </Box>
      )}
    </Container>
  );
};

export default ReservationSummaryPage;


