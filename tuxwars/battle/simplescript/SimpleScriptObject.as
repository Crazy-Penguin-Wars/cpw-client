package tuxwars.battle.simplescript
{
   import nape.geom.Vec2;
   
   public class SimpleScriptObject implements SimpleScript
   {
       
      
      private const array:Array = [];
      
      private var _id:String;
      
      private var _uniqueId:String;
      
      private var _params;
      
      private var _parent;
      
      public function SimpleScriptObject(className:String, variables:Array, params:* = null, parent:* = null)
      {
         super();
         array.push(className);
         for each(var variable in variables)
         {
            array.push(variable);
         }
         _params = params;
         _parent = parent;
      }
      
      public function get className() : String
      {
         return array[0];
      }
      
      public function get variables() : Array
      {
         return array;
      }
      
      public function get params() : *
      {
         return _params;
      }
      
      public function get location() : Vec2
      {
         return null;
      }
      
      public function get id() : String
      {
         if(parent)
         {
            if(parent.hasOwnProperty("shortName"))
            {
               return "SS_P_" + parent["shortName"];
            }
            if(parent.hasOwnProperty("id"))
            {
               return "SS_P_" + parent["id"];
            }
         }
         return "SS_" + className;
      }
      
      public function get uniqueId() : String
      {
         if(parent)
         {
            if(parent.hasOwnProperty("shortName"))
            {
               return "SS_P_" + parent["shortName"];
            }
            if(parent.hasOwnProperty("uniqueId"))
            {
               return "SS_P_" + parent["uniqueId"];
            }
         }
         return "SS_" + className;
      }
      
      public function get parent() : *
      {
         return _parent;
      }
   }
}
