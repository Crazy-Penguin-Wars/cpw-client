package tuxwars.battle.effects
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.items.BoosterItem;
   
   public class BoosterEffect extends Sprite
   {
      public static const TYPE_START_EFFECT:int = 0;
      
      public static const TYPE_NORMAL_EFFECT:int = 1;
      
      private static const BOOSTER_START:String = "booster_start";
      
      private static const BOOSTER_ICON:String = "booster_icon";
      
      private static const BOOSTER_ICON_01:String = "booster_icon_01";
      
      private static const BOOSTER_ICON_02:String = "booster_icon_02";
      
      private static const BOOSTER_ICON_03:String = "booster_icon_03";
      
      private static const SHIMMER:String = "shimmer";
      
      private var effectType:int;
      
      private var component:MovieClip;
      
      private var finished:Boolean;
      
      public function BoosterEffect(param1:int, param2:BoosterItem)
      {
         super();
         this.effectType = param1;
         switch(this.effectType)
         {
            case 0:
               this.createStartEffect(param2);
               break;
            case 1:
               this.createNormalEffect(param2);
         }
      }
      
      private function createStartEffect(param1:BoosterItem) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/fx/boosters.swf","booster_start");
         (this.component.getChildByName("booster_icon_01") as MovieClip).addChild(param1.icon);
         (this.component.getChildByName("booster_icon_02") as MovieClip).addChild(param1.icon);
         (this.component.getChildByName("booster_icon_03") as MovieClip).addChild(param1.icon);
         var _loc2_:int = int(DCUtils.indexOfLabel(this.component,"out"));
         this.component.addFrameScript(_loc2_,this.dispose);
         this.component.mouseChildren = false;
         this.component.mouseEnabled = false;
      }
      
      private function createNormalEffect(param1:BoosterItem) : void
      {
         var _loc2_:MovieClip = param1.icon;
         this.component = DCResourceManager.instance.getFromSWF("flash/fx/boosters.swf","shimmer");
         _loc2_.filters = [param1.glowFilter];
         (this.component.getChildByName("booster_icon") as MovieClip).addChild(_loc2_);
         this.component.mouseChildren = false;
         this.component.mouseEnabled = false;
      }
      
      public function get movieClip() : MovieClip
      {
         return this.component;
      }
      
      public function dispose() : void
      {
         if(Boolean(this.component) && Boolean(this.component.parent))
         {
            this.component.parent.removeChild(this.component);
         }
         this.component = null;
      }
   }
}

