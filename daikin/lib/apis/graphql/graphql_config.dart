import 'dart:async';

import 'package:daikin/apis/core/auth_service.dart';
import 'package:graphql/client.dart';
import 'package:graphql/internal.dart';
import 'package:flutter/material.dart';

import 'dart:async';

typedef GetToken = FutureOr<String> Function();

class AuthLink extends Link {
  AuthLink({
    this.getToken,
  }) : super(
          request: (Operation operation, [NextLink forward]) {
            StreamController<FetchResult> controller;

            Future<void> onListen() async {
              try {
                final String token = await getToken();
                print("AUTHLINK");
                print(token);
                
                operation.setContext(<String, Map<String, String>>{
                  'headers': <String, String>{'x-token': token}
                });
              } catch (error) {
                controller.addError(error);
              }

              await controller.addStream(forward(operation));
              await controller.close();
            }

            controller = StreamController<FetchResult>(onListen: onListen);
            return controller.stream;
          },
        );

  GetToken getToken;
}


class GraphQLConfig {
  static String _path = 'https://daikin.mcom.app/graphql';

  static GraphQLClient client() {
    final HttpLink _httpLink = HttpLink(
      uri: _path,
    );

    final AuthLink _authLink = AuthLink(
      getToken: () => LoopBackAuth().accessToken
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
