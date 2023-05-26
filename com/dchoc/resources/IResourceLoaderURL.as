package com.dchoc.resources
{
   import flash.display.MovieClip;
   
   public interface IResourceLoaderURL
   {
       
      
      function getResourceUrl() : String;
      
      function getTargetMovieClip() : MovieClip;
   }
}
