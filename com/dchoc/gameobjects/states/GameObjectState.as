package com.dchoc.gameobjects.states
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.states.State;
   import no.olog.utilfunctions.*;
   
   public class GameObjectState extends State
   {
      private var gameObject:GameObject;
      
      public function GameObjectState(param1:GameObject, param2:* = null)
      {
         assert("GameObject is null.",true,param1 != null);
         var _loc3_:* = param1;
         super(_loc3_._game,param2);
         this.gameObject = param1;
      }
      
      public function getGameObject() : GameObject
      {
         return this.gameObject;
      }
      
      override public function exit() : void
      {
         super.exit();
         this.gameObject = null;
      }
   }
}

