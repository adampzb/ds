#!/bin/bash

echo "🔍 Verifying Django + Angular Configuration"
echo "=========================================="
echo ""

# Check Django settings
echo "📋 Django Settings:"
echo "- STATICFILES_DIRS: $(grep -A1 "STATICFILES_DIRS" discussit/settings.py | tail -1)"
echo "- STATIC_ROOT: $(grep -A1 "STATIC_ROOT" discussit/settings.py | tail -1)"
echo ""

# Check Angular configuration
echo "📋 Angular Configuration:"
if [ -f "static/frontend/app/angular.json" ]; then
    echo "- Angular project found: static/frontend/app/"
    echo "- Output path: $(grep -A2 '"outputPath"' static/frontend/app/angular.json | tail -1 | sed 's/.*: "\(.*\)",/\1/')"
else
    echo "❌ Angular project not found!"
fi
echo ""

# Check CI/CD configuration
echo "📋 CI/CD Configuration:"
if grep -q "static/frontend/app" .github/workflows/angular-ci-cd.yml; then
    echo "✅ CI/CD uses correct frontend path"
else
    echo "❌ CI/CD has incorrect frontend path"
fi
echo ""

# Check .gitignore
echo "📋 Git Ignore Configuration:"
if grep -q "^staticfiles/" .gitignore; then
    echo "✅ staticfiles/ is properly ignored"
else
    echo "❌ staticfiles/ is not ignored"
fi
echo ""

# Check for duplicate directories
echo "📋 Duplicate Directory Check:"
if [ -d "static/frontend/reddit-app" ]; then
    echo "❌ Old reddit-app directory still exists"
else
    echo "✅ No duplicate frontend directories"
fi
echo ""

# Check package.json
echo "📋 Package Configuration:"
if [ -f "static/frontend/app/package.json" ]; then
    echo "✅ package.json exists"
    if grep -q "@angular" static/frontend/app/package.json; then
        echo "✅ Angular dependencies configured"
    else
        echo "❌ Angular dependencies missing"
    fi
else
    echo "❌ package.json not found"
fi
echo ""

echo "🎉 Configuration verification complete!"
