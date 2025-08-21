import React, { useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import HomePage from './pages/HomePage';
import CartPage from './pages/CartPage';
import ProfilePage from './pages/ProfilePage';
import ReservationsPage from './pages/ReservationsPage';
import ProductDetailPage from './pages/ProductDetailPage';
import Layout from './components/Layout';
import ReservationReceiptPage from './pages/ReservationReceiptPage';
import ReservationSummaryPage from './pages/ReservationSummaryPage';

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [user, setUser] = useState(null);

  return (
    <Routes>
      <Route 
        path="/login" 
        element={!isLoggedIn ? 
          <LoginPage setIsLoggedIn={setIsLoggedIn} setUser={setUser} /> : 
          <Navigate to="/" />
        } 
      />
      <Route 
        path="/signup" 
        element={!isLoggedIn ? 
          <SignupPage setIsLoggedIn={setIsLoggedIn} setUser={setUser} /> : 
          <Navigate to="/" />
        } 
      />
      
      <Route path="/" element={isLoggedIn ? <Layout user={user} setIsLoggedIn={setIsLoggedIn} /> : <Navigate to="/login" />}>
        <Route index element={<HomePage />} />
        
        <Route path="profile" element={<ProfilePage user={user} setUser={setUser} />} />
        <Route path="orders" element={<ReservationsPage />} />
        <Route path="product/:id" element={<ProductDetailPage />} />
        <Route path="reservation/summary" element={<ReservationSummaryPage />} />
        <Route path="reservation/receipt" element={<ReservationReceiptPage />} />
      </Route>
    </Routes>
  );
}

export default App;
