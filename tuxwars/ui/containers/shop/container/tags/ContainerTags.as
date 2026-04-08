package tuxwars.ui.containers.shop.container.tags
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class ContainerTags extends Container
   {
      public static const TAG_NEW:String = "tag_new";
      
      public static const TAG_SALE:String = "tag_sale";
      
      public static const TAG_VIP:String = "tag_vip";
      
      private var _tagContainers:UIContainers;
      
      public function ContainerTags(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         var _loc5_:MovieClip = null;
         var _loc6_:BigShopItem = null;
         super(param1,param2,param3,param4);
         if(Boolean(param1.Tag) || Boolean(param1.Content) && Boolean(param1.Content.Tag))
         {
            _loc5_ = !!param1.Tag ? param1.Tag : param1.Content.Tag;
            this._tagContainers = new UIContainers();
            _loc5_.mouseEnabled = false;
            _loc5_.mouseChildren = false;
            this._tagContainers.add("tag_new",new ShopTag(_loc5_.Tag_New,param2,param3,"TID_NEW",param4));
            _loc6_ = this.singleData as BigShopItem;
            if(_loc6_)
            {
               if(_loc6_.salePercentage != -1)
               {
                  this._tagContainers.add("tag_sale",new ShopTag(_loc5_.Tag_Sale,param2,param3,"-" + _loc6_.salePercentage + "%",param4,true));
               }
               else
               {
                  this._tagContainers.add("tag_sale",new ShopTag(_loc5_.Tag_Sale,param2,param3,"TID_SALE",param4,true));
               }
            }
            else if(this.singleData is ShopItem)
            {
               if(Boolean((this.singleData as ShopItem).priceObject) && (this.singleData as ShopItem).priceObject.salePercentage != -1)
               {
                  this._tagContainers.add("tag_sale",new ShopTag(_loc5_.Tag_Sale,param2,param3,"-" + (this.singleData as ShopItem).priceObject.salePercentage + "%",param4,true));
               }
               else
               {
                  this._tagContainers.add("tag_sale",new ShopTag(_loc5_.Tag_Sale,param2,param3,"TID_SALE",param4,true));
               }
            }
            this._tagContainers.add("tag_vip",new ShopTag(_loc5_.Tag_Vip,param2,param3,"CATEGORY_VIP",param4));
            this._tagContainers.setAllVisible(false);
         }
         var _loc7_:* = this.singleData;
         if(_loc7_ is ShopItem)
         {
            this.showTag = (_loc7_ as ShopItem).tag;
         }
      }
      
      override public function dispose() : void
      {
         if(this._tagContainers)
         {
            this._tagContainers.dispose();
            this._tagContainers = null;
         }
         super.dispose();
      }
      
      private function set showTag(param1:String) : void
      {
         if(Boolean(this._tagContainers) && Boolean(param1))
         {
            this._tagContainers.show(param1,false);
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

