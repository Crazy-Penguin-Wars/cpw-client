package tuxwars.home.ui.screen.friendselector
{
   import flash.events.EventDispatcher;
   
   public class CellPanel extends EventDispatcher
   {
      private var mId:String = "";
      
      public function CellPanel()
      {
         super();
      }
      
      public function setData(param1:Object) : void
      {
      }
      
      public function set id(param1:String) : void
      {
         this.mId = param1;
      }
      
      public function get id() : String
      {
         return this.mId;
      }
   }
}

