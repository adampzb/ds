"""
Gunicorn configuration for DiscussIt production deployment.

This configuration provides optimal settings for running Django in production
with Gunicorn as the WSGI server.
"""

import multiprocessing
import os

# Server Socket
bind = "0.0.0.0:8000"
backlog = 2048

# Worker Processes
workers = multiprocessing.cpu_count() * 2 + 1
worker_class = "gthread"
worker_connections = 1000
max_requests = 1000
max_requests_jitter = 50
timeout = 300
graceful_timeout = 30
keepalive = 5

# Logging
accesslog = "-"
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'
errorlog = "-"
loglevel = "info"
capture_output = True

# Process Name
proc_name = "discussit"

# Security
def post_fork(server, worker):
    """Worker post-fork hook for security and performance."""
    worker.log.info("Worker spawned (pid: %s)", worker.pid)

def pre_fork(server, worker):
    """Worker pre-fork hook."""
    pass

def pre_exec(server):
    """Master pre-exec hook."""
    server.log.info("Forked child, re-executing.")

def when_ready(server):
    """Called just after the server is started."""
    server.log.info("Server is ready. Spawning workers")

# Environment
raw_env = [
    "DJANGO_SETTINGS_MODULE=discussit.settings_production",
]

# Performance
limit_request_line = 4094
limit_request_fields = 100
limit_request_field_size = 8190

# SSL (uncomment and configure for HTTPS)
# certfile = "/path/to/cert.pem"
# keyfile = "/path/to/key.pem"
# ssl_version = 2

# Health check endpoint
def on_starting(server):
    """Called just before the master process is initialized."""
    server.log.info("Starting DiscussIt server...")
    server.log.info(f"Workers: {workers}")
    server.log.info(f"Worker class: {worker_class}")
    server.log.info(f"Bind: {bind}")
    server.log.info(f"Timeout: {timeout}s")

# Worker exit
def worker_exit(server, worker):
    """Called just after a worker has been exited, in the master process."""
    server.log.info("Worker exited (pid: %s)", worker.pid)

# Configuration for different environments
env = os.environ.get("ENVIRONMENT", "production")

if env == "development":
    workers = 2
    worker_class = "sync"
    loglevel = "debug"
    reload = True
elif env == "staging":
    workers = multiprocessing.cpu_count() + 1
    worker_class = "gevent"

print(f"🚀 Starting DiscussIt with Gunicorn")
print(f"📊 Environment: {env}")
print(f"👷 Workers: {workers}")
print(f"🔧 Worker Class: {worker_class}")
print(f"🌐 Bind: {bind}")