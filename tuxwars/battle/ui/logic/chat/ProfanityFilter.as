package tuxwars.battle.ui.logic.chat
{
   import flash.utils.ByteArray;
   import org.as3commons.lang.*;
   
   public class ProfanityFilter
   {
      private static var _instance:ProfanityFilter;
      
      private static const NUM_ASTERISK_WORDS:int = 30;
      
      private const profaneWords:Vector.<String>;
      
      private const asteriskMarks:Vector.<String>;
      
      private var profanity_en:Class;
      
      public function ProfanityFilter()
      {
         var _loc5_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         this.profaneWords = new Vector.<String>();
         this.asteriskMarks = new Vector.<String>(30,true);
         this.profanity_en = profanity_en$f3a38b021c6e01c779432428ed5865942102194730;
         super();
         var _loc4_:Array = this.getTextFromBAClass(this.profanity_en).split(",");
         for each(_loc5_ in _loc4_)
         {
            this.profaneWords.push(_loc5_);
         }
         _loc1_ = 0;
         while(_loc1_ < 30)
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ += "*";
               _loc3_++;
            }
            this.asteriskMarks[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public static function get instance() : ProfanityFilter
      {
         if(!_instance)
         {
            _instance = new ProfanityFilter();
         }
         return _instance;
      }
      
      public function filterString(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = param1.split(" ");
         _loc2_ = 0;
         while(_loc2_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc2_].toLowerCase();
            _loc4_ = this.profaneWords.length - 1;
            while(_loc4_ >= 0)
            {
               while(true)
               {
                  _loc5_ = int(_loc3_.indexOf(this.profaneWords[_loc4_]));
                  if(_loc5_ == -1)
                  {
                     break;
                  }
                  _loc3_ = _loc3_.replace(this.profaneWords[_loc4_],this.asteriskMarks[this.profaneWords[_loc4_].length]);
                  _loc6_[_loc2_] = StringUtils.replaceAt(_loc6_[_loc2_],this.asteriskMarks[this.profaneWords[_loc4_].length],_loc5_,_loc5_ + this.profaneWords[_loc4_].length);
               }
               _loc4_--;
            }
            _loc2_++;
         }
         return _loc6_.join(" ");
      }
      
      private function getTextFromBAClass(param1:Class) : String
      {
         var _loc2_:ByteArray = new param1();
         _loc2_.position = 0;
         return _loc2_.readUTFBytes(_loc2_.bytesAvailable);
      }
   }
}

