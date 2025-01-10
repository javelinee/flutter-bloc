import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one/bloc/children_bloc.dart';
import 'package:flutter_one/bloc/children_event.dart';
import 'package:flutter_one/bloc/children_state.dart';
import 'package:flutter_one/services/services.dart';

import 'models/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
        onGenerateRoute: (settings) {
          if (settings.name == MyHomePage.routesName) {
            final args = settings.arguments as Map<String, dynamic>;
            final children = args['children'] as List<Children>?;
            final title = args['title'] as String?;

            return MaterialPageRoute(
              builder: (context) {
                return MyHomePage(children: children, title: title);
              },
            );
          }
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.children, this.title});

  static const routesName = "/homepage";

  final List<Children>? children;
  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ChildrenBloc childrenBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    childrenBloc = ChildrenBloc(Services());

    if (widget.children == null) {
      childrenBloc.add(FetchDataEvent());
    } else {
      childrenBloc.add(LoadDataEvent(widget.children));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => childrenBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(widget.title ?? "Home"),
        ),
        body: BlocBuilder<ChildrenBloc, ChildrenState>(
          builder: (context, state) {
            if (state is ChildrenLoadedState) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    if ((state.children?[index].children?.length ?? 0) > 0) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyHomePage.routesName,
                                arguments: {
                                  'children': state.children?[index].children,
                                  'title': state.children?[index].name
                                });
                          },
                          child: Text('${state.children?[index].name ?? ''}'));
                    } else {
                      return Text(
                        '${state.children?[index].name ?? ''}',
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                  itemCount: state.children?.length ?? 0);
            } else {
              return Center(
                child: Text("No data"),
              );
            }
          },
        ),
      ),
    );
  }
}
