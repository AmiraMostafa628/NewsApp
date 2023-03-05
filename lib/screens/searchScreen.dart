import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/component.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/styles/color.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  validator:(value){
                    if (value!.isEmpty){
                      return'Search must not be empty';

                    }},
                  keyboardType: TextInputType.text ,
                  onFieldSubmitted:(text)
                  {
                    NewsCubit.get(context).SearchData(text);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (state is AppLoadingSearchData)
                  LinearProgressIndicator(),
                Expanded(
                  child: ArticleBuilder(
                      NewsCubit.get(context).search,
                      context,
                      isSearch:true
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
