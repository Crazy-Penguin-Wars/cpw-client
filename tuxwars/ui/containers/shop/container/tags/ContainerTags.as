package tuxwars.ui.containers.shop.container.tags
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.BigShopItem;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class ContainerTags extends Container
   {
      
      public static const TAG_NEW:String = "tag_new";
      
      public static const TAG_SALE:String = "tag_sale";
      
      public static const TAG_VIP:String = "tag_vip";
       
      
      private var _tagContainers:UIContainers;
      
      public function ContainerTags(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         var tagDesign:* = null;
         var _loc5_:* = null;
         super(design,data,game,parent);
         if(design.Tag || design.Content && design.Content.Tag)
         {
            tagDesign = !!design.Tag ? design.Tag : design.Content.Tag;
            _tagContainers = new UIContainers();
            tagDesign.mouseEnabled = false;
            tagDesign.mouseChildren = false;
            _tagContainers.add("tag_new",new ShopTag(tagDesign.Tag_New,data,game,"TID_NEW",parent));
            _loc5_ = singleData as BigShopItem;
            if(_loc5_)
            {
               if(_loc5_.salePercentage != -1)
               {
                  _tagContainers.add("tag_sale",new ShopTag(tagDesign.Tag_Sale,data,game,"-" + _loc5_.salePercentage + "%",parent,true));
               }
               else
               {
                  _tagContainers.add("tag_sale",new ShopTag(tagDesign.Tag_Sale,data,game,"TID_SALE",parent,true));
               }
            }
            else if(singleData is ShopItem)
            {
               if((singleData as ShopItem).priceObject && (singleData as ShopItem).priceObject.salePercentage != -1)
               {
                  _tagContainers.add("tag_sale",new ShopTag(tagDesign.Tag_Sale,data,game,"-" + (singleData as ShopItem).priceObject.salePercentage + "%",parent,true));
               }
               else
               {
                  _tagContainers.add("tag_sale",new ShopTag(tagDesign.Tag_Sale,data,game,"TID_SALE",parent,true));
               }
            }
            _tagContainers.add("tag_vip",new ShopTag(tagDesign.Tag_Vip,data,game,"CATEGORY_VIP",parent));
            _tagContainers.setAllVisible(false);
         }
         var _loc6_:* = singleData;
         if(_loc6_ is ShopItem)
         {
            showTag = (_loc6_ as ShopItem).tag;
         }
      }
      
      override public function dispose() : void
      {
         if(_tagContainers)
         {
            _tagContainers.dispose();
            _tagContainers = null;
         }
         super.dispose();
      }
      
      private function set showTag(tag:String) : void
      {
         if(_tagContainers && tag)
         {
            _tagContainers.show(tag,false);
         }
      }
      
      protected function get singleData() : *
      {
         if(data is Array && (data as Array).length == 1)
         {
            return data[0];
         }
         return null;
      }
   }
}
