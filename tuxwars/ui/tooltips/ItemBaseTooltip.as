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
      
      public function ItemBaseTooltip(item:ShopItem, graphics:GraphicsReference, game:TuxWarsGame)
      {
         _item = item;
         super(graphics);
      }
      
      public function get content() : TooltipContent
      {
         return _content;
      }
      
      override public function dispose() : void
      {
         _item = null;
         _game = null;
         if(_content)
         {
            _content.dispose();
            _content = null;
         }
         super.dispose();
      }
      
      override protected function createContents() : void
      {
         _content = new TooltipContent(this._design,_item,_game);
      }
      
      override public function checkTooltipLocation() : void
      {
         _content.checkTooltipLocation();
      }
   }
}
