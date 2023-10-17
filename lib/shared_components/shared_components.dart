
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview_screen.dart';



  Widget buildNewsItem (article,context){
    
    return InkWell(
      onTap: (){navigateTo(context, WebViewScreen('${article['url']}'));},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Container(width: 120,height: 120,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          image:DecorationImage(image: NetworkImage('${article['urlToImage']}'),fit: BoxFit.cover,)),),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Expanded(child: Text("${article['title']}",maxLines:3,overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodyText1,)),
                Text("${article['publishedAt']}",style: TextStyle(color: Colors.grey),),

              ],),
            ),
          ),
        ],),
      ),
    );
    
  }


Widget defaultFormField(
    { @required TextEditingController controller,
      @required TextInputType inputType,
      Function(String) onsubmit,
      Function onTap,
      @required String labeltext,
      @required IconData prefixicon,
      @required Function(String) validator,
      bool obscureText=false,
      IconData suffexicon,
      Function onIconButtonPressed,
      Function(String) onChange,
    }
    ){
  return TextFormField(controller: controller,
    keyboardType: inputType,
    onFieldSubmitted:onsubmit ,
    obscureText: obscureText,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: labeltext, border: OutlineInputBorder(),
      prefixIcon:Icon(prefixicon) ,
      suffixIcon: IconButton(icon: Icon(suffexicon),onPressed:onIconButtonPressed,),),
    validator: validator,
onChanged:onChange ,

  );

}


void navigateTo(context,Widget widget){
  
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return widget;
    }));
}
 

