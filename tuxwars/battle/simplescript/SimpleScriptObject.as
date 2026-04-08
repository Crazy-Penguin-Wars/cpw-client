package tuxwars.battle.simplescript
{
   import nape.geom.Vec2;
   
   public class SimpleScriptObject implements SimpleScript
   {
      private const array:Array;
      
      private var _id:String;
      
      private var _uniqueId:String;
      
      private var _params:*;
      
      private var _parent:*;
      
      public function SimpleScriptObject(param1:String, param2:Array, param3:* = null, param4:* = null)
      {
         var _loc5_:* = undefined;
         this.array = [];
         super();
         this.array.push(param1);
         for each(_loc5_ in param2)
         {
            this.array.push(_loc5_);
         }
         this._params = param3;
         this._parent = param4;
      }
      
      public function get className() : String
      {
         return this.array[0];
      }
      
      public function get variables() : Array
      {
         return this.array;
      }
      
      public function get params() : *
      {
         return this._params;
      }
      
      public function get location() : Vec2
      {
         return null;
      }
      
      public function get id() : String
      {
         if(this.parent)
         {
            if(this.parent.hasOwnProperty("shortName"))
            {
               return "SS_P_" + this.parent["shortName"];
            }
            if(this.parent.hasOwnProperty("id"))
            {
               return "SS_P_" + this.parent["id"];
            }
         }
         return "SS_" + this.className;
      }
      
      public function get uniqueId() : String
      {
         if(this.parent)
         {
            if(this.parent.hasOwnProperty("shortName"))
            {
               return "SS_P_" + this.parent["shortName"];
            }
            if(this.parent.hasOwnProperty("uniqueId"))
            {
               return "SS_P_" + this.parent["uniqueId"];
            }
         }
         return "SS_" + this.className;
      }
      
      public function get parent() : *
      {
         return this._parent;
      }
   }
}

