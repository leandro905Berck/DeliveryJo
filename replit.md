# replit.md

## Overview

This is a hot dog ordering website for "Hot Dog da Dona Jo" that allows customers to browse and order hot dogs online. The system is designed with two main interfaces: a customer-facing ordering system and an administrative panel for managing orders and menu items. The application features a modern, responsive design using Bootstrap CSS framework with custom styling, JavaScript functionality for interactive features like shopping cart management, and a notification system for user feedback.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Technology Stack**: HTML5, CSS3, JavaScript (ES6+), Bootstrap framework
- **Design Pattern**: Multi-page application with modular JavaScript components
- **Styling Approach**: CSS custom properties (variables) for consistent theming, hover effects and animations for enhanced user experience
- **Component Structure**: Separated concerns with dedicated files for main functionality (`main.js`) and notifications (`notifications.js`)

### JavaScript Architecture
- **Event-Driven Design**: DOM content loaded event listeners for initialization
- **Modular Functions**: Cart management, freight calculation, form validations, and notification system as separate functional modules
- **Cart System**: Client-side cart functionality with add, remove, and quantity update operations
- **Notification System**: Class-based notification manager with automatic cleanup and positioning

### Backend Architecture
- **Database**: PostgreSQL with proper boolean handling and GROUP BY compliance
- **Order Management**: Complete order lifecycle from placement to customer confirmation
- **Notification System**: Admin and customer notifications for order status changes
- **Payment Integration**: Multiple payment methods (cash, PIX, debit/credit cards)
- **Delivery Confirmation**: Customer-initiated delivery confirmation system

### UI/UX Design Decisions
- **Color Scheme**: Primary red theme (#dc3545) with secondary yellow accents for food industry appeal
- **Interactive Elements**: Card hover animations, tooltips, and smooth transitions for better user engagement
- **Responsive Design**: Bootstrap grid system for mobile-first responsive layout
- **Visual Hierarchy**: Card-based layout for menu items with prominent call-to-action buttons
- **WhatsApp Integration**: Fixed floating action button with proper alignment and WhatsApp brand colors

### Form and Validation Architecture
- **Client-Side Validation**: JavaScript form validation for immediate user feedback
- **Auto-Hide Alerts**: Automatic dismissal of notification messages for better user experience
- **Tooltip Integration**: Bootstrap tooltips for additional user guidance

### Order Flow and Customer Experience
- **Delivery Confirmation**: Customers can confirm receipt when order status is "entregando"
- **Status Tracking**: Real-time order status updates with notifications
- **Payment Selection**: Required payment method selection during checkout

## External Dependencies

### Frontend Frameworks
- **Bootstrap**: CSS framework for responsive design and pre-built components
- **Bootstrap JavaScript**: For interactive components like tooltips, modals, and alerts

### Planned Backend Dependencies
- **MySQL Database**: For storing order data, menu items, and user information
- **Server Hosting**: Web server environment for application deployment
- **Administrative Interface**: Separate admin panel for order and menu management

### Browser APIs
- **DOM API**: For dynamic content manipulation and event handling
- **CSS Transitions**: For smooth animations and user interaction feedback