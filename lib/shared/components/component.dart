import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/web_view/web_view.dart';




Widget BuildArticleItem(article,context){
  return InkWell(
    onTap: (){
      NavigateTo(context, WebViewScreen(article['url']));
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
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,

                    ),
                  ),
                  Text('${article['publishedAt']}',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    ),
  );
}

Widget ArticleBuilder(list,context,{bool isSearch = false}){
  return ConditionalBuilder(
    condition: list.length>0,
    builder:(context)=>ListView.separated(
        itemBuilder: (context,index)=>BuildArticleItem(list[index],context),
        separatorBuilder: (context,index)=>myDivider(),
        itemCount:7 ),
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