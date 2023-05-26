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
      
      public function setData(value:Object) : void
      {
      }
      
      public function set id(value:String) : void
      {
         mId = value;
      }
      
      public function get id() : String
      {
         return mId;
      }
   }
}
