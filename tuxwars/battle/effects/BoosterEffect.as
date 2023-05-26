package tuxwars.battle.effects
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
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
      
      public function BoosterEffect(type:int, boosterItem:BoosterItem)
      {
         super();
         effectType = type;
         switch(effectType)
         {
            case 0:
               createStartEffect(boosterItem);
               break;
            case 1:
               createNormalEffect(boosterItem);
         }
      }
      
      private function createStartEffect(boosterItem:BoosterItem) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/fx/boosters.swf","booster_start");
         (component.getChildByName("booster_icon_01") as MovieClip).addChild(boosterItem.icon);
         (component.getChildByName("booster_icon_02") as MovieClip).addChild(boosterItem.icon);
         (component.getChildByName("booster_icon_03") as MovieClip).addChild(boosterItem.icon);
         var _loc2_:int = DCUtils.indexOfLabel(component,"out");
         component.addFrameScript(_loc2_,dispose);
         component.mouseChildren = false;
         component.mouseEnabled = false;
      }
      
      private function createNormalEffect(boosterItem:BoosterItem) : void
      {
         var boosterIcon:MovieClip = boosterItem.icon;
         component = DCResourceManager.instance.getFromSWF("flash/fx/boosters.swf","shimmer");
         boosterIcon.filters = [boosterItem.glowFilter];
         (component.getChildByName("booster_icon") as MovieClip).addChild(boosterIcon);
         component.mouseChildren = false;
         component.mouseEnabled = false;
      }
      
      public function get movieClip() : MovieClip
      {
         return component;
      }
      
      public function dispose() : void
      {
         if(component && component.parent)
         {
            component.parent.removeChild(component);
         }
         component = null;
      }
   }
}
