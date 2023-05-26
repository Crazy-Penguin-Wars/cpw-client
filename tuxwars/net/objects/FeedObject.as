package tuxwars.net.objects
{
   public class FeedObject extends JavaScriptCRMObject
   {
      
      public static const CALL_TYPE:String = "platformPublishFeed";
       
      
      private var _name:String;
      
      private var _link:String;
      
      private var _picture:String;
      
      private var _caption:String;
      
      private var _description:String;
      
      private var _actions:Array;
      
      public function FeedObject(name:String, link:String, picture:String, caption:String, description:String, actions:Array, to:String)
      {
         super("feed",[to],null,null);
         _name = name;
         _link = link;
         _picture = picture;
         _caption = caption;
         _description = description;
         _actions = actions;
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\nname: " + name + ",\nlink :" + link + ",\npicture: " + picture + ",\ncaption: " + caption + ",\ndescription: " + description + ",\nactions: " + actions + ",\nto: " + to;
      }
      
      override public function get callType() : String
      {
         return "platformPublishFeed";
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get link() : String
      {
         return _link;
      }
      
      public function get picture() : String
      {
         return _picture;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get actions() : Array
      {
         return _actions;
      }
   }
}
