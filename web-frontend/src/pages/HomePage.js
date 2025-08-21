import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Box,
  TextField,
  InputAdornment,
  Chip,
  Grid,
  Typography,
  Container
} from '@mui/material';
import { Search, Clear } from '@mui/icons-material';
import ProductCard from '../components/ProductCard';
import CategoryButton from '../components/CategoryButton';
import DataService from '../services/DataService';

const HomePage = () => {
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [searchQuery, setSearchQuery] = useState('');
  const navigate = useNavigate();

  // Use exact same logic as Flutter DataService
  const categories = DataService.getAllCategories();
  const filteredProducts = useMemo(() => {
    return DataService.getFilteredProducts({
      categoryId: selectedCategory,
      searchQuery: searchQuery,
      availableOnly: false
    });
  }, [selectedCategory, searchQuery]);

  const handleProductClick = (product) => {
    navigate(`/product/${product.id}`, { state: { product } });
  };

  const handleSearchClear = () => {
    setSearchQuery('');
  };

  return (
    <Container maxWidth="lg">
      <Box sx={{ mb: 3 }}>
        <TextField
          fullWidth
          placeholder="Search products..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                <Search />
              </InputAdornment>
            ),
            endAdornment: searchQuery && (
              <InputAdornment position="end">
                <Clear
                  sx={{ cursor: 'pointer' }}
                  onClick={handleSearchClear}
                />
              </InputAdornment>
            ),
          }}
          sx={{
            '& .MuiOutlinedInput-root': {
              borderRadius: 8,
              backgroundColor: '#FFFFFF'
            },
            '& input::placeholder': {
              color: '#9E9E9E',
              opacity: 1
            }
          }}
        />
      </Box>

      <Box sx={{ mb: 3 }}>
        <Box
          sx={{
            display: 'flex',
            gap: 1,
            overflowX: 'auto',
            pb: 1,
            '&::-webkit-scrollbar': {
              height: 6,
            },
            '&::-webkit-scrollbar-track': {
              backgroundColor: '#f1f1f1',
              borderRadius: 3,
            },
            '&::-webkit-scrollbar-thumb': {
              backgroundColor: '#d32f2f',
              borderRadius: 3,
            },
          }}
        >
          {categories.map((category) => (
            <CategoryButton
              key={category.id}
              label={category.name}
              icon={category.icon}
              isSelected={selectedCategory === category.id}
              onPressed={() => setSelectedCategory(category.id)}
            />
          ))}
        </Box>
      </Box>

      {filteredProducts.length === 0 ? (
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
          <Search sx={{ fontSize: 64, color: 'grey.400', mb: 2 }} />
          <Typography variant="h6" color="text.secondary" gutterBottom>
            No products found
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Try adjusting your search or category filter
          </Typography>
        </Box>
      ) : (
        <Grid container spacing={2}>
          {filteredProducts.map((product) => (
            <Grid item xs={6} sm={4} md={3} key={product.id}>
              <ProductCard
                product={product}
                onClick={() => handleProductClick(product)}
              />
            </Grid>
          ))}
        </Grid>
      )}
    </Container>
  );
};

export default HomePage;
