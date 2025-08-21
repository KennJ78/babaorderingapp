import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import {
  Box,
  TextField,
  Button,
  Typography
} from '@mui/material';
import { mockUsers } from '../data/mockData';

const LoginPage = ({ setIsLoggedIn, setUser }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  // Same validation as Flutter
  const validateEmail = (email) => {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
  };

  const handleLogin = () => {
    // Clear previous errors
    setError('');

    const emailTrim = email.trim();

    // Same validation as Flutter: both empty
    if (emailTrim === '' && password === '') {
      setError('Email and password are required');
      return;
    }

    // Validate email
    if (emailTrim === '') {
      setError('Email is required');
      return;
    }
    if (!validateEmail(emailTrim)) {
      setError('Please enter a valid email address');
      return;
    }

    // Validate password
    if (password === '') {
      setError('Password is required');
      return;
    }

    // Check if user exists
    if (!mockUsers[emailTrim]) {
      setError('No account found with this email address');
      return;
    }

    // Verify password
    if (mockUsers[emailTrim].password !== password) {
      setError('Incorrect password');
      return;
    }

    // Login successful - same as Flutter
    setUser({
      name: mockUsers[emailTrim].name,
      email: emailTrim,
      profileImagePath: mockUsers[emailTrim].profileImagePath || ''
    });
    setIsLoggedIn(true);
    navigate('/');
  };

  return (
    <Box
      sx={{
        minHeight: '100vh',
        width: '100%',
        backgroundImage: 'url(/assets/images/bg.jpg)',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        position: 'relative',
        '&::before': {
          content: '""',
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'rgba(0, 0, 0, 0.4)',
          zIndex: 1
        }
      }}
    >
      {/* Welcome Text */}
      <Box
        sx={{
          position: 'absolute',
          right: { xs: '50%', md: '10%' },
          top: '50%',
          transform: { xs: 'translate(50%, -50%)', md: 'translateY(-50%)' },
          textAlign: { xs: 'center', md: 'left' },
          color: 'white',
          zIndex: 2,
          display: { xs: 'none', md: 'block' }
        }}
      >
        <Typography
          variant="h2"
          sx={{
            fontWeight: 'bold',
            mb: 2,
            textShadow: '2px 2px 4px rgba(0,0,0,0.5)'
          }}
        >
          WELCOME TO<br />
          BABA HARDWARE
        </Typography>
        <Typography
          variant="h6"
          sx={{
            maxWidth: 400,
            lineHeight: 1.6,
            textShadow: '1px 1px 2px rgba(0,0,0,0.5)'
          }}
        >
          Your trusted partner for all electrical supplies and hardware needs. 
          Quality products, competitive prices, and exceptional service since day one.
        </Typography>
      </Box>

      {/* Login Card */}
      <Box
        sx={{
          position: 'relative',
          zIndex: 2,
          left: { xs: 0, md: '-20%' }
        }}
      >
        <Box
          sx={{
            width: { xs: '90vw', sm: 400 },
            padding: 4,
            backgroundColor: '#212121',
            borderRadius: '25px',
            boxShadow: '0 10px 20px rgba(0, 0, 0, 0.3), 0 5px 30px rgba(255, 193, 7, 0.1)',
            mx: 2
          }}
        >
          <Box textAlign="center" mb={3}>
            <img
              src="/assets/images/logo1.png"
              alt="BABA Hardware"
              style={{ height: 100, width: 150, marginBottom: 16 }}
              onError={(e) => {
                e.target.style.display = 'none';
              }}
            />
            <Typography variant="h5" sx={{ color: 'white', fontWeight: 'bold' }}>
              Log In
            </Typography>
          </Box>

          {error && (
            <Typography sx={{ color: 'red', mb: 1, textAlign: 'center' }}>
              {error}
            </Typography>
          )}

          <Box sx={{ mb: 1.5 }}>
            <Typography sx={{ color: 'white', fontSize: 14, mb: 0.5 }}>
              Email
            </Typography>
            <TextField
              fullWidth
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Enter your email"
              sx={{
                '& .MuiOutlinedInput-root': {
                  backgroundColor: 'white',
                  borderRadius: 1
                }
              }}
            />
          </Box>

          <Box sx={{ mb: 2.5 }}>
            <Typography sx={{ color: 'white', fontSize: 14, mb: 0.5 }}>
              Password
            </Typography>
            <TextField
              fullWidth
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter your password"
              sx={{
                '& .MuiOutlinedInput-root': {
                  backgroundColor: 'white',
                  borderRadius: 1
                }
              }}
            />
          </Box>

          <Button
            fullWidth
            onClick={handleLogin}
            sx={{
              background: 'linear-gradient(90deg, #FFC107 0%, #FF9800 100%)',
              color: 'white',
              py: 1.5,
              borderRadius: 1.5,
              fontWeight: 'bold',
              fontSize: 16,
              textTransform: 'none',
              boxShadow: '0 4px 8px rgba(255, 193, 7, 0.3)',
              '&:hover': {
                background: 'linear-gradient(90deg, #FFB300 0%, #F57C00 100%)',
                boxShadow: '0 6px 12px rgba(255, 193, 7, 0.4)'
              }
            }}
          >
            Log in
          </Button>

          <Box textAlign="center" sx={{ mt: 2.5 }}>
            <Typography
              component={Link}
              to="/forgot-password"
              sx={{
                color: '#FFC107',
                textDecoration: 'underline',
                display: 'block',
                mb: 1.5
              }}
            >
              Forgot Password?
            </Typography>
            <Typography
              component={Link}
              to="/signup"
              sx={{
                color: '#FFC107',
                textDecoration: 'underline'
              }}
            >
              New to BABA Hardware? Sign up here
            </Typography>
          </Box>
        </Box>
      </Box>
    </Box>
  );
};

export default LoginPage;
