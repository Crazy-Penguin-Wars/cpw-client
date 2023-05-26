package tuxwars.battle.avatar
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.avatar.AvatarColor;
   import com.dchoc.avatar.UserAvatar;
   import com.dchoc.avatar.WearableItem;
   import com.dchoc.avatar.paperdoll.BodyPart;
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.DCResourceManager;
   import tuxwars.battle.gameobjects.player.AvatarGameObject;
   import tuxwars.items.ClothingItem;
   
   public class TuxAvatar extends UserAvatar
   {
      
      public static const IDLE:String = "idle";
      
      public static const IDLE_1:String = "idle01";
      
      public static const IDLE_2:String = "idle02";
      
      public static const IDLE_3:String = "idle03";
      
      public static const IDLE_ANIMS:Array = ["idle01","idle02","idle03"];
      
      public static const WALK:String = "walk";
      
      public static const DIE:String = "dying";
      
      public static const FIRE:String = "fire";
      
      public static const JUMP:String = "jump";
      
      public static const LAND:String = "landjump";
      
      public static const DAMAGE_FALL:String = "damagefall";
      
      public static const SPAWN:String = "spawn";
      
      public static const STUNNED:String = "stunned";
      
      public static const HIT:String = "damagehit";
      
      public static const FALL:String = "fall";
      
      public static const WIN:String = "win";
      
      public static const LOSE1:String = "lose_01";
       
      
      private const _clothesList:Array = [];
      
      private var player:AvatarGameObject;
      
      public function TuxAvatar(swf:String, player:AvatarGameObject = null)
      {
         super(swf);
         this.player = player;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _clothesList.splice(0,_clothesList.length);
         player = null;
      }
      
      public function get clothesList() : Array
      {
         return _clothesList;
      }
      
      public function unwearAll() : void
      {
         for each(var clothing in clothesList)
         {
            if(clothing)
            {
               unWearClothing(clothing);
            }
         }
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         updateClothing();
      }
      
      override public function animate(anim:AvatarAnimation, showTransition:Boolean = true, callThisFunctionWhenAnimationStarts:Function = null) : Boolean
      {
         if(!player)
         {
         }
         return super.animate(anim,showTransition,callThisFunctionWhenAnimationStarts);
      }
      
      public function wearClothing(clothing:ClothingItem) : Boolean
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var secondCloth:Boolean = false;
         if(clothing.categories.indexOf("Color") != -1)
         {
            _loc6_ = clothing.special.getValue("RedMultiplier");
            _loc3_ = clothing.special.getValue("GreenMultiplier");
            _loc5_ = clothing.special.getValue("BlueMultiplier");
            color = new AvatarColor(_loc6_,_loc3_,_loc5_);
         }
         else if(clothing.graphics)
         {
            addBodyPart(new BodyPart(clothing.getAnimationClipName(),clothing.graphics.export));
            _loc4_ = putOnItem(clothing.getAsWearableItem());
            secondCloth = true;
            if(clothing.slot == "Feet")
            {
               addBodyPart(new BodyPart("right_foot_gear",clothing.rightFootExport));
               secondCloth = putOnItem(clothing.getRightFootAsWearableItem());
            }
         }
         return _loc4_ && secondCloth;
      }
      
      public function unWearClothing(clothing:ClothingItem) : void
      {
         if(clothing.graphics)
         {
            removeBodyPart(new BodyPart(clothing.getAnimationClipName(),clothing.graphics.export));
            takeOffItem(clothing.getAsWearableItem());
            if(clothing.slot == "Feet")
            {
               removeBodyPart(new BodyPart("right_foot_gear",clothing.rightFootExport));
               takeOffItem(clothing.getRightFootAsWearableItem());
            }
         }
      }
      
      override public function putOnItem(item:WearableItem) : Boolean
      {
         if(!item)
         {
            return false;
         }
         var _loc2_:int = item.wearableSlot;
         if(item.isDisplayObjectLoaded())
         {
            if(super.putOnItem(item))
            {
               _clothesList[_loc2_] = null;
               return true;
            }
         }
         else
         {
            DCResourceManager.instance.addCustomEventListener("complete",itemLoadCallback,item.swf);
            DCResourceManager.instance.load(Config.getDataDir() + item.swf,item.swf,null,true);
            _clothesList[_loc2_] = item;
         }
         return false;
      }
      
      override public function takeOffItem(item:WearableItem) : void
      {
         var _loc2_:int = item.wearableSlot;
         if(_clothesList[_loc2_] == item)
         {
            _clothesList[_loc2_] = null;
         }
         super.takeOffItem(item);
      }
      
      private function itemLoadCallback(event:DCLoadingEvent) : void
      {
         DCResourceManager.instance.removeCustomEventListener("complete",itemLoadCallback,event.target as String);
         updateClothing();
      }
      
      private function updateClothing() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = _clothesList.length - 1; i >= 0; )
         {
            _loc1_ = _clothesList[i];
            if(_loc1_ && _loc1_.displayObject)
            {
               if(super.putOnItem(_loc1_))
               {
                  _clothesList.splice(i,1);
               }
            }
            i--;
         }
      }
      
      private function getPlayerId() : String
      {
         var _loc1_:AvatarGameObject;
         return player != null ? (_loc1_ = player, "(" + _loc1_._id + ") ") : "";
      }
   }
}
