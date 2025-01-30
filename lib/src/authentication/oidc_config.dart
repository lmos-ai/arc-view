// OIDC Configuration[Replace with actual one]
const bool oidcEnabled = true;
const String oidcName = "keycloak";

/// The base issuer URL for your realm/provider.
const String issuerBase = '';

/// The client ID for your OIDC app.
const String clientId = '';

/// The client secret if using a confidential client.
const String clientSecret = '';

/// The local server URL base (for desktop/macOS).
const String redirectBaseUrl = 'http://localhost:9876';

/// The callback path used for the desktop flow.
const String callbackPath = '/callback';

/// The default set of scopes.
const List<String> scopes = ['openid', 'profile', 'email'];

////////////////////////////////////////////////////////////////////////////////
/// Mobile Flow (flutter_appauth) specific:
////////////////////////////////////////////////////////////////////////////////

/// The redirect URI for Android/iOS.
/// Typically a custom scheme like `com.example.arcview://callback`
const String kRedirectUri = 'com.example.arc-view://callback';
