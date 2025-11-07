# Final Project Demo - Step by Step Guide

## Step 1: Setup
Generate a secure password for NiFi.
```bash
make setup
```

**What happens:**
- Generates a random password
- Saves it to your `.env` file

**Output:**
```
🔑 Generating a password...
✅ Password generated.
🔐 Password updated in .env file.
```

---

## Step 2: Start Services
Start NiFi, NiFi Registry, and NiFi Toolkit.
```bash
make up
```

**What happens:**
- Starts Docker containers for all services
- NiFi, NiFi Registry, and NiFi Toolkit begin running

**Output:**
```
🚀 Starting NiFi, NiFi Registry, and NiFi Toolkit ...
✅ Services started.
```

**⏰ Wait 2-3 minutes** for NiFi to fully start before logging in.

---

## Step 3: Get Your Credentials
Display your username, password, and access URLs.
```bash
make echo
```

**Output:**
```
NIFI_USERNAME: admin
NIFI_PASSWORD: d6050b8543e409de054cc0d43d56ae34
✅ NiFi:          https://localhost:8443/nifi
✅ NiFi Registry: http://localhost:18080/nifi-registry
🔗 Access the services using the above URLs.
```

**Copy these credentials** to log into NiFi.

---

## Step 4: Access NiFi
Open your browser and go to:

**https://localhost:8443/nifi**

Login with:
- **Username:** `admin`
- **Password:** (from `make echo`)

---

## Step 5: Check Logs (Optional)
Monitor NiFi startup progress.
```bash
make logs-nifi
```

**Look for this message:**
```
NiFi has started
```

Press `Ctrl+C` to exit logs.

---

## Step 6: Stop Services
When you're done, stop all services.
```bash
make down
```

**Output:**
```
🛑 Stopping NiFi, NiFi Registry, and NiFi Toolkit...
✅ Services stopped.
```

---

## Complete Workflow Example
```bash
# 1. Generate password first
make setup

# 2. Start services
make up

# 3. Wait 2-3 minutes, then get credentials
make echo

# 4. Open browser: https://localhost:8443/nifi
#    Login with credentials from step 3

# 5. When done, stop services
make down
```

---

## Other Useful Commands

### Start and show credentials in one command
```bash
make all
```

### View all logs
```bash
make logs
```

### View NiFi logs only
```bash
make logs-nifi
```

### View NiFi Registry logs only
```bash
make logs-registry
```

### View NiFi Toolkit logs only
```bash
make logs-toolkit
```

### Access NiFi Toolkit CLI
```bash
make shell-toolkit
```

**What this does:**
- Opens an interactive shell in the toolkit container
- Allows you to run NiFi CLI commands
- Type `exit` to quit

### Clean up all volumes (⚠️ Removes all data)
```bash
make down
make clean-volumes
```

---

## Troubleshooting

### Can't login? Reset credentials:
```bash
make down
make clean-volumes
make setup
make up
# Wait 2-3 minutes
make echo
```

### Check if NiFi is ready:
```bash
make logs-nifi
# Look for "NiFi has started"
```

### Services won't start?
```bash
# Check if containers are running
docker ps

# View error logs
make logs

# Complete reset
make down
make clean-volumes
make setup
make up
```

### Toolkit container issues?
```bash
# Check toolkit logs
make logs-toolkit

# Access toolkit shell
make shell-toolkit
```

---

## Quick Reference

| Command              | Purpose                           |
|----------------------|-----------------------------------|
| `make setup`         | Generate secure password          |
| `make up`            | Start all services                |
| `make echo`          | Show credentials and URLs         |
| `make all`           | Start services + show credentials |
| `make down`          | Stop all services                 |
| `make logs`          | View all logs                     |
| `make logs-nifi`     | View NiFi logs only               |
| `make logs-registry` | View Registry logs only           |
| `make logs-toolkit`  | View Toolkit logs only            |
| `make shell-toolkit` | Access NiFi CLI toolkit           |
| `make clean-volumes` | Remove all data volumes           |