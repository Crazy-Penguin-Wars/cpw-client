package com.dchoc.resources
{
   import flash.net.URLLoader;
   
   public class URLLoaderWithName extends URLLoader
   {
      
      private static var counter:int;
       
      
      private var id:int;
      
      public function URLLoaderWithName()
      {
         super();
         this.id = counter;
         counter++;
      }
      
      public function getName() : String
      {
         return this.toString() + id;
      }
   }
}
