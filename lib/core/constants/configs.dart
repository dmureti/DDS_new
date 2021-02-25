class AppEnv {
  final String environmentAlias;
  final String pathToApi;

  AppEnv({this.environmentAlias, this.pathToApi});
}

class Configs {
  static List<AppEnv> appEnvList = [
    AppEnv(
        environmentAlias: "Production",
        pathToApi: "https://mgspv.ttlalpha.com/spv-backend/api/v1"),
    AppEnv(
        environmentAlias: "Dev1",
        pathToApi: "https://mgspv.ttlalpha.com/spvdev-backend/api/v1")
  ];
}
