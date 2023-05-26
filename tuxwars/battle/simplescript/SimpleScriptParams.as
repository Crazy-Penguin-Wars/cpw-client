package tuxwars.battle.simplescript
{
   import flash.geom.Point;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class SimpleScriptParams
   {
       
      
      private var _data;
      
      private var _pgoA:PhysicsGameObject;
      
      private var _pgoALocation:Vec2;
      
      private var _pgoB:PhysicsGameObject;
      
      private var _pgoBLocation:Vec2;
      
      private var _emission:Emission;
      
      private var _emissionLocationOriginal:Point;
      
      private var _scriptObjectLocationOriginal:Point;
      
      public function SimpleScriptParams(pgoA:PhysicsGameObject = null, pgoB:PhysicsGameObject = null, emission:Emission = null, data:* = null)
      {
         super();
         this.pgoA = pgoA;
         this.pgoB = pgoB;
         this.emission = emission;
         this.data = data;
      }
      
      public function get pgoA() : PhysicsGameObject
      {
         return _pgoA;
      }
      
      public function set pgoA(value:PhysicsGameObject) : void
      {
         _pgoA = value;
      }
      
      public function get pgoB() : PhysicsGameObject
      {
         return _pgoB;
      }
      
      public function set pgoB(value:PhysicsGameObject) : void
      {
         _pgoB = value;
      }
      
      public function get emission() : Emission
      {
         return _emission;
      }
      
      public function set emission(value:Emission) : void
      {
         _emission = value;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function set data(value:*) : void
      {
         _data = value;
      }
      
      public function dispose() : void
      {
         _pgoA = null;
         _pgoB = null;
         _emission = null;
         _data = null;
      }
      
      public function get pgoALocation() : Vec2
      {
         return _pgoALocation;
      }
      
      public function set pgoALocation(value:Vec2) : void
      {
         _pgoALocation = value;
      }
      
      public function get pgoBLocation() : Vec2
      {
         return _pgoBLocation;
      }
      
      public function set pgoBLocation(value:Vec2) : void
      {
         _pgoBLocation = value;
      }
      
      public function get emissionLocationOriginal() : Point
      {
         return _emissionLocationOriginal;
      }
      
      public function set emissionLocationOriginal(value:Point) : void
      {
         _emissionLocationOriginal = value;
      }
      
      public function get scriptObjectLocationOriginal() : Point
      {
         return _scriptObjectLocationOriginal;
      }
      
      public function set scriptObjectLocationOriginal(value:Point) : void
      {
         _scriptObjectLocationOriginal = value;
      }
   }
}
