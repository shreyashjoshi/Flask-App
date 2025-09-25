# Flask Hello World App with Login

A simple Flask web application that demonstrates user authentication with a "Hello World" page.

## Features

- User authentication system
- Login/logout functionality
- Session management
- Bootstrap-styled responsive UI
- Flash messaging for user feedback

## Demo Accounts

The application comes with three pre-configured demo accounts:

- **Username:** `admin` | **Password:** `password123`
- **Username:** `user1` | **Password:** `mypassword`
- **Username:** `demo` | **Password:** `demo123`

## Installation and Setup

1. **Install Python** (if not already installed)
   - Download from https://python.org
   - Make sure Python 3.7+ is installed

2. **Install dependencies:**
   ```powershell
   pip install -r requirements.txt
   ```

3. **Run the application:**
   ```powershell
   python app.py
   ```

4. **Open your browser and go to:**
   ```
   http://localhost:5000
   ```

## File Structure

```
Flask_Project/
├── app.py              # Main Flask application
├── requirements.txt    # Python dependencies
├── README.md          # This file
└── templates/         # HTML templates
    ├── base.html      # Base template
    ├── login.html     # Login page
    └── hello.html     # Hello World page
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