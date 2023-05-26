package tuxwars.challenges.counters
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class DestroyAllTerrainObjectsCounter extends Counter
   {
       
      
      private var originalArea:Number;
      
      public function DestroyAllTerrainObjectsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function reset() : void
      {
         super.reset();
         originalArea = calculateTerrainArea();
         LogUtils.log("Original area: " + originalArea,this,1,"Challenges",false,false,false);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         var _loc2_:Number = NaN;
         if(msg.gameObjects)
         {
            if(msg.gameObjects.gameObjectsExist(TerrainGameObject) <= 0)
            {
               updateValue(1);
            }
            else
            {
               _loc2_ = calculateTerrainArea();
               LogUtils.log("Current area: " + _loc2_,this,1,"Challenges",false,false,false);
               if(_loc2_ / originalArea < 0.05)
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
         var _loc1_:* = null;
         var area:Number = 0;
         var _loc5_:* = tuxGame.tuxWorld;
         var _loc3_:Vector.<GameObject> = _loc5_._gameObjects.findGameObjectsbyClass(TerrainGameObject);
         for each(var gameObject in _loc3_)
         {
            _loc1_ = TerrainGameObject(gameObject);
            area += _loc1_.calculateTotalArea();
         }
         return area;
      }
   }
}
