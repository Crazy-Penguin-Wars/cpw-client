package tuxwars.battle.ui.logic.chat
{
   import flash.utils.ByteArray;
   import org.as3commons.lang.StringUtils;
   
   public class ProfanityFilter
   {
      
      private static const NUM_ASTERISK_WORDS:int = 30;
      
      private static var _instance:ProfanityFilter;
       
      
      private const profaneWords:Vector.<String> = new Vector.<String>();
      
      private const asteriskMarks:Vector.<String> = new Vector.<String>(30,true);
      
      private var profanity_en:Class;
      
      public function ProfanityFilter()
      {
         var i:int = 0;
         var str:* = null;
         var j:int = 0;
         profanity_en = profanity_en$f3a38b021c6e01c779432428ed5865942102194730;
         super();
         var _loc2_:Array = getTextFromBAClass(profanity_en).split(",");
         for each(var word in _loc2_)
         {
            profaneWords.push(word);
         }
         for(i = 0; i < 30; )
         {
            str = "";
            for(j = 0; j < i; )
            {
               str += "*";
               j++;
            }
            asteriskMarks[i] = str;
            i++;
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
      
      public function filterString(str:String) : String
      {
         var i:int = 0;
         var word:* = null;
         var j:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = str.split(" ");
         for(i = 0; i < _loc3_.length; )
         {
            word = _loc3_[i].toLowerCase();
            for(j = profaneWords.length - 1; j >= 0; )
            {
               while(true)
               {
                  _loc2_ = word.indexOf(profaneWords[j]);
                  if(_loc2_ == -1)
                  {
                     break;
                  }
                  word = word.replace(profaneWords[j],asteriskMarks[profaneWords[j].length]);
                  _loc3_[i] = StringUtils.replaceAt(_loc3_[i],asteriskMarks[profaneWords[j].length],_loc2_,_loc2_ + profaneWords[j].length);
               }
               j--;
            }
            i++;
         }
         return _loc3_.join(" ");
      }
      
      private function getTextFromBAClass(clazz:Class) : String
      {
         var _loc2_:ByteArray = new clazz();
         _loc2_.position = 0;
         return _loc2_.readUTFBytes(_loc2_.bytesAvailable);
      }
   }
}
