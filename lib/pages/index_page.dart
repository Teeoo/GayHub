import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:gayhub/models/user.dart';
import 'package:gayhub/router/application.dart';
import 'package:gayhub/store/model/auth_model.dart';
import 'package:gayhub/store/store.dart';
import 'package:gayhub/utils/localStorage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, AuthModel auth, child) {
      return Container(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('GayHub'),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[Colors.red, Colors.blue])),
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Query(
                        options: QueryOptions(documentNode: gql(r'''
                          query {
                            viewer {
                                  name
                                  email
                                  avatarUrl
                                  createdAt
                            }
                        }
                  ''')),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          if (!result.loading) {
                            User user = User.fromJson(result.data);
                            return UserAccountsDrawerHeader(
                              accountName: Text(user.viewer.name),
                              accountEmail: Text(user.viewer.email),
                              currentAccountPicture: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.viewer.avatarUrl),
                              ),
                            );
                          } else {
                            return CardSkeleton(
                              style: SkeletonStyle(
                                theme: SkeletonTheme.Light,
                                isShowAvatar: true,
                                isCircleAvatar: false,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                padding: EdgeInsets.all(32.0),
                                barCount: 2,
                                isAnimation: false,
                              ),
                            );
                          }
                        }),
                    ListTile(
                        // dense: true,
                        title: Text('主页'),
                        leading: Icon(Icons.account_circle),
                        onTap: () {
                          Application.router.navigateTo(context, "home",
                              transition: TransitionType.material);
                        }),
                    ListTile(
                        // dense: true,
                        title: Text('通知'),
                        leading: Icon(Icons.notifications),
                        onTap: () {
                          Application.router.navigateTo(context, "home",
                              transition: TransitionType.material);
                        }),
                    ListTile(
                        // dense: true,
                        title: Text('动态'),
                        leading: Icon(Icons.calendar_view_day),
                        onTap: () {
                          Application.router.navigateTo(context, "home",
                              transition: TransitionType.material);
                        }),
                    ListTile(
                        // dense: true,
                        title: Text('测试注销'),
                        leading: Icon(Icons.restore),
                        onTap: () async {
                          print(await LocalStorage.get('token'));
                          auth.restore();
                        }),
                  ],
                ),
              ),
              body: Query(
                  options: QueryOptions(documentNode: gql(r'''
                  query {
                    viewer {
                      repositories(first: 50, isFork: false) {
                        edges {
                          node {
                            id
                            name
                            url
                            descriptionHTML
                            forkCount
                            stargazers {
                              totalCount
                            }
                          }
                        }
                      }
                    }
                  }
                  ''')),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    return Text(json.encode(result.data));
                  })));
    });
  }
}
