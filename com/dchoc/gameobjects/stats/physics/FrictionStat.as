package com.dchoc.gameobjects.stats.physics
{
   import nape.phys.Body;
   import nape.shape.Shape;
   
   public class FrictionStat extends PhysicsStat
   {
       
      
      public function FrictionStat(statName:String, body:Body, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super(statName,body,value,group,type,includeBase);
      }
      
      override protected function updatePhysics() : void
      {
         var friction:Number = calculateValue();
         body.shapes.foreach(function(shape:Shape):void
         {
            if(shape.material.dynamicFriction != friction)
            {
               shape.material.dynamicFriction = friction;
            }
         });
      }
   }
}
