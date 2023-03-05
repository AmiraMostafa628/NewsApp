import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/screens/web_view/web_view.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'constant.dart';




Widget BuildArticleItem(article,context,index,isSearch){

  return Container(
   color: !isSearch &&NewsCubit.get(context).businessItem==index&&NewsCubit.get(context).isDesktop?
   NewsCubit.get(context).isDark?
      HexColor('272a2c').withOpacity(.9):Colors.grey[300]
    :null,
    child: InkWell(
      onTap: (){
        if (!isSearch)
        {
          if (NewsCubit.get(context).isDesktop)
            NewsCubit.get(context).businessItemSelect(index);
          else if (defaultTargetPlatform == TargetPlatform.android)
            NavigateTo(context, WebViewScreen(article['url']));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover
                  )
              ),


            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text( '${article['title']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: NewsCubit.get(context).isDark?Colors.white:Colors.black,
                        ),


                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${article['publishedAt']}',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),

          ],
        ),
      ),
    ),
  );
}

Widget ArticleBuilder(list,context,{bool isSearch = false}){
  return ConditionalBuilder(
    condition: list.length>0,
    builder:(context)=>ListView.separated(
        itemBuilder: (context,index)=>BuildArticleItem(list[index],context,index,isSearch),
        separatorBuilder: (context,index)=>myDivider(),
        itemCount:list.length ),
    fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator()),

  );
}

Widget myDivider() =>Padding(
  padding: const EdgeInsetsDirectional.only(start: 10.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void NavigateTo(context,Widget) {
    Navigator.push(
     context,
     MaterialPageRoute(builder:(context)=> Widget));
}