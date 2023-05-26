package tuxwars.home.ui.screenhandlers
{
   public interface ILogic
   {
       
      
      function preInit(param1:*) : void;
      
      function init(param1:*) : void;
      
      function logicUpdate(param1:int) : void;
      
      function dispose() : void;
      
      function set screen(param1:*) : void;
      
      function get screen() : *;
      
      function get params() : *;
   }
}
