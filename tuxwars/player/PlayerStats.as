package tuxwars.player
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   
   public class PlayerStats extends Stats
   {
       
      
      public function PlayerStats()
      {
         super();
      }
      
      public function set walkSpeed(value:Stat) : void
      {
         setStat("WalkSpeed",value);
      }
      
      public function get walkSpeed() : Stat
      {
         return getStat("WalkSpeed");
      }
      
      public function set maxSpeed(value:Stat) : void
      {
         setStat("MaxSpeed",value);
      }
      
      public function get maxSpeed() : Stat
      {
         return getStat("MaxSpeed");
      }
      
      public function set jumpPower(value:Stat) : void
      {
         setStat("JumpPower",value);
      }
      
      public function get jumpPower() : Stat
      {
         return getStat("JumpPower");
      }
      
      public function get score() : Stat
      {
         return getStat("Score");
      }
   }
}
