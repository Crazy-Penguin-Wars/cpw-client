package tuxwars.ui.tooltips
{
   import tuxwars.data.assets.*;
   import tuxwars.utils.*;
   
   public class ItemTooltip extends TuxTooltip
   {
      private var title:String;
      
      private var desc:String;
      
      public function ItemTooltip(param1:String, param2:String)
      {
         this.title = param1;
         this.desc = param2;
         super(TooltipsData.getItemTooltipGraphics());
      }
      
      override protected function createContents() : void
      {
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Name,this.title);
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Decription,this.desc);
      }
   }
}

