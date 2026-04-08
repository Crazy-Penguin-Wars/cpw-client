package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.*;
   
   public class BannerMessage extends Banner
   {
      private var _optionalTextFieldContainer:MovieClip;
      
      private var _optionalTextField:UIAutoTextField;
      
      public function BannerMessage(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         if(bigShopItem)
         {
            this._optionalTextFieldContainer = param1.Message;
            if(this._optionalTextFieldContainer)
            {
               if(bigShopItem.text)
               {
                  this._optionalTextField = TuxUiUtils.createAutoTextField(this._optionalTextFieldContainer.Text,bigShopItem.text);
               }
               else
               {
                  this._optionalTextFieldContainer.visible = false;
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         this._optionalTextField = null;
         this._optionalTextFieldContainer = null;
         super.dispose();
      }
      
      override public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         super.activateTutorial(param1,param2,param3);
      }
   }
}

