import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:daikin/apis/graphql/mutations/mutations.dart' as mutations;
import 'package:daikin/apis/graphql/queries/queries.dart' as queries;
import './graphql_config.dart';

class GraphQLAPI {
  final GraphQLClient client;
  GraphQLAPI({@required this.client}) : assert(client != null);

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
      documentNode: gql(document),
      variables: <String, String>{
        "token": token,
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> me() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.me),
      variables: <String, dynamic>{},
      // pollInterval: 4,
      // fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> updateUser(String _id, String fullName, String email, String avatar) async {
    var document = mutations.updateUser;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(document),
      variables: <String, dynamic>{
        "id": _id,
        "fullName": fullName,
        "email": email,
        "avatar": avatar
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> registerNotify(String id, String deviceToken) async {
    var document = mutations.registerNotify;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(document),
      variables: <String, dynamic>{
        "id": id,
        "deviceToken": deviceToken
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> unregisterNotify(String id) async {
    var document = mutations.unregisterNotify;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(document),
      variables: <String, dynamic>{
        "id": id
      },
    );
    return await client.mutate(_options);
  }
}

final graphQLAPI = new GraphQLAPI(client: GraphQLConfig.client());
