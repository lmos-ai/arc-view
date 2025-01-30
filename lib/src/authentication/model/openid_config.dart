import '../../config_loader.dart';

class OpenIdCredentialConfig {
  final String issuerBaseUrl;
  final String clientId;
  final String clientSecret;
  final String redirectURL;
  final String callBackPath;
  final List<String> scopes;

  OpenIdCredentialConfig({
    required this.issuerBaseUrl,
    required this.clientId,
    required this.clientSecret,
    required this.redirectURL,
    required this.callBackPath,
    required this.scopes,
  });
}


class OpenIdCredentialConfigFactory {
  static OpenIdCredentialConfig fromAppConfig() {
    return OpenIdCredentialConfig(
      issuerBaseUrl:
          Config.get("openid.credential.issuerBaseUrl", defaultValue: ""),
      clientId: Config.get("openid.credential.client_id", defaultValue: ""),
      clientSecret:
          Config.get("openid.credential.client_secret", defaultValue: ""),
      redirectURL: Config.get("openid.credential.redirect_base_url",
          defaultValue: "http://localhost:9876"),
      callBackPath: Config.get("openid.credential.call_back_path",
          defaultValue: "/callback"),
      scopes: List<String>.from(Config.get("openid.credential.scopes", defaultValue: [])),
    );
  }
}
