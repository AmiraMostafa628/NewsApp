import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/shared/components/component.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).science;
        return ScreenTypeLayout(
          mobile: Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(false);
                return ArticleBuilder(list, context);
              }
          ),
          desktop: Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(true);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ArticleBuilder(list, context),
                    ),
                    if(list.length>0)
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          color: NewsCubit.get(context).isDark?
                          HexColor('272a2c').withOpacity(.9):Colors.grey[200]!,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('${list[NewsCubit.get(context).businessItem]['description']}',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: NewsCubit.get(context).isDark?Colors.white:Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 700.0,
            tablet: 300.0,
            watch: 100.0,
          ),
        );
      },);
  }
}
