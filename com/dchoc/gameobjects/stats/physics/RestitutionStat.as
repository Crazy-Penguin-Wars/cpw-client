package com.dchoc.gameobjects.stats.physics
{
   import nape.phys.Body;
   import nape.shape.Shape;
   
   public class RestitutionStat extends PhysicsStat
   {
      public function RestitutionStat(param1:String, param2:Body, param3:Number = 0, param4:String = "Group_Base", param5:String = "Normal", param6:Boolean = true)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function updatePhysics() : void
      {
         var elasticity:Number = NaN;
         elasticity = calculateValue();
         body.shapes.foreach(function(param1:Shape):void
         {
            if(param1.material.elasticity != elasticity)
            {
               param1.material.elasticity = elasticity;
            }
         });
      }
   }
}

