package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
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
      
      public function DailyRewardContainers(game:TuxWarsGame, design:MovieClip, dayNumber:int, text:String, textValue:String, textMessage:String, icon:String, day:int)
      {
         super();
         _design = design;
         _dayNumber = dayNumber;
         _text = text;
         _textValue = textValue;
         _textMessage = textMessage;
         _day = day;
         var currentContainer:MovieClip = (_design as MovieClip).getChildByName("Container_Current_" + _dayNumber) as MovieClip;
         var completeContainer:MovieClip = (_design as MovieClip).getChildByName("Container_Complete_" + _dayNumber) as MovieClip;
         var incompleteContainer:MovieClip = (_design as MovieClip).getChildByName("Container_Incomplete_" + _dayNumber) as MovieClip;
         if(currentContainer != null)
         {
            add("Container_Current",new DailyRewardContainer(currentContainer,this,_dayNumber,_text,_textValue,_textMessage,icon,game));
         }
         if(completeContainer != null)
         {
            add("Container_Complete",new DailyRewardContainer(completeContainer,this,_dayNumber,_text,_textValue,_textMessage,icon,game));
         }
         if(incompleteContainer != null)
         {
            add("Container_Incomplete",new DailyRewardContainer(incompleteContainer,this,_dayNumber,_text,_textValue,_textMessage,icon,game));
         }
         setState(_day);
      }
      
      private function setState(day:int) : void
      {
         if(day < _dayNumber)
         {
            show("Container_Incomplete");
         }
         else if(day > _dayNumber)
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
