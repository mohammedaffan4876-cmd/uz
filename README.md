# Oud Mistique - Luxury Perfume Ecommerce

## Frontend (React + Vite)

```bash
npm install
npm run dev
```

## Backend (Django REST API)

Ensure the Django backend is running at `http://localhost:8000` with the following API endpoints:

- `/api/auth/login/` - JWT login
- `/api/auth/register/` - User registration
- `/api/auth/refresh/` - Token refresh
- `/api/products/` - Product listing
- `/api/cart/` - Cart operations
- `/api/orders/` - Order management
- `/api/wishlist/` - Wishlist operations

## Features

- JWT Authentication
- Product listing with filters (category, price range, search)
- Shopping cart with quantity updates
- Wishlist functionality
- Checkout with COD and UPI payment
- QR code payment for UPI
- Admin dashboard
- Toast notifications
- Responsive luxury UI with gold/cream theme

## UPI Payment

UPI ID: `7204771584@naviaxis`

## Deploying the Django site on Render

- Build command: `./build.sh`
- Start command: `gunicorn config.wsgi:application`
- Environment variables: `DATABASE_URL`, `SECRET_KEY`, `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET`
  (Render sets `RENDER` and `RENDER_EXTERNAL_HOSTNAME` itself). Do not commit these keys to the repository.
- After the first deploy create an admin login in the Render Shell: `python manage.py createsuperuser`

## Editing content (Django admin `/admin/`)

Products > Perfumes / Attars (taglines, scent family, inspired-by), Homepage slides, Site settings (taglines,
announcement bar, service strip, brand story), Categories (navbar menu), Newsletter subscribers.

## Order OTP and tracking

- **OTP:** when a customer places an order they are emailed a 6-digit code (valid 10 minutes, 5 attempts) which the server checks.
  Set `EMAIL_HOST`, `EMAIL_HOST_USER`, `EMAIL_HOST_PASSWORD` (Gmail: use an App Password, `EMAIL_HOST=smtp.gmail.com`) so the email is really sent.
  Without `EMAIL_HOST`, codes are printed in the server terminal and OTP is only enforced when running locally (DEBUG).
  Force it on/off with `ORDER_OTP_REQUIRED=true|false`.
- **Tracking:** in Admin > Orders open an order, change **Status**, add courier / tracking number / link / estimated delivery and an optional
  message. Customers see it in My Orders and on `/track-order` (order number + phone) and get an email. You can also select several orders
  and use the "Mark selected orders as..." action.

## Combos

Admin > Products > **Combos** is a separate page for four-perfume sets: name, description, regular and sale price (leave the regular price empty
to add up the chosen perfumes automatically), bottle size, gift box / message card, shipping weight, main photo, tags, and the four perfumes with
their top / middle / base notes. The website gets `/combos` (all combos) and `/combos/<name>` (one combo), and combos work with the normal cart,
OTP checkout and order tracking. Untick **Active** to hide a combo.

## Mobile notifications (new order text messages)

Set these environment variables (locally or in Render):

- `ADMIN_NOTIFY_PHONE` - your mobile number; you get a text for every new order.
- `SMS_PROVIDER` - `twilio` or `fast2sms`, plus its keys (`TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_FROM` / `FAST2SMS_API_KEY`).
  Twilio can also send WhatsApp (`TWILIO_FROM=whatsapp:+14155238886`).
- `SITE_URL` - your website address, so messages contain the tracking link.
- Customers also get a text when the order is placed and whenever you change its status (`CUSTOMER_SMS_ENABLED`, on by default once a provider is set).

Without a provider the messages are only printed in the server log. SMS to Indian numbers usually needs a paid, registered (DLT) sender;
WhatsApp via Twilio avoids that.
