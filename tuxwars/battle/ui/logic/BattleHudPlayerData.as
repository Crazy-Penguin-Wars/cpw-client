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
         this._status = "Empty";
         this._name = "";
         this._place = 4;
      }
      
      public function get hitPoints() : int
      {
         return this._hitPoints;
      }
      
      public function set hitPoints(param1:int) : void
      {
         this._hitPoints = param1;
      }
      
      public function get avatar() : TuxAvatar
      {
         return this._avatar;
      }
      
      public function set avatar(param1:TuxAvatar) : void
      {
         this._avatar = param1;
      }
      
      public function get avatarTimer() : TuxAvatar
      {
         return this._avatarTimer;
      }
      
      public function set avatarTimer(param1:TuxAvatar) : void
      {
         this._avatarTimer = param1;
      }
      
      public function get place() : int
      {
         return this._place;
      }
      
      public function set place(param1:int) : void
      {
         this._place = param1;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set tabIndex(param1:int) : void
      {
         this._tabIndex = param1;
      }
      
      public function get tabIndex() : int
      {
         return this._tabIndex;
      }
   }
}

