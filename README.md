# Flask Hello World App with Login

A simple Flask web application that demonstrates user authentication with a "Hello World" page.

## Features

- User authentication system
- Login/logout functionality
- Session management
- Bootstrap-styled responsive UI


## Login Procedure
- Service type loadbalancer in kubernetes will deploy a loadbalancer in AWS.Login to APP using the loadbalancer url/DNS in your respective aws account

## Demo Accounts

The application comes with three pre-configured demo accounts:

- **Username:** `hire-me@anshumat.org` | **Password:** `HireMe@2025!`



## 📁 Flask-App-main Repository Structure

```
Flask-App-main/
│
├── 📁 .github/
│   └── 📁 workflows/
│       ├── 📄 cd.yml                    # Infrastructure CI/CD Pipeline
│       └── 📄 cd-app.yml               # Application CI/CD Pipeline
│
├── 📁 app/                              # Flask Application Layer
│   ├── 📄 app.py                       # Main Flask Application
│   ├── 📄 Dockerfile                   # Multi-stage Docker Build
│   ├── 📄 requirements.txt             # Python Dependencies
│   │
│   ├── 📁 templates/                   # HTML Templates
│   │   ├── 📄 base.html               # Base Template (Bootstrap)
│   │   ├── 📄 login.html              # Login Page
│   │   └── 📄 hello.html              # Dashboard Page
│   │
│   ├── 📁 helm-chart/                  # Kubernetes Helm Chart
│   │   └── 📁 flask-app/
│   │       ├── 📄 Chart.yaml          # Helm Chart Metadata
│   │       ├── 📄 values.yaml         # Default Helm Values
│   │       └── 📁 templates/
│   │           ├── 📄 deployment.yaml # Kubernetes Deployment
│   │           └── 📄 service.yaml    # Kubernetes Service
│   │
│   └── 📁 terraform/                   # Application Terraform
│      
│    
│       
│       
│       
│      
│       
│
├── 📁 iac/                             # Infrastructure as Code
│   ├── 📄 EKS.tf                      # EKS Cluster Configuration
│   ├── 📄 vpc.tf                      # VPC Network Configuration
│   ├── 📄 s3.tf                       # S3 Bucket Configuration
│   ├── 📄 helm-deployment.tf          # Helm Deployment Config
│   ├── 📄 providers.tf                # Terraform Providers
│   ├── 📄 variables.tf                # Infrastructure Variables
│   ├── 📄 outputs.tf                  # Infrastructure Outputs
│   ├── 📄 terraform.tf                # Terraform Configuration
│   └── 📄 versions.tf                 # Version Constraints
│
└── 📄 README.md                        # Main Project Documentation
```

## How it Works

1. When you visit the root URL (`/`), you're redirected to the login page if not authenticated
2. Enter valid credentials to log in
3. Upon successful login, you're redirected to the "Hello World" page
4. The application uses Flask sessions to maintain login state
5. You can logout using the logout button

## Security Notes

- In production, change the `secret_key` in `app.py`
- Use a proper database instead of the in-memory user dictionary
- Implement proper password complexity requirements
- Add rate limiting for login attempts
- Use HTTPS in production

## Customization

- Modify the user accounts in the `users` dictionary in `app.py`
- Update the styling by editing the CSS in `templates/base.html`
- Add more pages by creating new routes in `app.py` and corresponding templates

## CI/CD -
- cd.yml is used to manage the AWS EKS service.
- ci.yml is used for containerization part, uploading image to dockerhub and updating helm with new container image version.
- cd-app.yml is used to deploy the helm chart to EKS cluster.

## In-Progress Work
- Add deployemnt of app which is done via helm chart using Terraform.