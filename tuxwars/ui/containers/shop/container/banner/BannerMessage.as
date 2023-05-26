package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.TuxUiUtils;
   
   public class BannerMessage extends Banner
   {
       
      
      private var _optionalTextFieldContainer:MovieClip;
      
      private var _optionalTextField:UIAutoTextField;
      
      public function BannerMessage(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         if(bigShopItem)
         {
            _optionalTextFieldContainer = design.Message;
            if(_optionalTextFieldContainer)
            {
               if(bigShopItem.text)
               {
                  _optionalTextField = TuxUiUtils.createAutoTextField(_optionalTextFieldContainer.Text,bigShopItem.text);
               }
               else
               {
                  _optionalTextFieldContainer.visible = false;
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         _optionalTextField = null;
         _optionalTextFieldContainer = null;
         super.dispose();
      }
      
      override public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         super.activateTutorial(itemID,arrow,addTutorialArrow);
      }
   }
}
