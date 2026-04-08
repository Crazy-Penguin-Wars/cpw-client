package tuxwars.ui.tooltips
{
   import com.dchoc.data.GraphicsReference;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.ShopItem;
   
   public class ItemBaseTooltip extends TuxTooltip
   {
      private var _item:ShopItem;
      
      private var _content:TooltipContent;
      
      private var _game:TuxWarsGame;
      
      public function ItemBaseTooltip(param1:ShopItem, param2:GraphicsReference, param3:TuxWarsGame)
      {
         this._item = param1;
         super(param2);
      }
      
      public function get content() : TooltipContent
      {
         return this._content;
      }
      
      override public function dispose() : void
      {
         this._item = null;
         this._game = null;
         if(this._content)
         {
            this._content.dispose();
            this._content = null;
         }
         super.dispose();
      }
      
      override protected function createContents() : void
      {
         this._content = new TooltipContent(this._design,this._item,this._game);
      }
      
      override public function checkTooltipLocation() : void
      {
         this._content.checkTooltipLocation();
      }
   }
}

