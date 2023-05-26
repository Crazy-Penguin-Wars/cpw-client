package tuxwars.ui.tooltips
{
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.utils.TuxUiUtils;
   
   public class ItemTooltip extends TuxTooltip
   {
       
      
      private var title:String;
      
      private var desc:String;
      
      public function ItemTooltip(title:String, desc:String)
      {
         this.title = title;
         this.desc = desc;
         super(TooltipsData.getItemTooltipGraphics());
      }
      
      override protected function createContents() : void
      {
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Name,title);
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Decription,desc);
      }
   }
}
