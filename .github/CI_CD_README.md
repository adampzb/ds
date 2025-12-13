# 🚀 DiscussIt CI/CD Pipeline

This repository uses GitHub Actions for continuous integration and deployment. The pipeline is designed to ensure code quality, security, and smooth deployments.

## 📋 Workflows Overview

### 1. Django CI/CD Pipeline (`django-ci-cd.yml`)

**Triggers:**
- Pushes to `main`, `develop`, or `feature/*` branches
- Pull requests to `main` or `develop`
- Changes to Django-related files

**Jobs:**
1. **Test**: Runs Django tests, linting, and security checks
2. **Build**: Builds Docker image and pushes to GitHub Container Registry
3. **Deploy Staging**: Deploys to staging server (develop branch)
4. **Deploy Production**: Deploys to production server (main branch)

**Features:**
- Python 3.10.12 with Django 5.2.8
- PostgreSQL service for testing
- Bandit and Safety security scans
- Flake8 and Black code formatting
- Docker multi-stage builds with caching
- SSH-based deployment to servers

### 2. Angular CI/CD Pipeline (`angular-ci-cd.yml`)

**Triggers:**
- Pushes to `main`, `develop`, or `feature/*` branches
- Pull requests to `main` or `develop`
- Changes to Angular frontend files

**Jobs:**
1. **Test**: Runs Angular tests and linting
2. **Build**: Builds Angular production bundle
3. **Deploy Staging**: Deploys Angular build to staging
4. **Deploy Production**: Deploys Angular build to production

**Features:**
- Node.js 20 with Angular CLI 21.0.3
- ChromeHeadless for testing
- Angular production builds with AOT
- Artifact upload for build sharing
- SSH-based deployment

### 3. Security Scan (`security-scan.yml`)

**Triggers:**
- Pushes to `main` or `develop`
- Pull requests to `main` or `develop`
- Weekly schedule (Sundays at midnight)

**Jobs:**
1. **Security Scan**: Runs Bandit, Safety, and Django Audit
2. **CodeQL Analysis**: GitHub's code analysis
3. **Trivy Scan**: Container vulnerability scanning

**Features:**
- Bandit: Python code security scanner
- Safety: Dependency vulnerability checker
- Django Audit: Django-specific security checks
- CodeQL: Advanced code analysis
- Trivy: Container vulnerability scanning
- PR comments with security results

## 🔧 Setup Instructions

### Prerequisites

1. **GitHub Secrets**: Set up the following secrets in your repository:
   - `STAGING_SSH_HOST`: Staging server hostname/IP
   - `STAGING_SSH_USER`: Staging server username
   - `STAGING_SSH_KEY`: Staging server SSH private key
   - `PROD_SSH_HOST`: Production server hostname/IP
   - `PROD_SSH_USER`: Production server username
   - `PROD_SSH_KEY`: Production server SSH private key

2. **Server Setup**: Ensure your servers have:
   - Docker and Docker Compose installed
   - Proper directory structure (`/opt/discussit`)
   - Git installed
   - Proper firewall rules for SSH

### Deployment Process

#### Staging Deployment
1. Push code to `develop` branch
2. GitHub Actions automatically:
   - Runs Django tests
   - Builds Docker image
   - Deploys to staging server
   - Restarts containers

#### Production Deployment
1. Merge code to `main` branch (via PR)
2. GitHub Actions automatically:
   - Runs Django tests
   - Builds Docker image
   - Deploys to production server
   - Restarts containers

## 🎯 Best Practices

### Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch
- `feature/*`: Feature branches
- Use pull requests for all changes

### Testing
- All tests must pass before deployment
- Code must pass linting checks
- Security scans must pass
- PRs require at least 1 approval

### Deployment
- Staging deploys on `develop` branch
- Production deploys on `main` branch
- Manual approval for production (via PR merge)
- Rollback via Git revert if needed

## 📊 Monitoring

### Workflow Badges

Add these to your README.md:

```markdown
[![Django CI/CD](https://github.com/adampzb/7/actions/workflows/django-ci-cd.yml/badge.svg)](https://github.com/adampzb/7/actions/workflows/django-ci-cd.yml)
[![Angular CI/CD](https://github.com/adampzb/7/actions/workflows/angular-ci-cd.yml/badge.svg)](https://github.com/adampzb/7/actions/workflows/angular-ci-cd.yml)
[![Security Scan](https://github.com/adampzb/7/actions/workflows/security-scan.yml/badge.svg)](https://github.com/adampzb/7/actions/workflows/security-scan.yml)
```

### Viewing Results

1. Go to **Actions** tab in GitHub
2. Click on the workflow you want to inspect
3. View logs, artifacts, and deployment status

## 🔒 Security

### Secrets Management
- Never hardcode secrets in workflows
- Use GitHub Secrets for sensitive data
- Rotate secrets regularly
- Limit access to secrets

### Security Scans
- Weekly automated security scans
- PR comments with security results
- CodeQL for advanced analysis
- Trivy for container scanning

## 🚀 Maintenance

### Updating Dependencies
1. Update `requirements.txt` for Python
2. Update `package.json` for Angular
3. Push changes to trigger CI/CD

### Adding New Workflows
1. Create new YAML file in `.github/workflows/`
2. Follow existing patterns
3. Test locally if possible
4. Push and monitor

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Django Testing](https://docs.djangoproject.com/en/stable/topics/testing/)
- [Angular CLI](https://angular.io/cli)
- [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

**Maintainers**: Update this README when making significant changes to the CI/CD pipeline.