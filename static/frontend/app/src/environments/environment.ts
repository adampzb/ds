// Environment configuration for development
// Universal environment support - automatically detects runtime environment
export const environment = {
  production: false,
  baseUrl: '/api/v1/',
  
  // Dynamic server URL detection - Updated for Django backend
  serverUrl: (() => {
    if (typeof window === 'undefined') return 'http://localhost:8000';
    
    const hostname = window.location.hostname;
    
    // Local development - point to Django backend
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
      return 'http://localhost:8000';
    }
    
  
  // Dynamic app URL detection
  appUrl: (() => {
    if (typeof window === 'undefined') return 'http://localhost:12001';
    
    const hostname = window.location.hostname;
    
    // Local development
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
      return 'http://localhost:12001';
    }
    
    // Runtime environment - use current hostname for frontend
    if (hostname.includes('prod-runtime.all-hands.dev')) {
      return `https://${hostname}/`;
    }
    
  
  // Dynamic login URL
  get loginUrl() {
    return `${this.appUrl}/sign-in`;
  },
  
  staticUrl: '../assets/images/'
};
