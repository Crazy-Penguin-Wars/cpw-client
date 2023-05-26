package tuxwars.items
{
   import com.dchoc.avatar.Wearable;
   import com.dchoc.avatar.WearableItem;
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.managers.Slots;
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
      
      public function load(data:EquippableDef) : void
      {
         assert("data is null",true,data != null);
         _name = data.name;
         _type = data.type;
         _id = data.id;
         _description = data.description;
         _graphics = data.graphics;
         _followers = data.followers;
         if(_type == "Weapon")
         {
            _slot = "Weapon";
         }
         else if(_type == "Booster")
         {
            _slot = "Booster";
         }
         else
         {
            _slot = data.slot;
         }
         var _loc3_:StatBonusReference = data.statBonuses;
         if(_loc3_ != null)
         {
            _statBonuses = new Stats();
            for each(var s in EQUIPPABLE_BONUS_STATS)
            {
               if(_loc3_.getStat(s))
               {
                  _statBonuses.setStat(s,_loc3_.getStat(s));
               }
            }
         }
      }
      
      public function get graphics() : GraphicsReference
      {
         return _graphics;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         return _followers;
      }
      
      public function dispose() : void
      {
         if(_statBonuses != null)
         {
            _statBonuses.dispose();
         }
         _statBonuses = null;
         _graphics = null;
         if(_followers)
         {
            _followers.splice(0,_followers.length);
         }
         _followers = null;
      }
      
      public function hasStats() : Boolean
      {
         return _statBonuses != null ? _statBonuses.hasStats(EQUIPPABLE_BONUS_STATS) : false;
      }
      
      public function get statBonuses() : Stats
      {
         return _statBonuses;
      }
      
      public function getStatBonus(value:String) : Stat
      {
         return _statBonuses != null ? _statBonuses.getStat(value) : null;
      }
      
      public function getAsWearableItem() : WearableItem
      {
         return new WearableItem({
            "swf":graphics.swf,
            "export":graphics.export,
            "wearableSlot":Slots.getWearableSlot(_slot),
            "name":_id,
            "id":_id
         });
      }
      
      public function getAnimationClipName() : String
      {
         switch(_slot)
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
