package com.dchoc.avatar
{
   public interface IAvatar
   {
       
      
      function putOnItem(param1:WearableItem) : Boolean;
      
      function takeOffItem(param1:WearableItem) : void;
      
      function getWornItems() : Array;
      
      function stopAnimation() : void;
      
      function resumeAnimation() : void;
      
      function set gender(param1:int) : void;
      
      function get gender() : int;
      
      function set color(param1:IAvatarColor) : void;
   }
}
