package com.dchoc.gameobjects.stats.physics
{
   import nape.phys.Body;
   import nape.shape.Shape;
   
   public class RestitutionStat extends PhysicsStat
   {
       
      
      public function RestitutionStat(statName:String, body:Body, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super(statName,body,value,group,type,includeBase);
      }
      
      override protected function updatePhysics() : void
      {
         var elasticity:Number = calculateValue();
         body.shapes.foreach(function(shape:Shape):void
         {
            if(shape.material.elasticity != elasticity)
            {
               shape.material.elasticity = elasticity;
            }
         });
      }
   }
}
