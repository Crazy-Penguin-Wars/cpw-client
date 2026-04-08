package tuxwars.net
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.data.*;
   import tuxwars.net.objects.*;
   
   public class FeedService
   {
      public function FeedService()
      {
         super();
         throw new Error("FeedService is a static class!");
      }
      
      public static function publishMessage(param1:String, param2:Array = null, param3:String = null) : void
      {
         var _loc4_:FeedObject = null;
         var _loc5_:FeedData = FeedDatas.findFeedData(param1);
         if(_loc5_)
         {
            _loc4_ = new FeedObject(ProjectManager.getText(_loc5_.title),getLinkURL(),Config.getDataDir() + _loc5_.image,ProjectManager.getText(_loc5_.contentText,param2),ProjectManager.getText(_loc5_.description),[{
               "name":ProjectManager.getText(_loc5_.actionText),
               "link":getLinkURL()
            }],param3);
            JavaScriptServices.callJavascript(_loc4_);
         }
         else
         {
            LogUtils.log(param1 + " could not be found.");
         }
      }
      
      private static function getLinkURL() : String
      {
         if(Config.isDev())
         {
            return "http://apps.facebook.com/tuxwars_dev";
         }
         if(Config.isStage())
         {
            return "http://apps.facebook.com/tuxwars_stage";
         }
         return "http://apps.facebook.com/crazypenguinwars";
      }
   }
}

