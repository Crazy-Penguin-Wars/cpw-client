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
      
      public function set walkSpeed(param1:Stat) : void
      {
         setStat("WalkSpeed",param1);
      }
      
      public function get walkSpeed() : Stat
      {
         return getStat("WalkSpeed");
      }
      
      public function set maxSpeed(param1:Stat) : void
      {
         setStat("MaxSpeed",param1);
      }
      
      public function get maxSpeed() : Stat
      {
         return getStat("MaxSpeed");
      }
      
      public function set jumpPower(param1:Stat) : void
      {
         setStat("JumpPower",param1);
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

