package tuxwars.battle.ui.logic
{
   import tuxwars.battle.avatar.TuxAvatar;
   
   public class BattleHudPlayerData
   {
      
      public static const ACTIVE:String = "Active";
      
      public static const IDLE:String = "Idle";
      
      public static const DISABLED:String = "Disabled";
      
      public static const EMPTY:String = "Empty";
       
      
      private var _name:String;
      
      private var _status:String;
      
      private var _score:int;
      
      private var _place:int;
      
      private var _avatar:TuxAvatar;
      
      private var _avatarTimer:TuxAvatar;
      
      private var _hitPoints:int;
      
      private var _tabIndex:int;
      
      public function BattleHudPlayerData()
      {
         super();
         _status = "Empty";
         _name = "";
         _place = 4;
      }
      
      public function get hitPoints() : int
      {
         return _hitPoints;
      }
      
      public function set hitPoints(value:int) : void
      {
         _hitPoints = value;
      }
      
      public function get avatar() : TuxAvatar
      {
         return _avatar;
      }
      
      public function set avatar(avatar:TuxAvatar) : void
      {
         _avatar = avatar;
      }
      
      public function get avatarTimer() : TuxAvatar
      {
         return _avatarTimer;
      }
      
      public function set avatarTimer(avatarTimer:TuxAvatar) : void
      {
         _avatarTimer = avatarTimer;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(value:int) : void
      {
         _score = value;
      }
      
      public function get status() : String
      {
         return _status;
      }
      
      public function set status(value:String) : void
      {
         _status = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function set tabIndex(index:int) : void
      {
         _tabIndex = index;
      }
      
      public function get tabIndex() : int
      {
         return _tabIndex;
      }
   }
}
