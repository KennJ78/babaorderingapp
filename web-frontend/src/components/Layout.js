import React from 'react';
import { Outlet, useNavigate, useLocation } from 'react-router-dom';
import {
  AppBar,
  Toolbar,
  Typography,
  IconButton,
  Badge,
  BottomNavigation,
  BottomNavigationAction,
  Box,
  Container
} from '@mui/material';
import { ShoppingCart, Store, ReceiptLong, Person, Logout } from '@mui/icons-material';
import ReservationService from '../services/ReservationService';

const Layout = ({ user, setIsLoggedIn }) => {
  const navigate = useNavigate();
  const location = useLocation();
  
  const getBottomNavValue = () => {
    if (location.pathname === '/') return 0;
    if (location.pathname === '/orders') return 1;
    if (location.pathname === '/profile') return 2;
    return 0;
  };

  const handleBottomNavChange = (event, newValue) => {
    switch (newValue) {
      case 0:
        navigate('/');
        break;
      case 1:
        navigate('/orders');
        break;
      case 2:
        navigate('/profile');
        break;
      default:
        break;
    }
  };

  const handleLogout = () => {
    setIsLoggedIn(false);
    navigate('/login');
  };

  const [reservationCount, setReservationCount] = React.useState(
    ReservationService.getItems().reduce((total, item) => total + (item.qty || 1), 0)
  );

  React.useEffect(() => {
    const handler = () => {
      const count = ReservationService.getItems().reduce((total, item) => total + (item.qty || 1), 0);
      setReservationCount(count);
    };
    window.addEventListener('reservationUpdated', handler);
    return () => window.removeEventListener('reservationUpdated', handler);
  }, []);

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <AppBar position="sticky" elevation={2} sx={{ 
        background: 'linear-gradient(90deg, #212121 0%, #303030 100%)', 
        color: '#ffffff',
        boxShadow: '0 4px 8px rgba(255, 193, 7, 0.1)'
      }}>
        <Toolbar>
          <Box display="flex" alignItems="center" sx={{ flexGrow: 1 }}>
            <img src="/assets/images/logo1.png" alt="BABA Hardware" style={{ height: 28, marginRight: 8 }} onError={(e) => { e.target.style.display = 'none'; }} />
            <Typography variant="h6" component="div" sx={{ fontWeight: 700, color: '#ffffff' }}>
              Hardware
            </Typography>
          </Box>
          <IconButton 
            onClick={() => navigate('/reservation/summary')} 
            sx={{ 
              mr: 1,
              color: '#ffffff',
              '&:hover': {
                backgroundColor: 'rgba(211, 47, 47, 0.1)'
              }
            }}
          >
            <Badge badgeContent={reservationCount} sx={{
              '& .MuiBadge-badge': {
                backgroundColor: '#FF9800',
                color: 'white'
              }
            }}>
              <ShoppingCart />
            </Badge>
          </IconButton>
          <IconButton 
            onClick={handleLogout}
            sx={{
              color: '#d32f2f',
              '&:hover': {
                backgroundColor: 'rgba(211, 47, 47, 0.1)'
              }
            }}
          >
            <Logout />
          </IconButton>
        </Toolbar>
      </AppBar>

      <Container maxWidth="lg" sx={{ flex: 1, py: 2 }}>
        <Outlet />
      </Container>

      <BottomNavigation
        value={getBottomNavValue()}
        onChange={handleBottomNavChange}
        sx={{
          position: 'fixed',
          bottom: 0,
          left: 0,
          right: 0,
          borderTop: 1,
          borderColor: 'divider',
          backgroundColor: '#FFFFFF',
          zIndex: 1000
        }}
      >
        <BottomNavigationAction
          label="Products"
          icon={<Store />}
          sx={{
            '&.Mui-selected': {
              color: '#d32f2f'
            }
          }}
        />
        <BottomNavigationAction
          label="Reservations"
          icon={<ReceiptLong />}
          sx={{
            '&.Mui-selected': {
              color: '#d32f2f'
            }
          }}
        />
        <BottomNavigationAction
          label="Profile"
          icon={<Person />}
          sx={{
            '&.Mui-selected': {
              color: '#d32f2f'
            }
          }}
        />
      </BottomNavigation>

      <Box sx={{ height: 56 }} /> {/* Spacer for bottom navigation */}
    </Box>
  );
};

export default Layout;
