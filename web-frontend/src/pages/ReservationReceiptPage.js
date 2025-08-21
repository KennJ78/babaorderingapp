import React from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import {
  Container,
  Typography,
  Box,
  Paper,
  Divider,
  Button,
  Chip
} from '@mui/material';
import ReservationService from '../services/ReservationService';
import ReservationHistoryService from '../services/ReservationHistoryService';

const ReservationReceiptPage = () => {
  const location = useLocation();
  const navigate = useNavigate();

  const state = location.state || {};
  const items = (state.items && state.items.length > 0)
    ? state.items
    : ReservationService.getItems();

  const parsePrice = (priceStr) => parseFloat(String(priceStr).replace('₱', '').replace(/,/g, '')) || 0;

  const subtotal = state.subtotal !== undefined
    ? state.subtotal
    : items.reduce((total, item) => total + (parsePrice(item.price) * (item.qty || 1)), 0);

  // For in-store reservation, no delivery fee by default
  const deliveryFee = state.deliveryFee !== undefined ? state.deliveryFee : 0;
  const total = state.total !== undefined ? state.total : (subtotal + deliveryFee);

  const [reservation, setReservation] = React.useState(null);
  const reservationCode = React.useMemo(() => reservation?.code || 'RSV-XXXXXX', [reservation]);

  const timestamp = React.useMemo(() => reservation ? new Date(reservation.date).toLocaleString() : new Date().toLocaleString(), [reservation]);

  React.useEffect(() => {
    // Persist reservation into history when the page mounts
    const r = ReservationHistoryService.addReservation({ items, subtotal });
    setReservation(r);
  }, []);

  return (
    <Container maxWidth="md" sx={{ py: 4 }}>
      <Box display="flex" alignItems="center" justifyContent="space-between" sx={{ mb: 2 }}>
        <Typography variant="h4" sx={{ fontWeight: 'bold' }}>
          Reservation Receipt
        </Typography>
        <Chip label="Online Reservation" color="primary" variant="outlined" />
      </Box>

      {items.length === 0 ? (
        <Paper elevation={2} sx={{ p: 3, textAlign: 'center' }}>
          <Typography variant="h6" color="text.secondary">
            No reserved items found.
          </Typography>
          <Button onClick={() => navigate('/')} sx={{ mt: 2 }} variant="contained">
            Back to Products
          </Button>
        </Paper>
      ) : (
        <Paper elevation={2} sx={{ p: 3 }}>
          <Box sx={{ mb: 2 }}>
            <Typography variant="subtitle1" color="text.secondary">
              Reservation Code
            </Typography>
            <Typography variant="h6" sx={{ fontWeight: 'bold' }}>{reservationCode}</Typography>
            <Typography variant="body2" color="text.secondary">{timestamp}</Typography>
          </Box>

          <Divider sx={{ my: 2 }} />

          <Box>
            {items.map((item) => {
              const lineTotal = (parsePrice(item.price) * (item.qty || 1));
              return (
                <Box key={item.id} display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
                  <Typography>{item.name} x {item.qty || 1}</Typography>
                  <Typography>₱{lineTotal.toFixed(2)}</Typography>
                </Box>
              );
            })}
          </Box>

          <Divider sx={{ my: 2 }} />

          <Box display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
            <Typography>Subtotal</Typography>
            <Typography>₱{subtotal.toFixed(2)}</Typography>
          </Box>
          <Box display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
            <Typography>Reservation Fee</Typography>
            <Typography>₱{deliveryFee.toFixed(2)}</Typography>
          </Box>
          <Box display="flex" justifyContent="space-between" sx={{ mt: 1 }}>
            <Typography variant="h6" sx={{ fontWeight: 'bold' }}>Total</Typography>
            <Typography variant="h6" sx={{ fontWeight: 'bold' }} color="primary">₱{total.toFixed(2)}</Typography>
          </Box>

          <Box sx={{ mt: 3 }}>
            <Typography variant="body2" color="text.secondary">
              Please present this reservation code at the shop to claim and pay for your items.
            </Typography>
          </Box>

          <Box display="flex" gap={2} sx={{ mt: 3 }}>
            <Button variant="outlined" onClick={() => window.print()}>Print Receipt</Button>
            <Button variant="contained" onClick={() => {
              ReservationService.clear();
              navigate('/');
            }}>Back to Products</Button>
          </Box>
        </Paper>
      )}
    </Container>
  );
};

export default ReservationReceiptPage;


