package tuxwars.items
{
   import com.dchoc.avatar.*;
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.gameobjects.stats.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.managers.*;
   import tuxwars.items.references.StatBonusReference;
   
   public class Equippable implements Wearable
   {
      public static const EQUIPPABLE_BONUS_STATS:Array = ["Attack","Defence","Luck","ImpulseResistance","Damage","JumpPower","WalkSpeed","MaxSpeed","ExpBonus","CoinsBonus","DamageRadius","ShotSpread","Density","GravityScale","Restitution","Friction"];
      
      public static const BOOSTER_BONUS_STATS:Array = ["Attack","Damage","DamageRadius","ShotSpread"];
      
      private var _type:String;
      
      private var _id:String;
      
      private var _description:String;
      
      private var _name:String;
      
      private var _statBonuses:Stats;
      
      private var _slot:String;
      
      private var _graphics:GraphicsReference;
      
      private var _followers:Vector.<FollowerData>;
      
      public function Equippable()
      {
         super();
      }
      
      public function load(param1:EquippableDef) : void
      {
         var _loc3_:* = undefined;
         assert("data is null",true,param1 != null);
         this._name = param1.name;
         this._type = param1.type;
         this._id = param1.id;
         this._description = param1.description;
         this._graphics = param1.graphics;
         this._followers = param1.followers;
         if(this._type == "Weapon")
         {
            this._slot = "Weapon";
         }
         else if(this._type == "Booster")
         {
            this._slot = "Booster";
         }
         else
         {
            this._slot = param1.slot;
         }
         var _loc2_:StatBonusReference = param1.statBonuses;
         if(_loc2_ != null)
         {
            this._statBonuses = new Stats();
            for each(_loc3_ in EQUIPPABLE_BONUS_STATS)
            {
               if(_loc2_.getStat(_loc3_))
               {
                  this._statBonuses.setStat(_loc3_,_loc2_.getStat(_loc3_));
               }
            }
         }
      }
      
      public function get graphics() : GraphicsReference
      {
         return this._graphics;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         return this._followers;
      }
      
      public function dispose() : void
      {
         if(this._statBonuses != null)
         {
            this._statBonuses.dispose();
         }
         this._statBonuses = null;
         this._graphics = null;
         if(this._followers)
         {
            this._followers.splice(0,this._followers.length);
         }
         this._followers = null;
      }
      
      public function hasStats() : Boolean
      {
         return this._statBonuses != null ? Boolean(this._statBonuses.hasStats(EQUIPPABLE_BONUS_STATS)) : false;
      }
      
      public function get statBonuses() : Stats
      {
         return this._statBonuses;
      }
      
      public function getStatBonus(param1:String) : Stat
      {
         return this._statBonuses != null ? this._statBonuses.getStat(param1) : null;
      }
      
      public function getAsWearableItem() : WearableItem
      {
         return new WearableItem({
            "swf":this.graphics.swf,
            "export":this.graphics.export,
            "wearableSlot":Slots.getWearableSlot(this._slot),
            "name":this._id,
            "id":this._id
         });
      }
      
      public function getAnimationClipName() : String
      {
         switch(this._slot)
         {
            case "Head":
               return "head_gear";
            case "Torso":
               return "body_gear";
            case "Feet":
               return "left_foot_gear";
            case "Weapon":
               return "tool";
            case "Booster":
               return "booster";
            case "Face":
               return "facial_expression";
            case "AccessoryOverHat":
               return "accessory_top";
            case "AccessoryUnderHat":
               return "accessory_under";
            default:
               return null;
         }
      }
   }
}

