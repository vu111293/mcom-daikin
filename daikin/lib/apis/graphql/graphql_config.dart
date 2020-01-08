import 'package:graphql/client.dart';

class GraphqlConfig {
  static String _path = 'https://daikin.mcom.app/graphql';

  static GraphQLClient client() {
    final HttpLink _httpLink = HttpLink(
      uri: _path,
    );

    final AuthLink _authLink = AuthLink(
      getToken: () => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjp7InVzZXJJZCI6IjVlMTU1OGYwNWY3NzMwMDAxODM0NzAwNSIsInBob25lIjoiKzg0Mzc4NzYwODYwIn0sImV4cCI6IjIwMjAtMDEtMDlUMDQ6MzU6MjkuNTk3WiJ9.8gYlAC7eynV531Zzwya3qtFVuI-tEuUU0W1AepYSEFE',
    );

    final Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
      link: _link,
    );
  }
}
