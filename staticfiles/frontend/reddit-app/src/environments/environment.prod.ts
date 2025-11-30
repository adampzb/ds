// Universal production environment configuration
// Automatically detects runtime environment and constructs URLs dynamically
function getProductionUrls() {
  if (typeof window === 'undefined') {
    // Server-side rendering fallback - use environment variables if available
    const runtimeId = process.env['RUNTIME_ID'] || 'localhost';
    if (runtimeId === 'localhost') {
      return {
        baseUrl: 'http://localhost:12000/api/v1/',
        serverUrl: 'http://localhost:12000',
        appUrl: 'http://localhost:12001/django_reddit',
        loginUrl: 'http://localhost:12001/django_reddit/sign-in',
        staticUrl: '/django_reddit/assets/images/'
      };
    }
    return {
      baseUrl: `https://work-1-${runtimeId}.prod-runtime.all-hands.dev/api/v1/`,
      serverUrl: `https://work-1-${runtimeId}.prod-runtime.all-hands.dev`,
      appUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit`,
      loginUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit/sign-in`,
      staticUrl: '/django_reddit/assets/images/'
    };
  }

  const hostname = window.location.hostname;
  
  if (hostname === 'localhost' || hostname === '127.0.0.1') {
    // Local development
    return {
      baseUrl: 'http://localhost:12000/api/v1/',
      serverUrl: 'http://localhost:12000',
      appUrl: 'http://localhost:12001/django_reddit',
      loginUrl: 'http://localhost:12001/django_reddit/sign-in',
      staticUrl: '/django_reddit/assets/images/'
    };
  } else if (hostname.includes('prod-runtime.all-hands.dev')) {
    // Extract runtime ID from hostname (e.g., work-2-gmpfoxllomfjuhqz.prod-runtime.all-hands.dev)
    const runtimeId = hostname.split('.')[0].split('-').slice(2).join('-');
    return {
      baseUrl: `https://work-1-${runtimeId}.prod-runtime.all-hands.dev/api/v1/`,
      serverUrl: `https://work-1-${runtimeId}.prod-runtime.all-hands.dev`,
      appUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit`,
      loginUrl: `https://work-2-${runtimeId}.prod-runtime.all-hands.dev/django_reddit/sign-in`,
      staticUrl: '/django_reddit/assets/images/'
    };
  } else {
    // Fallback for unknown environments
    return {
      baseUrl: window.location.protocol + '//' + hostname + ':12000/api/v1/',
      serverUrl: window.location.protocol + '//' + hostname + ':12000',
      appUrl: window.location.protocol + '//' + hostname + ':12001/django_reddit',
      loginUrl: window.location.protocol + '//' + hostname + ':12001/django_reddit/sign-in',
      staticUrl: '/django_reddit/assets/images/'
    };
  }
}

const prodUrls = getProductionUrls();

export const environment = {
  production: true,
  baseUrl: prodUrls.baseUrl,
  serverUrl: prodUrls.serverUrl,
  appUrl: prodUrls.appUrl,
  loginUrl: prodUrls.loginUrl,
  staticUrl: prodUrls.staticUrl
};
