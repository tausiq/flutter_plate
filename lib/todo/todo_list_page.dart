import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/todo/todo_addedit_page.dart';
import 'package:flutter_plate/widgets/extra_actions.dart';
import 'package:flutter_plate/widgets/filter_button.dart';
import 'package:flutter_plate/widgets/filtered_todos.dart';
import 'package:flutter_plate/widgets/stats.dart';
import 'package:flutter_plate/widgets/tab_selector.dart';

import 'blocs/blocs.dart';
import 'model/app_tab.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firestore Todos'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppProvider.getRouter(context)
                  .navigateTo(context, TodoAddEditPage.generatePath(false));
            },
            child: Icon(Icons.add),
            tooltip: 'Add Todo',
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
