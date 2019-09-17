import sentry_sdk
from sentry_sdk.integrations.django import DjangoIntegration

from .settings import *  # lgtm [py/polluting-import]

if os.getenv("TRAVIS"):
    MANUAL_PRODUCTION = True  # pro funkcni testy na Travisu
    STATICFILES_DIRS = [
        os.path.join(BASE_DIR, "frontend", "dist")
    ]  # jen na Travisu (zde se pak slozka smaze)

ALLOWED_HOSTS = [
    "uspesnyprvnacek.herokuapp.com",
    "uspesnyprvnacek-staging.herokuapp.com",
    "uspesnyprvnacek-testing.herokuapp.com",
]

sentry_sdk.init(environment=ENVIRONMENT, integrations=[DjangoIntegration()])

# Django konstanty pro bezpecnost
SECURE_BROWSER_XSS_FILTER = True
SESSION_COOKIE_SECURE = True
SECURE_CONTENT_TYPE_NOSNIFF = True
CSRF_COOKIE_SECURE = True
X_FRAME_OPTIONS = "DENY"

SECURE_SSL_REDIRECT = True
SECURE_HSTS_SECONDS = 63072000  # 2 roky
SECURE_HSTS_PRELOAD = True
SECURE_HSTS_INCLUDE_SUBDOMAINS = True

if MANUAL_PRODUCTION:
    DEBUG = False
    ALLOWED_HOSTS.append("localhost")
    SECURE_SSL_REDIRECT = False
    os.environ["SENTRY_DSN"] = SENTRY_DSN  # pro JS
