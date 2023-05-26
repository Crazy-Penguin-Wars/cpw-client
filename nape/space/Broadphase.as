package nape.space
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class Broadphase
   {
       
      
      public function Broadphase()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "Broadphase" + " derp!";
         }
      }
      
      public static function get DYNAMIC_AABB_TREE() : Broadphase
      {
         if(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE;
      }
      
      public static function get SWEEP_AND_PRUNE() : Broadphase
      {
         if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.Broadphase_SWEEP_AND_PRUNE;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE)
         {
            return "DYNAMIC_AABB_TREE";
         }
         §§push(this);
         if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Broadphase_SWEEP_AND_PRUNE)
         {
            return "SWEEP_AND_PRUNE";
         }
         return "";
      }
   }
}
