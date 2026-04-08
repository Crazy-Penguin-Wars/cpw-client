package tuxwars.home.ui.logic.dailynews
{
   public class AddData
   {
      private var _header:String;
      
      private var _text:String;
      
      private var _pictureURL:String;
      
      public function AddData(param1:Object)
      {
         super();
         this.parse(param1);
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get pictureURL() : String
      {
         return this._pictureURL;
      }
      
      private function parse(param1:Object) : void
      {
         this._header = param1.title;
         this._text = param1.text;
         this._pictureURL = param1.img;
      }
   }
}

