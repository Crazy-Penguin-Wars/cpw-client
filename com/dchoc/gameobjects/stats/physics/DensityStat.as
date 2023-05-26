package com.dchoc.gameobjects.stats.physics
{
   import nape.phys.Body;
   import nape.shape.Shape;
   
   public class DensityStat extends PhysicsStat
   {
       
      
      public function DensityStat(statName:String, body:Body, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super(statName,body,value,group,type,includeBase);
      }
      
      override protected function updatePhysics() : void
      {
         var density:Number = calculateValue();
         body.shapes.foreach(function(shape:Shape):void
         {
            if(shape.material.density != density)
            {
               shape.material.density = density;
            }
         });
      }
   }
}
