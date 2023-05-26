package mx.utils
{
   import flash.utils.ByteArray;
   import mx.core.mx_internal;
   
   public class RPCUIDUtil
   {
      
      mx_internal static const VERSION:String = "4.5.1.21328";
      
      private static const ALPHA_CHAR_CODES:Array = [48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70];
       
      
      public function RPCUIDUtil()
      {
         super();
      }
      
      public static function createUID() : String
      {
         var i:int = 0;
         var j:int = 0;
         var uid:Array = new Array(36);
         var index:int = 0;
         for(i = 0; i < 8; i++)
         {
            var _loc7_:* = index++;
            uid[_loc7_] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
         }
         for(i = 0; i < 3; i++)
         {
            _loc7_ = index++;
            uid[_loc7_] = 45;
            for(j = 0; j < 4; j++)
            {
               var _loc8_:* = index++;
               uid[_loc8_] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
            }
         }
         _loc7_ = index++;
         uid[_loc7_] = 45;
         var time:Number = new Date().getTime();
         var timeString:String = ("0000000" + time.toString(16).toUpperCase()).substr(-8);
         for(i = 0; i < 8; i++)
         {
            _loc8_ = index++;
            uid[_loc8_] = timeString.charCodeAt(i);
         }
         for(i = 0; i < 4; i++)
         {
            _loc8_ = index++;
            uid[_loc8_] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
         }
         return String.fromCharCode.apply(null,uid);
      }
      
      public static function fromByteArray(ba:ByteArray) : String
      {
         var chars:Array = null;
         var index:uint = 0;
         var i:uint = 0;
         var b:int = 0;
         if(ba != null && ba.length >= 16 && ba.bytesAvailable >= 16)
         {
            chars = new Array(36);
            index = 0;
            for(i = 0; i < 16; i++)
            {
               if(i == 4 || i == 6 || i == 8 || i == 10)
               {
                  var _loc6_:* = index++;
                  chars[_loc6_] = 45;
               }
               b = ba.readByte();
               _loc6_ = index++;
               chars[_loc6_] = ALPHA_CHAR_CODES[(b & 240) >>> 4];
               var _loc7_:* = index++;
               chars[_loc7_] = ALPHA_CHAR_CODES[b & 15];
            }
            return String.fromCharCode.apply(null,chars);
         }
         return null;
      }
      
      public static function isUID(uid:String) : Boolean
      {
         var i:uint = 0;
         var c:Number = NaN;
         if(uid != null && uid.length == 36)
         {
            for(i = 0; i < 36; i++)
            {
               c = uid.charCodeAt(i);
               if(i == 8 || i == 13 || i == 18 || i == 23)
               {
                  if(c != 45)
                  {
                     return false;
                  }
               }
               else if(c < 48 || c > 70 || c > 57 && c < 65)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public static function toByteArray(uid:String) : ByteArray
      {
         var result:ByteArray = null;
         var i:uint = 0;
         var c:String = null;
         var h1:uint = 0;
         var h2:uint = 0;
         if(isUID(uid))
         {
            result = new ByteArray();
            for(i = 0; i < uid.length; i++)
            {
               c = uid.charAt(i);
               if(c != "-")
               {
                  h1 = getDigit(c);
                  i++;
                  h2 = getDigit(uid.charAt(i));
                  result.writeByte((h1 << 4 | h2) & 255);
               }
            }
            result.position = 0;
            return result;
         }
         return null;
      }
      
      private static function getDigit(hex:String) : uint
      {
         switch(hex)
         {
            case "A":
            case "a":
               return 10;
            case "B":
            case "b":
               return 11;
            case "C":
            case "c":
               return 12;
            case "D":
            case "d":
               return 13;
            case "E":
            case "e":
               return 14;
            case "F":
            case "f":
               return 15;
            default:
               return new uint(hex);
         }
      }
   }
}
