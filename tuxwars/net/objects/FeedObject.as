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
      
      public function FeedObject(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Array, param7:String)
      {
         super("feed",[param7],null,null);
         this._name = param1;
         this._link = param2;
         this._picture = param3;
         this._caption = param4;
         this._description = param5;
         this._actions = param6;
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\nname: " + this.name + ",\nlink :" + this.link + ",\npicture: " + this.picture + ",\ncaption: " + this.caption + ",\ndescription: " + this.description + ",\nactions: " + this.actions + ",\nto: " + to;
      }
      
      override public function get callType() : String
      {
         return "platformPublishFeed";
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get link() : String
      {
         return this._link;
      }
      
      public function get picture() : String
      {
         return this._picture;
      }
      
      public function get caption() : String
      {
         return this._caption;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get actions() : Array
      {
         return this._actions;
      }
   }
}

