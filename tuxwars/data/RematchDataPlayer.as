package tuxwars.data
{
   import tuxwars.battle.avatar.TuxAvatar;
   
   public class RematchDataPlayer
   {
      private var _id:String;
      
      private var _name:String;
      
      private var _avatar:TuxAvatar;
      
      public function RematchDataPlayer(param1:String, param2:String, param3:TuxAvatar)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._avatar = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get avatar() : TuxAvatar
      {
         return this._avatar;
      }
      
      public function set avatar(param1:TuxAvatar) : void
      {
         this._avatar = param1;
      }
   }
}

