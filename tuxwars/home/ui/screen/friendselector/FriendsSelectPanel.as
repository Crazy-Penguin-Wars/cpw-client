package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import tuxwars.utils.*;
   
   public class FriendsSelectPanel extends CellPanel
   {
      public static const CLICK_EVENT:String = "ClickEvent";
      
      private var button:UIButton;
      
      private var _firstName:String = "";
      
      private var _lastName:String = "";
      
      public function FriendsSelectPanel(param1:MovieClip, param2:String)
      {
         super();
         if(Boolean(param1) && param2 != null)
         {
            this.button = TuxUiUtils.createButton(UIButton,param1,param2,this.buttonClickHandler);
            this.button.setVisible(false);
         }
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1)
         {
            this._firstName = param1.firstName != null ? param1.firstName : "";
            this._lastName = param1.lastName != null ? param1.lastName : "";
            id = param1.id;
            this.button.setVisible(true);
         }
         else
         {
            this._firstName = "";
            this._lastName = "";
            id = "";
            this.button.setVisible(false);
         }
         this.text = this._firstName + " " + this._lastName;
      }
      
      public function get firstname() : String
      {
         return this._firstName;
      }
      
      public function get lastname() : String
      {
         return this._lastName;
      }
      
      public function set text(param1:String) : void
      {
         this.button.setText(param1);
      }
      
      private function buttonClickHandler(param1:Event) : void
      {
         dispatchEvent(new Event("ClickEvent"));
      }
   }
}

