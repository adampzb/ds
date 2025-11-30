# Node.js and Angular Compatibility Guide

## 🎯 Current Configuration (Tested & Working)

- **Node.js**: 22.21.0 (LTS)
- **npm**: 10.9.4
- **Angular**: 21.0.1
- **Angular CLI**: 21.0.1
- **TypeScript**: 5.9.3

## 📋 Official Angular Compatibility Matrix

Based on [Angular's official documentation](https://angular.dev/reference/versions):

| Angular Version | Node.js Version | TypeScript Version | RxJS Version | Status |
|----------------|-----------------|-------------------|--------------|---------|
| 21.0.x | ^22.12.0 \|\| ^24.0.0 | >=5.9.0 <6.0.0 | ^6.5.3 \|\| ^7.4.0 | ✅ Current |
| 20.2.x \|\| 20.3.x | ^20.19.0 \|\| ^22.12.0 \|\| ^24.0.0 | >=5.8.0 <6.0.0 | ^6.5.3 \|\| ^7.4.0 | ✅ Supported |
| 20.0.x \|\| 20.1.x | ^20.19.0 \|\| ^22.12.0 \|\| ^24.0.0 | >=5.8.0 <5.9.0 | ^6.5.3 \|\| ^7.4.0 | ✅ Supported |
| 19.2.x | ^18.19.1 \|\| ^20.11.1 \|\| ^22.0.0 | >=5.5.0 <5.9.0 | ^6.5.3 \|\| ^7.4.0 | ⚠️ Legacy |

## 🚨 Critical Requirements

### For Angular 21.0.x (Current Project Version)
- **Node.js**: MINIMUM 22.12.0 (we use 22.21.0)
- **npm**: MINIMUM 10.0.0 (we use 10.9.4)
- **TypeScript**: 5.9.0 to 5.9.x (we use 5.9.3)

### Why These Versions Matter
1. **Angular 21** uses modern JavaScript features that require Node.js 22.12+
2. **TypeScript 5.9** provides better type checking and performance
3. **npm 10+** has improved dependency resolution and security features

## 🔧 Installation Commands

### Install Node.js 22 LTS (Ubuntu/Debian)
```bash
# Remove old Node.js versions
sudo apt-get remove nodejs npm

# Install Node.js 22 LTS
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version  # Should show v22.21.0 or higher
npm --version   # Should show 10.9.4 or higher
```

### Install Node.js 22 LTS (macOS)
```bash
# Using Homebrew
brew install node@22

# Using nvm (recommended)
nvm install 22
nvm use 22
```

### Install Node.js 22 LTS (Windows)
```bash
# Download from official website
# https://nodejs.org/en/download/

# Or using Chocolatey
choco install nodejs --version=22.21.0

# Or using winget
winget install OpenJS.NodeJS
```

## 🛠️ Project Setup with Correct Versions

### 1. Verify Node.js Version
```bash
node --version
# Expected: v22.21.0 or higher (must be >= 22.12.0)

npm --version
# Expected: 10.9.4 or higher (must be >= 10.0.0)
```

### 2. Clean Installation
```bash
cd static/frontend/reddit-app

# Remove old dependencies
rm -rf node_modules package-lock.json

# Install with correct versions
npm install

# Verify no engine warnings
# Should install without EBADENGINE warnings
```

### 3. Build and Test
```bash
# Build for production
npm run build

# Should complete without errors in ~8-10 seconds
# No TypeScript compilation errors
# No Angular CLI version conflicts
```

## 🚨 Common Issues and Solutions

### Issue: "The Angular CLI requires a minimum Node.js version"
**Solution**: Upgrade Node.js to 22.12.0 or higher
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Issue: "npm warn EBADENGINE Unsupported engine"
**Solution**: This indicates version mismatch. Clean install with correct Node.js version:
```bash
rm -rf node_modules package-lock.json
npm install
```

### Issue: TypeScript compilation errors
**Solution**: Ensure TypeScript version is 5.9.x:
```bash
npm list typescript
# Should show 5.9.3
```

### Issue: Angular build fails with memory errors
**Solution**: Node.js 22 has better memory management. Ensure you're using 22.21.0+

## 📁 Project Files for Version Control

### .nvmrc
```
22.21.0
```

### package.json engines field
```json
{
  "engines": {
    "node": ">=22.12.0",
    "npm": ">=10.0.0"
  }
}
```

## 🔄 Upgrade Path

If you need to upgrade from older versions:

### From Angular 19/20 to 21
1. Upgrade Node.js to 22.12.0+
2. Update package.json dependencies
3. Run `ng update @angular/core @angular/cli`
4. Test thoroughly

### From Node.js 18/20 to 22
1. Install Node.js 22 LTS
2. Clean install dependencies
3. Rebuild Angular application
4. Update CI/CD pipelines

## 📚 References

- [Angular Version Compatibility](https://angular.dev/reference/versions)
- [Node.js Release Schedule](https://nodejs.org/en/about/releases/)
- [Angular Update Guide](https://update.angular.io/)
- [TypeScript Compatibility](https://www.typescriptlang.org/docs/handbook/release-notes/)

## ✅ Verification Checklist

- [ ] Node.js version >= 22.12.0
- [ ] npm version >= 10.0.0
- [ ] Angular CLI version 21.0.1
- [ ] TypeScript version 5.9.3
- [ ] No EBADENGINE warnings during npm install
- [ ] Angular build completes without errors
- [ ] Application loads correctly in browser

---

**Last Updated**: November 30, 2025
**Tested Configuration**: Node.js 22.21.0, Angular 21.0.1, TypeScript 5.9.3