#!/bin/bash

# Node.js and Angular Compatibility Checker
# This script verifies that the correct versions are installed

echo "🔍 Checking Node.js and Angular Compatibility..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Required versions
REQUIRED_NODE_MAJOR=22
REQUIRED_NODE_MINOR=12
REQUIRED_NPM_MAJOR=10
REQUIRED_ANGULAR_MAJOR=21

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed${NC}"
    echo "Please install Node.js 22.12.0 or higher"
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node --version | sed 's/v//')
NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1)
NODE_MINOR=$(echo $NODE_VERSION | cut -d. -f2)

echo "📦 Node.js version: v$NODE_VERSION"

if [ "$NODE_MAJOR" -gt "$REQUIRED_NODE_MAJOR" ] || 
   ([ "$NODE_MAJOR" -eq "$REQUIRED_NODE_MAJOR" ] && [ "$NODE_MINOR" -ge "$REQUIRED_NODE_MINOR" ]); then
    echo -e "${GREEN}✅ Node.js version is compatible${NC}"
else
    echo -e "${RED}❌ Node.js version is too old${NC}"
    echo "Required: v$REQUIRED_NODE_MAJOR.$REQUIRED_NODE_MINOR.0 or higher"
    echo "Current: v$NODE_VERSION"
    echo ""
    echo "To upgrade Node.js:"
    echo "curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -"
    echo "sudo apt-get install -y nodejs"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed${NC}"
    exit 1
fi

# Check npm version
NPM_VERSION=$(npm --version)
NPM_MAJOR=$(echo $NPM_VERSION | cut -d. -f1)

echo "📦 npm version: $NPM_VERSION"

if [ "$NPM_MAJOR" -ge "$REQUIRED_NPM_MAJOR" ]; then
    echo -e "${GREEN}✅ npm version is compatible${NC}"
else
    echo -e "${RED}❌ npm version is too old${NC}"
    echo "Required: $REQUIRED_NPM_MAJOR.0.0 or higher"
    echo "Current: $NPM_VERSION"
    echo ""
    echo "npm should be updated automatically with Node.js 22+"
    exit 1
fi

# Check if we're in the Angular project directory
ANGULAR_DIR="static/frontend/reddit-app"
if [ ! -d "$ANGULAR_DIR" ]; then
    echo -e "${YELLOW}⚠️  Angular project directory not found: $ANGULAR_DIR${NC}"
    echo "Please run this script from the project root directory"
    exit 1
fi

# Check Angular CLI
if ! command -v ng &> /dev/null; then
    echo -e "${YELLOW}⚠️  Angular CLI not found globally${NC}"
    echo "Checking local Angular CLI..."
    
    if [ -f "$ANGULAR_DIR/node_modules/.bin/ng" ]; then
        echo -e "${GREEN}✅ Local Angular CLI found${NC}"
        NG_CMD="$ANGULAR_DIR/node_modules/.bin/ng"
    else
        echo -e "${RED}❌ Angular CLI not found${NC}"
        echo "Please install Angular CLI: npm install -g @angular/cli@21"
        exit 1
    fi
else
    NG_CMD="ng"
fi

# Check Angular version
cd "$ANGULAR_DIR"
if [ -f "package.json" ]; then
    ANGULAR_VERSION=$(node -p "require('./package.json').dependencies['@angular/core']" 2>/dev/null | sed 's/[\^~]//')
    if [ "$ANGULAR_VERSION" != "undefined" ]; then
        ANGULAR_MAJOR=$(echo $ANGULAR_VERSION | cut -d. -f1)
        echo "📦 Angular version: $ANGULAR_VERSION"
        
        if [ "$ANGULAR_MAJOR" -eq "$REQUIRED_ANGULAR_MAJOR" ]; then
            echo -e "${GREEN}✅ Angular version is compatible${NC}"
        else
            echo -e "${YELLOW}⚠️  Angular version mismatch${NC}"
            echo "Expected: $REQUIRED_ANGULAR_MAJOR.x.x"
            echo "Current: $ANGULAR_VERSION"
        fi
    fi
fi

# Check TypeScript version
if [ -f "package.json" ]; then
    TS_VERSION=$(node -p "require('./package.json').devDependencies['typescript']" 2>/dev/null | sed 's/[~^]//')
    if [ "$TS_VERSION" != "undefined" ]; then
        echo "📦 TypeScript version: $TS_VERSION"
        
        TS_MAJOR=$(echo $TS_VERSION | cut -d. -f1)
        TS_MINOR=$(echo $TS_VERSION | cut -d. -f2)
        
        if [ "$TS_MAJOR" -eq "5" ] && [ "$TS_MINOR" -eq "9" ]; then
            echo -e "${GREEN}✅ TypeScript version is compatible${NC}"
        else
            echo -e "${YELLOW}⚠️  TypeScript version may not be optimal${NC}"
            echo "Recommended: 5.9.x"
            echo "Current: $TS_VERSION"
        fi
    fi
fi

echo ""
echo "=================================================="
echo -e "${GREEN}🎉 Compatibility check completed!${NC}"
echo ""
echo "Next steps:"
echo "1. cd $ANGULAR_DIR"
echo "2. npm install"
echo "3. npm run build"
echo ""
echo "For detailed compatibility information, see:"
echo "📖 NODEJS_ANGULAR_COMPATIBILITY.md"