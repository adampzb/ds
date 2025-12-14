# DiscussIt Quick Start Deployment Guide

## 📋 Server Specifications

**Our Server (OH):**
- **IP**: 51.15.115.36
- **OS**: Ubuntu 24.04.3 LTS
- **CPU**: 4 cores
- **RAM**: 8GB
- **Storage**: 27GB SSD
- **Python**: 3.12.3
- **Docker**: 28.2.2
- **Project Path**: /root/7/

## 🚀 Fast Deployment (Docker Method)

### 1. Connect to Server
```bash
ssh root@51.15.115.36
```

For our specific server (OH):
```bash
ssh root@51.15.115.36
```

### 2. Install Dependencies
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git docker.io docker-compose nginx certbot python3-certbot-nginx
```

### 3. Clone and Deploy
```bash
git clone https://github.com/adampzb/7.git
cd 7
cp .env.example .env
nano .env  # Update SECRET_KEY, ALLOWED_HOSTS, DATABASE_URL
```

For our server, update .env with:
```
ALLOWED_HOSTS=51.15.115.36,localhost,OH
SECRET_KEY=your-secure-secret-key-here
DEBUG=False
DATABASE_URL=postgres://discussit_user:secure_password@db:5432/discussit
```

### 4. Start Application
```bash
sudo docker-compose build
sudo docker-compose up -d
sudo docker-compose exec web python manage.py migrate
sudo docker-compose exec web python manage.py createsuperuser
sudo docker-compose exec web python manage.py collectstatic --noinput
```

### 5. Configure Nginx
```bash
sudo nano /etc/nginx/sites-available/discussit
```

Add this configuration (for our server):
```nginx
server {
    listen 80;
    server_name 51.15.115.36 OH;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /root/7/static/;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/discussit /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### 6. Set Up SSL (Optional but Recommended)
```bash
sudo certbot --nginx -d your_domain.com
```

## ✅ Access Your Application

- **Direct IP**: `http://51.15.115.36:8000`
- **Server Name**: `http://OH:8000`
- **Admin Panel**: `http://51.15.115.36:8000/admin`

For our specific server (OH at 51.15.115.36):
- **Application**: `http://51.15.115.36:8000`
- **Admin**: `http://51.15.115.36:8000/admin`
- **API**: `http://51.15.115.36:8000/api/`

## 🔧 Common Commands

### Application Management
```bash
# Start application
sudo docker-compose up -d

# Stop application
sudo docker-compose down

# View logs
sudo docker-compose logs -f

# Restart
sudo docker-compose restart

# Update
cd /path/to/discussit
git pull origin main
sudo docker-compose down
sudo docker-compose build
sudo docker-compose up -d
```

### Database Management
```bash
# Backup
sudo docker-compose exec db pg_dump -U postgres discussit > backup.sql

# Restore
cat backup.sql | sudo docker-compose exec -T db psql -U postgres discussit

# Run migrations
sudo docker-compose exec web python manage.py migrate
```

### Troubleshooting
```bash
# Check running containers
sudo docker ps -a

# Check container status
sudo docker-compose ps

# View specific container logs
sudo docker logs discussit_web

# Check Nginx status
sudo systemctl status nginx

# Check firewall
sudo ufw status
```

## 📋 Testing Checklist

- [ ] Homepage loads without errors
- [ ] User registration works
- [ ] Login/logout functionality
- [ ] Post creation and viewing
- [ ] Comment system
- [ ] Search functionality
- [ ] Admin panel accessible
- [ ] Static files load correctly
- [ ] API endpoints respond

## 🔒 Security Checklist

- [ ] Change default SECRET_KEY
- [ ] Set DEBUG=False
- [ ] Configure proper ALLOWED_HOSTS
- [ ] Set up SSL certificate
- [ ] Configure firewall
- [ ] Change SSH port and disable root login
- [ ] Set up regular backups
- [ ] Enable automatic security updates

## 📚 Resources

- **Django Documentation**: https://docs.djangoproject.com/
- **Docker Documentation**: https://docs.docker.com/
- **Nginx Documentation**: https://nginx.org/en/docs/
- **Let's Encrypt**: https://letsencrypt.org/
