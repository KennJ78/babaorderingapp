import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import App from './App';

const theme = createTheme({
  palette: {
    mode: 'light',
    primary: { main: '#FFC107' },
    secondary: { main: '#FF9800' },
    background: {
      default: '#FFFFFF',
      paper: '#FFFFFF',
    },
    text: {
      primary: '#212121',
      secondary: '#616161',
    },
  },
  typography: { fontFamily: 'Roboto, Arial, sans-serif' },
  components: {
    MuiAppBar: {
      styleOverrides: {
        root: {
          backgroundColor: '#d32f2f',
        },
      },
    },
    MuiButton: {
      styleOverrides: {
        containedPrimary: {
          background: 'linear-gradient(90deg, #FFC107 0%, #FF9800 100%)',
          color: '#fff',
          '&:hover': {
            background: 'linear-gradient(90deg, #FFB300 0%, #F57C00 100%)',
          },
        },
      },
    },
    MuiPaper: {
      styleOverrides: {
        root: {
          backgroundColor: '#FFFFFF',
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          backgroundColor: '#FFFFFF',
        },
      },
    },
    MuiOutlinedInput: {
      styleOverrides: {
        root: {
          backgroundColor: '#FFFFFF',
          borderRadius: 8,
        },
        input: {
          color: '#212121',
          '::placeholder': {
            color: '#9E9E9E',
            opacity: 1,
          },
        },
        notchedOutline: {
          borderColor: '#E0E0E0',
        },
      },
    },
    MuiInputBase: {
      styleOverrides: {
        input: {
          color: '#212121',
          '::placeholder': {
            color: '#9E9E9E',
            opacity: 1,
          },
        },
      },
    },
    MuiInputLabel: {
      styleOverrides: {
        root: { color: '#757575' },
      },
    },
    MuiInputAdornment: {
      styleOverrides: {
        root: { color: '#757575' },
      },
    },
  },
});

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <App />
      </ThemeProvider>
    </BrowserRouter>
  </React.StrictMode>
);

