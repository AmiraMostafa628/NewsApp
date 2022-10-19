import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/screens/searchScreen.dart';
import 'package:newsapp/shared/components/component.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget{

  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
      listener: (context,state){},
      builder:  (context,state){
        var cubit = NewsCubit.get(context);
        return  Scaffold(

          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  onPressed: (){
                    NavigateTo(context,SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: (){
                    cubit.changeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),

          body: cubit.Screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },

            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Science'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports),
                  label: 'Sports'
              ),


            ],
          ),
        );
      },
    );
  }
}
