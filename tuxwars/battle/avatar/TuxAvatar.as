package tuxwars.battle.avatar
{
   import com.dchoc.avatar.*;
   import com.dchoc.avatar.paperdoll.*;
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.*;
   import tuxwars.battle.gameobjects.player.AvatarGameObject;
   import tuxwars.items.ClothingItem;
   
   public class TuxAvatar extends UserAvatar
   {
      public static const IDLE:String = "idle";
      
      public static const IDLE_1:String = "idle01";
      
      public static const IDLE_2:String = "idle02";
      
      public static const IDLE_3:String = "idle03";
      
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
      
      public static const IDLE_ANIMS:Array = ["idle01","idle02","idle03"];
      
      private const _clothesList:Array = [];
      
      private var player:AvatarGameObject;
      
      public function TuxAvatar(param1:String, param2:AvatarGameObject = null)
      {
         super(param1);
         this.player = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._clothesList.splice(0,this._clothesList.length);
         this.player = null;
      }
      
      public function get clothesList() : Array
      {
         return this._clothesList;
      }
      
      public function unwearAll() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.clothesList)
         {
            if(_loc1_)
            {
               this.unWearClothing(_loc1_);
            }
         }
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.updateClothing();
      }
      
      override public function animate(param1:AvatarAnimation, param2:Boolean = true, param3:Function = null) : Boolean
      {
         if(this.player)
         {
         }
         return super.animate(param1,param2,param3);
      }
      
      public function wearClothing(param1:ClothingItem) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param1.categories.indexOf("Color") != -1)
         {
            _loc2_ = param1.special.getValue("RedMultiplier");
            _loc3_ = param1.special.getValue("GreenMultiplier");
            _loc4_ = param1.special.getValue("BlueMultiplier");
            color = new AvatarColor(_loc2_,_loc3_,_loc4_);
         }
         else if(param1.graphics)
         {
            addBodyPart(new BodyPart(param1.getAnimationClipName(),param1.graphics.export));
            _loc5_ = this.putOnItem(param1.getAsWearableItem());
            _loc6_ = true;
            if(param1.slot == "Feet")
            {
               addBodyPart(new BodyPart("right_foot_gear",param1.rightFootExport));
               _loc6_ = this.putOnItem(param1.getRightFootAsWearableItem());
            }
         }
         return _loc5_ && _loc6_;
      }
      
      public function unWearClothing(param1:ClothingItem) : void
      {
         if(param1.graphics)
         {
            removeBodyPart(new BodyPart(param1.getAnimationClipName(),param1.graphics.export));
            this.takeOffItem(param1.getAsWearableItem());
            if(param1.slot == "Feet")
            {
               removeBodyPart(new BodyPart("right_foot_gear",param1.rightFootExport));
               this.takeOffItem(param1.getRightFootAsWearableItem());
            }
         }
      }
      
      override public function putOnItem(param1:WearableItem) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc2_:int = param1.wearableSlot;
         if(param1.isDisplayObjectLoaded())
         {
            if(super.putOnItem(param1))
            {
               this._clothesList[_loc2_] = null;
               return true;
            }
         }
         else
         {
            DCResourceManager.instance.addCustomEventListener("complete",this.itemLoadCallback,param1.swf);
            DCResourceManager.instance.load(Config.getDataDir() + param1.swf,param1.swf,null,true);
            this._clothesList[_loc2_] = param1;
         }
         return false;
      }
      
      override public function takeOffItem(param1:WearableItem) : void
      {
         var _loc2_:int = param1.wearableSlot;
         if(this._clothesList[_loc2_] == param1)
         {
            this._clothesList[_loc2_] = null;
         }
         super.takeOffItem(param1);
      }
      
      private function itemLoadCallback(param1:DCLoadingEvent) : void
      {
         DCResourceManager.instance.removeCustomEventListener("complete",this.itemLoadCallback,param1.target as String);
         this.updateClothing();
      }
      
      private function updateClothing() : void
      {
         var _loc1_:int = 0;
         var _loc2_:WearableItem = null;
         _loc1_ = this._clothesList.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._clothesList[_loc1_];
            if(Boolean(_loc2_) && Boolean(_loc2_.displayObject))
            {
               if(super.putOnItem(_loc2_))
               {
                  this._clothesList.splice(_loc1_,1);
               }
            }
            _loc1_--;
         }
      }
      
      private function getPlayerId() : String
      {
         var _loc1_:AvatarGameObject = null;
         return this.player != null ? (_loc1_ = this.player, "(" + _loc1_._id + ") ") : "";
      }
   }
}

