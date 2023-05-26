package tuxwars.home.ui.logic.dailynews
{
   public class AddData
   {
       
      
      private var _header:String;
      
      private var _text:String;
      
      private var _pictureURL:String;
      
      public function AddData(data:Object)
      {
         super();
         parse(data);
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get pictureURL() : String
      {
         return _pictureURL;
      }
      
      private function parse(data:Object) : void
      {
         _header = data.title;
         _text = data.text;
         _pictureURL = data.img;
      }
   }
}
