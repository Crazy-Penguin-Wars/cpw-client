package no.olog.utilfunctions
{
   public function getCallee(calltStackIndex:int = 2) : String
   {
      var stackLine:* = null;
      var functionName:* = null;
      var className:* = null;
      var lineNumber:* = null;
      var _loc6_:String = new Error().getStackTrace();
      if(_loc6_)
      {
         stackLine = _loc6_.split("\n",calltStackIndex + 1)[calltStackIndex];
         functionName = stackLine.match(/\w+\(\)/g)[0];
         try
         {
            if(stackLine.indexOf(".as") != -1)
            {
               className = stackLine.match(/(?<=\/)\w+?(?=.as:)/)[0] + ".";
               lineNumber = ", line " + stackLine.match(/(?<=:)\d+/)[0];
            }
            else
            {
               className = "";
               lineNumber = "";
            }
            if(className.substr(0,-1) == functionName.substr(0,-2))
            {
               functionName = "constructor()";
            }
         }
         catch(e:Error)
         {
            return "Unknown Callee";
         }
         return className + functionName + lineNumber;
      }
      return "Unknown Callee";
   }
}
