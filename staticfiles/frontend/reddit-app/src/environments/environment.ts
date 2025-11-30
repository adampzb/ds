// Universal environment configuration
// Automatically detects runtime environment and constructs URLs dynamically
function getEnvironmentUrls() {
  if (typeof window === 'undefined') {
    // Server-side rendering fallback
    return {
      serverUrl: 'http://localhost:12000',
      appUrl: 'http://localhost:12001',
      loginUrl: 'http://localhost:12001/sign-in'
    };
  }

  const hostname = window.location.hostname;
  
  if (hostname === 'localhost' || hostname === '127.0.0.1') {
    // Local development
    return {
      serverUrl: 'http://localhost:12000',
      appUrl: 'http://localhost:12001',
      loginUrl: 'http://localhost:12001/sign-in'
    };
  } else if (hostname.includes('prod-runtime.all-hands.dev')) {
    // Extract runtime ID from hostname (e.g., work-2-gmpfoxllomfjuhqz.prod-runtime.all-hands.dev)
    const runtimeId = hostname.split('.')[0].split('-').slice(2).join('-');
    return {
      serverUrl: `https://work-1-${runtimeId}.prod-runtime.all-hands.dev`,
      appUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit`,
      loginUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit/sign-in`
    };
  } else {
    // Fallback for unknown environments
    return {
      serverUrl: window.location.protocol + '//' + hostname + ':12000',
      appUrl: window.location.protocol + '//' + hostname + ':12001',
      loginUrl: window.location.protocol + '//' + hostname + ':12001/sign-in'
    };
  }
}

const urls = getEnvironmentUrls();

export const environment = {
  production: false,
  baseUrl: '/api/v1/',
  serverUrl: urls.serverUrl,
  appUrl: urls.appUrl,
  loginUrl: urls.loginUrl,
  staticUrl: '../assets/images/'
};
