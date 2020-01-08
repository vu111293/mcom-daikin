import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:daikin/apis/graphql/mutations/mutations.dart' as mutations;
import 'package:daikin/apis/graphql/queries/queries.dart' as queries;
import './graphql_config.dart';

class GraphqlAPI {
  final GraphQLClient client;
  GraphqlAPI({@required this.client}) : assert(client != null);

  // Future<QueryResult> getRepositories(int numOfRepositories) async {
  //   final WatchQueryOptions _options = WatchQueryOptions(
  //     document: queries.readRepositories,
  //     variables: <String, dynamic>{
  //       'nRepositories': numOfRepositories,
  //     },
  //     pollInterval: 4,
  //     fetchResults: true,
  //   );

  //   return await client.query(_options);
  // }

  Future<QueryResult> login(String token) async {
    var document = mutations.login;

    final MutationOptions _options = MutationOptions(
      document: document,
      variables: <String, String>{
        "token": token,
      },
    );

    return await client.mutate(_options);
  }
}

final graphqlAPI = new GraphqlAPI(client: GraphqlConfig.client());