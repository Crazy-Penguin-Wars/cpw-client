package tuxwars.challenges.counters
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class DestroyAllTerrainObjectsCounter extends Counter
   {
      private var originalArea:Number;
      
      public function DestroyAllTerrainObjectsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function reset() : void
      {
         super.reset();
         this.originalArea = this.calculateTerrainArea();
         LogUtils.log("Original area: " + this.originalArea,this,1,"Challenges",false,false,false);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc2_:Number = Number(NaN);
         if(param1.gameObjects)
         {
            if(param1.gameObjects.gameObjectsExist(TerrainGameObject) <= 0)
            {
               updateValue(1);
            }
            else
            {
               _loc2_ = Number(this.calculateTerrainArea());
               LogUtils.log("Current area: " + _loc2_,this,1,"Challenges",false,false,false);
               if(_loc2_ / this.originalArea < 0.05)
               {
                  updateValue(1);
               }
            }
         }
         else
         {
            LogUtils.log(toString() + " no gameObjects array",this,0,"Challenges",false,false,false);
         }
      }
      
      private function calculateTerrainArea() : Number
      {
         var _loc5_:* = undefined;
         var _loc1_:TerrainGameObject = null;
         var _loc2_:Number = 0;
         var _loc3_:* = tuxGame.tuxWorld;
         var _loc4_:Vector.<GameObject> = _loc3_._gameObjects.findGameObjectsbyClass(TerrainGameObject);
         for each(_loc5_ in _loc4_)
         {
            _loc1_ = TerrainGameObject(_loc5_);
            _loc2_ += _loc1_.calculateTotalArea();
         }
         return _loc2_;
      }
   }
}

