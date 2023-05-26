package com.dchoc.gameobjects.states
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.states.State;
   import no.olog.utilfunctions.assert;
   
   public class GameObjectState extends State
   {
       
      
      private var gameObject:GameObject;
      
      public function GameObjectState(gameObject:GameObject, params:* = null)
      {
         assert("GameObject is null.",true,gameObject != null);
         var _loc3_:* = gameObject;
         super(_loc3_._game,params);
         this.gameObject = gameObject;
      }
      
      public function getGameObject() : GameObject
      {
         return gameObject;
      }
      
      override public function exit() : void
      {
         super.exit();
         gameObject = null;
      }
   }
}
