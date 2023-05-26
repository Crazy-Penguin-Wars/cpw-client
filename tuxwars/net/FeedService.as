package tuxwars.net
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.data.FeedData;
   import tuxwars.data.FeedDatas;
   import tuxwars.net.objects.FeedObject;
   
   public class FeedService
   {
       
      
      public function FeedService()
      {
         super();
         throw new Error("FeedService is a static class!");
      }
      
      public static function publishMessage(feedName:String, contentParams:Array = null, to:String = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:FeedData = FeedDatas.findFeedData(feedName);
         if(_loc5_)
         {
            _loc4_ = new FeedObject(ProjectManager.getText(_loc5_.title),getLinkURL(),Config.getDataDir() + _loc5_.image,ProjectManager.getText(_loc5_.contentText,contentParams),ProjectManager.getText(_loc5_.description),[{
               "name":ProjectManager.getText(_loc5_.actionText),
               "link":getLinkURL()
            }],to);
            JavaScriptServices.callJavascript(_loc4_);
         }
         else
         {
            LogUtils.log(feedName + " could not be found.");
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
