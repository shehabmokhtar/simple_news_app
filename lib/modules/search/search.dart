import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/Cubit/Cubit.dart';
import '../../layout/Cubit/States.dart';
import '../../shared/componants/componants.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CostumTextFormFeild(
                  label: 'Search',
                  controller: searchController,
                  type: TextInputType.text,
                  prefix: Icons.search,
                  onChange: (value) {
                    if (value != '') {
                      NewsCubit.get(context).getSearch(value);
                    }
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Search must not be empty !';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: ArticleBuilder(NewsCubit.get(context).search, context),
              )
            ],
          ),
        );
      },
    );
  }
}