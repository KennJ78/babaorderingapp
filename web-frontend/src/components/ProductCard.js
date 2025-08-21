import React from 'react';
import {
  Card,
  CardMedia,
  CardContent,
  Typography,
  Box,
  Chip
} from '@mui/material';

const ProductCard = ({ product, onClick }) => {
  return (
    <Card
      sx={{
        height: 280,
        cursor: 'pointer',
        transition: 'transform 0.2s, box-shadow 0.2s',
        '&:hover': {
          transform: 'translateY(-4px)',
          boxShadow: 6
        }
      }}
      onClick={onClick}
    >
      <CardMedia
        component="img"
        height="160"
        image={product.imagePath}
        alt={product.name}
        sx={{
          objectFit: 'cover'
        }}
        onError={(e) => {
          e.target.src = 'https://via.placeholder.com/300x160?text=No+Image';
        }}
      />
      <CardContent sx={{ p: 2 }}>
        <Typography
          variant="subtitle1"
          component="h3"
          sx={{
            fontWeight: 600,
            fontSize: '0.9rem',
            mb: 1,
            overflow: 'hidden',
            textOverflow: 'ellipsis',
            whiteSpace: 'nowrap'
          }}
        >
          {product.name}
        </Typography>
        
        <Typography
          variant="h6"
          color="primary"
          sx={{
            fontWeight: 'bold',
            fontSize: '1rem',
            mb: 1
          }}
        >
          {product.price}
        </Typography>
        
        <Box display="flex" justifyContent="space-between" alignItems="center">
          <Typography
            variant="caption"
            color="text.secondary"
            sx={{ fontSize: '0.75rem' }}
          >
            Sold: {product.soldCount}
          </Typography>
          <Chip label="Available" size="small" color="success" variant="outlined" sx={{ fontSize: '0.7rem' }} />
        </Box>
      </CardContent>
    </Card>
  );
};

export default ProductCard;
