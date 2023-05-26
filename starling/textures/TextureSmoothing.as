package starling.textures
{
   import starling.errors.AbstractClassError;
   
   public class TextureSmoothing
   {
      
      public static const NONE:String = "none";
      
      public static const BILINEAR:String = "bilinear";
      
      public static const TRILINEAR:String = "trilinear";
       
      
      public function TextureSmoothing()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function isValid(smoothing:String) : Boolean
      {
         return smoothing == NONE || smoothing == BILINEAR || smoothing == TRILINEAR;
      }
   }
}
