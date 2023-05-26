package com.dchoc.gameobjects.stats.physics
{
   import nape.phys.Body;
   
   public class GravityScaleStat extends PhysicsStat
   {
       
      
      public function GravityScaleStat(statName:String, body:Body, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super(statName,body,value,group,type,includeBase);
      }
      
      override protected function updatePhysics() : void
      {
         body.gravMassScale = calculateValue();
      }
   }
}
