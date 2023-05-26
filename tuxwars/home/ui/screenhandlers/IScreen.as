package tuxwars.home.ui.screenhandlers
{
   public interface IScreen
   {
       
      
      function init(param1:*) : void;
      
      function logicUpdate(param1:int) : void;
      
      function dispose() : void;
      
      function set logic(param1:*) : void;
      
      function get logic() : *;
      
      function get design() : *;
      
      function setState(param1:String, param2:String = null) : Boolean;
      
      function get params() : *;
   }
}
