package com.dchoc.gameobjects.stats.physics
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.utils.LogUtils;
   import nape.phys.Body;
   
   public class PhysicsStat extends Stat
   {
       
      
      private var _body:Body;
      
      public function PhysicsStat(statName:String, body:Body, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super(statName,value,group,type,includeBase);
         _body = body;
      }
      
      override public function clone() : Stat
      {
         var _loc1_:PhysicsStat = super.clone() as PhysicsStat;
         _loc1_._body = _body;
         return _loc1_;
      }
      
      override public function addModifier(statModifier:StatModifier) : void
      {
         super.addModifier(statModifier);
         if(body)
         {
            updatePhysics();
         }
         else
         {
            LogUtils.log("No body",this,2,"Stats",false,false,false);
         }
      }
      
      override public function removeModifier(statModifier:StatModifier) : void
      {
         super.removeModifier(statModifier);
         if(body)
         {
            updatePhysics();
         }
         else
         {
            LogUtils.log("No body, cannot do updatePhysics",this,2,"Stats",false,false,false);
         }
      }
      
      protected function updatePhysics() : void
      {
         LogUtils.log("Override this in an own class for every property that needs it",this,3,"Stats",true,true,true);
      }
      
      override public function combine(stat:Stat, ignoreName:Boolean = false) : Stat
      {
         var _loc3_:PhysicsStat = super.combine(stat,ignoreName) as PhysicsStat;
         _loc3_._body = _body;
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _body = null;
      }
      
      protected function get body() : Body
      {
         return _body;
      }
   }
}
