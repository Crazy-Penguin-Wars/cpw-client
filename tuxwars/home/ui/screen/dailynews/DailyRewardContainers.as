package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   
   public class DailyRewardContainers extends UIContainers
   {
      public static const CONTAINER_CURRENT:String = "Container_Current";
      
      public static const CONTAINER_COMPLETE:String = "Container_Complete";
      
      public static const CONTAINER_INCOMPLETE:String = "Container_Incomplete";
      
      private var _design:MovieClip;
      
      private var _dayNumber:int;
      
      private var _text:String;
      
      private var _textValue:String;
      
      private var _textMessage:String;
      
      private var _day:int;
      
      public function DailyRewardContainers(param1:TuxWarsGame, param2:MovieClip, param3:int, param4:String, param5:String, param6:String, param7:String, param8:int)
      {
         super();
         this._design = param2;
         this._dayNumber = param3;
         this._text = param4;
         this._textValue = param5;
         this._textMessage = param6;
         this._day = param8;
         var _loc9_:MovieClip = (this._design as MovieClip).getChildByName("Container_Current_" + this._dayNumber) as MovieClip;
         var _loc10_:MovieClip = (this._design as MovieClip).getChildByName("Container_Complete_" + this._dayNumber) as MovieClip;
         var _loc11_:MovieClip = (this._design as MovieClip).getChildByName("Container_Incomplete_" + this._dayNumber) as MovieClip;
         if(_loc9_ != null)
         {
            add("Container_Current",new DailyRewardContainer(_loc9_,this,this._dayNumber,this._text,this._textValue,this._textMessage,param7,param1));
         }
         if(_loc10_ != null)
         {
            add("Container_Complete",new DailyRewardContainer(_loc10_,this,this._dayNumber,this._text,this._textValue,this._textMessage,param7,param1));
         }
         if(_loc11_ != null)
         {
            add("Container_Incomplete",new DailyRewardContainer(_loc11_,this,this._dayNumber,this._text,this._textValue,this._textMessage,param7,param1));
         }
         this.setState(this._day);
      }
      
      private function setState(param1:int) : void
      {
         if(param1 < this._dayNumber)
         {
            show("Container_Incomplete");
         }
         else if(param1 > this._dayNumber)
         {
            show("Container_Complete");
         }
         else
         {
            show("Container_Current");
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

