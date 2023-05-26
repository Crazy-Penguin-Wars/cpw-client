package no.olog.utilfunctions
{
   import com.dchoc.utils.LogUtils;
   import flash.utils.getQualifiedClassName;
   
   public function assert(testName:String, expected:*, actual:*, ... args) : void
   {
      var level:* = 0;
      var result:* = undefined;
      var expectedAsString:* = null;
      var msg:String = "[Test \"" + testName + "\"] ";
      var location:String = "";
      if(actual is Function)
      {
         actual.apply(this,args);
      }
      else if(expected is Class)
      {
         expected = getQualifiedClassName(expected);
         result = getQualifiedClassName(actual);
      }
      else if(expected is String && !isNaN(actual))
      {
         expectedAsString = expected;
         if(expectedAsString.charAt(0) == "<" && actual < Number(expectedAsString.substr(1)))
         {
            result = expected;
         }
         else if(expectedAsString.charAt(0) == ">" && actual > Number(expectedAsString.substr(1)))
         {
            result = expected;
         }
         else
         {
            result = actual;
         }
      }
      else
      {
         result = actual;
      }
      if(result === expected)
      {
         msg += "passed";
         level = 4;
         return;
      }
      msg += "failed, expected " + expected + " was " + result;
      level = 3;
      location = getCallee(3);
      LogUtils.log(msg + " at " + location,"Assert",3,"ErrorLogging",true,false,true);
      throw new Error(msg + " at " + location);
   }
}
