import React from 'react';
import { Chip } from '@mui/material';
import {
  AllInclusive,
  Build,
  Power,
  Lightbulb,
  ElectricBolt,
  Cable,
  Category
} from '@mui/icons-material';

const CategoryButton = ({ label, icon, isSelected, onPressed }) => {
  const getIconComponent = (iconName) => {
    switch (iconName) {
      case 'all_inclusive':
        return <AllInclusive />;
      case 'build':
        return <Build />;
      case 'power':
        return <Power />;
      case 'lightbulb':
        return <Lightbulb />;
      case 'electric_bolt':
        return <ElectricBolt />;
      case 'cable':
        return <Cable />;
      default:
        return <Category />;
    }
  };

  return (
    <Chip
      icon={icon ? getIconComponent(icon) : undefined}
      label={label}
      onClick={onPressed}
      color={isSelected ? 'primary' : 'default'}
      variant={isSelected ? 'filled' : 'outlined'}
      sx={{
        minWidth: 'fit-content',
        whiteSpace: 'nowrap',
        borderRadius: '25px',
        padding: '12px 16px',
        fontSize: '13px',
        fontWeight: isSelected ? 600 : 500,
        boxShadow: isSelected ? '0 4px 8px rgba(211, 47, 47, 0.3)' : 'none',
        '&:hover': {
          backgroundColor: isSelected ? 'primary.dark' : 'action.hover'
        },
        '& .MuiChip-icon': {
          fontSize: '18px',
          color: isSelected ? 'white' : 'grey.700'
        }
      }}
    />
  );
};

export default CategoryButton;
