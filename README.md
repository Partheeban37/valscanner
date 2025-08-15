# Vulnerability Scanner

A Dockerized **Vulnerability Scanner** web application with a **React frontend**, **Flask backend**, and **PostgreSQL database**, fully orchestrated with **Terraform**. The app allows scanning an IP or domain using **Nmap** and displays results in a hacker-style UI.

---

## **Features**

* Scan IPs or domain names using Nmap.
* Display results in a **readable terminal-like UI**.
* Highlight open ports and services.
* **Dockerized architecture** for frontend, backend, and database.
* **Terraform-managed infrastructure** for easy deployment.
* CORS enabled for API communication.
* Persistent PostgreSQL data with Docker volume.

---

## **Technology Stack**

* **Frontend:** React, CSS
* **Backend:** Flask, Python
* **Database:** PostgreSQL
* **Containerization:** Docker
* **Infrastructure:** Terraform

---

## **Prerequisites**

* Docker & Docker Compose installed
* Terraform installed
* Nmap installed on the host machine (required for scanning)
* Git (to clone repository)

---

## **Getting Started**

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/vulnscan-infra.git
cd vulnscan-infra
```

2. **Set up Terraform variables** in `terraform.tfvars`:

```hcl
db_user     = "your_db_user"
db_password = "your_db_password"
db_name     = "vulnscan_db"
```

3. **Stop any running containers** (optional but recommended):

```bash
docker stop vulnscan-frontend vulnscan-backend vulnscan-db
docker rm vulnscan-frontend vulnscan-backend vulnscan-db
docker network rm vulnscan-net
```

4. **Apply Terraform configuration** to start all containers:

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
```

* Frontend container runs on `http://localhost:3000`
* Backend API runs on `http://localhost:5000`

---

## **Usage**

1. Open your browser and navigate to:
   `http://localhost:3000`

2. Enter an IP address or domain in the input box.

3. Click **Run Scan**.

4. View the scan results in a **hacker-style terminal UI**.

---

## **Project Structure**

```
vulnscan-infra/
├── backend/        # Flask backend (app.py)
├── frontend/       # React frontend
├── main.tf         # Terraform resources for containers and network
├── providers.tf    # Terraform provider configuration
├── variables.tf    # Terraform variables
├── terraform.tfvars# Terraform variable values
├── outputs.tf      # Terraform outputs
└── versions.tf     # Terraform required versions
```

---

## **Features Planned / Enhancements**

* Better UI with hacker-style themes (implemented)
* Colored port/service highlights
* Responsive design
* Easy-to-read scan output without JSON formatting

---

## **Stopping and Restarting**

* To **stop containers**:

```bash
docker stop vulnscan-frontend vulnscan-backend vulnscan-db
```

* To **start everything again**:

```bash
terraform apply -var-file="terraform.tfvars"
```

---

## **Contributing**

* Fork the repository and make your changes.
* Submit a pull request with detailed description of changes.
* Make sure Docker images build correctly before submitting PR.

---

<img width="1920" height="1080" alt="Screenshot_16-Aug_01-21-06_23062" src="https://github.com/user-attachments/assets/a7f3dc5c-10a7-4417-b2f3-6cc3e2e0642f" />

<img width="1920" height="1080" alt="Screenshot_16-Aug_01-21-47_22757" src="https://github.com/user-attachments/assets/2b125cd1-fcb9-4c80-b9b6-945bc94e5231" />

