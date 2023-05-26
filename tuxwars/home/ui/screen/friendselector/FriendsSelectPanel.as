package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.Event;
   import tuxwars.utils.TuxUiUtils;
   
   public class FriendsSelectPanel extends CellPanel
   {
      
      public static const CLICK_EVENT:String = "ClickEvent";
       
      
      private var button:UIButton;
      
      private var _firstName:String = "";
      
      private var _lastName:String = "";
      
      public function FriendsSelectPanel(parentDesign:MovieClip, buttonName:String)
      {
         super();
         if(parentDesign && buttonName != null)
         {
            button = TuxUiUtils.createButton(UIButton,parentDesign,buttonName,buttonClickHandler);
            button.setVisible(false);
         }
      }
      
      override public function setData(value:Object) : void
      {
         if(value)
         {
            _firstName = value.firstName != null ? value.firstName : "";
            _lastName = value.lastName != null ? value.lastName : "";
            id = value.id;
            button.setVisible(true);
         }
         else
         {
            _firstName = "";
            _lastName = "";
            id = "";
            button.setVisible(false);
         }
         text = _firstName + " " + _lastName;
      }
      
      public function get firstname() : String
      {
         return _firstName;
      }
      
      public function get lastname() : String
      {
         return _lastName;
      }
      
      public function set text(value:String) : void
      {
         button.setText(value);
      }
      
      private function buttonClickHandler(event:Event) : void
      {
         dispatchEvent(new Event("ClickEvent"));
      }
   }
}
