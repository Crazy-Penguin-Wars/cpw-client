package tuxwars.data
{
   import tuxwars.battle.avatar.TuxAvatar;
   
   public class RematchDataPlayer
   {
       
      
      private var _id:String;
      
      private var _name:String;
      
      private var _avatar:TuxAvatar;
      
      public function RematchDataPlayer(id:String, name:String, avatar:TuxAvatar)
      {
         super();
         _id = id;
         _name = name;
         _avatar = avatar;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function set id(value:String) : void
      {
         _id = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get avatar() : TuxAvatar
      {
         return _avatar;
      }
      
      public function set avatar(value:TuxAvatar) : void
      {
         _avatar = value;
      }
   }
}
