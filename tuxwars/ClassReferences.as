package tuxwars
{
   import com.dchoc.ui.tooltips.UITooltip;
   import com.dchoc.ui.windows.UIWindow;
   import tuxwars.battle.missiles.Enviroment;
   import tuxwars.battle.missiles.Grenade;
   import tuxwars.battle.missiles.Mine;
   import tuxwars.battle.simplescript.scripts.AddJoint;
   import tuxwars.battle.simplescript.scripts.ApplyForce;
   import tuxwars.battle.simplescript.scripts.Chance;
   import tuxwars.battle.simplescript.scripts.Delay;
   import tuxwars.battle.simplescript.scripts.Homing;
   import tuxwars.battle.simplescript.scripts.Kill;
   import tuxwars.battle.simplescript.scripts.Ray;
   import tuxwars.battle.simplescript.scripts.RemoveFollower;
   import tuxwars.battle.simplescript.scripts.Teleport;
   import tuxwars.battle.simplescript.scripts.TriggerEmission;
   import tuxwars.battle.simplescript.scripts.ValueBasedOnChance;
   import tuxwars.battle.ui.FeedbackItem;
   
   public class ClassReferences
   {
      
      {
         UITooltip;
         UIWindow;
         Grenade;
         Mine;
         Enviroment;
         FeedbackItem;
         Chance;
         ValueBasedOnChance;
         Teleport;
         AddJoint;
         Delay;
         TriggerEmission;
         Ray;
         Homing;
         ApplyForce;
         Kill;
         RemoveFollower;
      }
      
      public function ClassReferences()
      {
         super();
      }
   }
}
