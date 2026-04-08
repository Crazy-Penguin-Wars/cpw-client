package tuxwars.battle.simplescript
{
   import flash.geom.Point;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class SimpleScriptParams
   {
      private var _data:*;
      
      private var _pgoA:PhysicsGameObject;
      
      private var _pgoALocation:Vec2;
      
      private var _pgoB:PhysicsGameObject;
      
      private var _pgoBLocation:Vec2;
      
      private var _emission:Emission;
      
      private var _emissionLocationOriginal:Point;
      
      private var _scriptObjectLocationOriginal:Point;
      
      public function SimpleScriptParams(param1:PhysicsGameObject = null, param2:PhysicsGameObject = null, param3:Emission = null, param4:* = null)
      {
         super();
         this.pgoA = param1;
         this.pgoB = param2;
         this.emission = param3;
         this.data = param4;
      }
      
      public function get pgoA() : PhysicsGameObject
      {
         return this._pgoA;
      }
      
      public function set pgoA(param1:PhysicsGameObject) : void
      {
         this._pgoA = param1;
      }
      
      public function get pgoB() : PhysicsGameObject
      {
         return this._pgoB;
      }
      
      public function set pgoB(param1:PhysicsGameObject) : void
      {
         this._pgoB = param1;
      }
      
      public function get emission() : Emission
      {
         return this._emission;
      }
      
      public function set emission(param1:Emission) : void
      {
         this._emission = param1;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function set data(param1:*) : void
      {
         this._data = param1;
      }
      
      public function dispose() : void
      {
         this._pgoA = null;
         this._pgoB = null;
         this._emission = null;
         this._data = null;
      }
      
      public function get pgoALocation() : Vec2
      {
         return this._pgoALocation;
      }
      
      public function set pgoALocation(param1:Vec2) : void
      {
         this._pgoALocation = param1;
      }
      
      public function get pgoBLocation() : Vec2
      {
         return this._pgoBLocation;
      }
      
      public function set pgoBLocation(param1:Vec2) : void
      {
         this._pgoBLocation = param1;
      }
      
      public function get emissionLocationOriginal() : Point
      {
         return this._emissionLocationOriginal;
      }
      
      public function set emissionLocationOriginal(param1:Point) : void
      {
         this._emissionLocationOriginal = param1;
      }
      
      public function get scriptObjectLocationOriginal() : Point
      {
         return this._scriptObjectLocationOriginal;
      }
      
      public function set scriptObjectLocationOriginal(param1:Point) : void
      {
         this._scriptObjectLocationOriginal = param1;
      }
   }
}

