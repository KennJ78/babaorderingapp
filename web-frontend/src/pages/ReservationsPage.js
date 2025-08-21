import React, { useEffect, useState } from 'react';
import {
  Container,
  Typography,
  Box,
  Card,
  CardContent,
  Chip,
  Divider,
  Button
} from '@mui/material';
import { ReceiptLong } from '@mui/icons-material';
import ReservationHistoryService from '../services/ReservationHistoryService';

const ReservationsPage = () => {
  const [reservations, setReservations] = useState(ReservationHistoryService.list());

  useEffect(() => {
    const handler = () => setReservations(ReservationHistoryService.list());
    window.addEventListener('reservationHistoryUpdated', handler);
    return () => window.removeEventListener('reservationHistoryUpdated', handler);
  }, []);

  const getStatusColor = (status) => {
    const s = String(status).toLowerCase();
    if (s.includes('ready')) return 'success';
    if (s.includes('confirm')) return 'info';
    if (s.includes('process')) return 'warning';
    return 'default';
  };

  return (
    <Container maxWidth="md">
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', mb: 3 }}>
        My Reservations
      </Typography>

      {reservations.length === 0 ? (
        <Box textAlign="center" sx={{ py: 6 }}>
          <ReceiptLong sx={{ fontSize: 64, color: 'grey.400', mb: 2 }} />
          <Typography color="text.secondary">No reservations yet</Typography>
        </Box>
      ) : (
        <Box>
          {reservations.map((r) => (
            <Card key={r.id} sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Box display="flex" justifyContent="space-between" alignItems="flex-start" sx={{ mb: 2 }}>
                  <Box>
                    <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                      Reservation #{r.code}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      Created {new Date(r.date).toLocaleString()}
                    </Typography>
                  </Box>
                  <Chip label={r.status} color={getStatusColor(r.status)} />
                </Box>

                <Divider sx={{ my: 2 }} />

                <Box sx={{ mb: 2 }}>
                  <Typography variant="subtitle2" gutterBottom sx={{ fontWeight: 'bold' }}>
                    Items ({r.items.length}):
                  </Typography>
                  {r.items.map((item, i) => (
                    <Box key={i} display="flex" justifyContent="space-between" sx={{ mb: 1 }}>
                      <Typography variant="body2">
                        {item.name} × {item.qty}
                      </Typography>
                      <Typography variant="body2" sx={{ fontWeight: 'bold' }}>
                        ₱{(parseFloat(String(item.price).replace('₱', '').replace(/,/g, '')) * (item.qty || 1)).toFixed(2)}
                      </Typography>
                    </Box>
                  ))}
                </Box>

                <Divider sx={{ my: 2 }} />

                <Box display="flex" justifyContent="space-between" alignItems="center">
                  <Box>
                    <Typography variant="body2" color="text.secondary">
                      Subtotal: ₱{Number(r.subtotal).toFixed(2)}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      Reservation Fee: ₱{Number(r.deliveryFee).toFixed(2)}
                    </Typography>
                    <Typography variant="h6" sx={{ fontWeight: 'bold' }}>
                      Total: ₱{Number(r.total).toFixed(2)}
                    </Typography>
                  </Box>
                  <Box display="flex" gap={1}>
                    <Button variant="outlined" size="small" onClick={() => window.print()}>
                      Print
                    </Button>
                    <Button
                      variant="text"
                      color="error"
                      size="small"
                      disabled={String(r.status).toLowerCase().includes('ready') || String(r.status).toLowerCase().includes('cancel')}
                      onClick={() => ReservationHistoryService.cancelReservation(r.id)}
                    >
                      Cancel Reservation
                    </Button>
                  </Box>
                </Box>
              </CardContent>
            </Card>
          ))}
        </Box>
      )}
    </Container>
  );
};

export default ReservationsPage;


