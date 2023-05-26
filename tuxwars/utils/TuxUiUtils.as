package tuxwars.utils
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.transitions.UITransition;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TuxUiUtils
   {
      
      public static const TOP:String = "top";
      
      public static const BOTTOM:String = "bottom";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CENTER:String = "center";
       
      
      public function TuxUiUtils()
      {
         super();
         throw new Error("TuxUiUtils class is static!");
      }
      
      public static function setMovieClipPosition(mc:MovieClip, vertical:String, horisontal:String) : void
      {
         var _loc12_:DCGame = DCGame;
         var _loc6_:int = int(com.dchoc.game.DCGame._stage.stageWidth);
         var _loc13_:DCGame = DCGame;
         var _loc4_:int = int(com.dchoc.game.DCGame._stage.stageHeight);
         var halfW:int = _loc6_ * 0.5;
         var halfH:int = _loc4_ * 0.5;
         var halfChangeW:int = mc.x == 0 ? 0 : Math.abs(Math.abs(mc.x) - halfW);
         var halfChangeH:int = mc.y == 0 ? 0 : Math.abs(Math.abs(mc.y) - halfH);
         var vBigger:Boolean = Math.abs(mc.y) - halfH < 0;
         var hBigger:Boolean = Math.abs(mc.x) - halfW < 0;
         switch(vertical)
         {
            case "top":
               mc.y -= vBigger ? halfChangeH : -halfChangeH;
               break;
            case "bottom":
               mc.y += vBigger ? halfChangeH : -halfChangeH;
         }
         switch(horisontal)
         {
            case "left":
               mc.x -= hBigger ? halfChangeW : -halfChangeW;
               break;
            case "right":
               mc.x += hBigger ? halfChangeW : -halfChangeW;
         }
      }
      
      public static function createButton(klass:Class, mc:MovieClip, childName:String, clickCallback:Function = null, tid:String = null, parameter:Object = null, tidParams:Array = null) : *
      {
         var _loc9_:* = childName != null ? mc.getChildByName(childName) as MovieClip : mc;
         var _loc8_:* = new klass(_loc9_);
         _loc8_.setParameter(parameter);
         if(tid != null)
         {
            _loc8_.setText(ProjectManager.getText(tid,tidParams));
         }
         if(clickCallback != null)
         {
            _loc8_.setMouseClickFunction(clickCallback);
         }
         return _loc8_;
      }
      
      public static function createAutoTextField(tf:TextField, tid:String, tidParams:Array = null) : UIAutoTextField
      {
         return createAutoTextFieldWithText(tf,ProjectManager.getText(tid,tidParams));
      }
      
      public static function createAutoTextFieldWithText(tf:TextField, text:String = null) : UIAutoTextField
      {
         tf.selectable = false;
         var _loc3_:UIAutoTextField = new UIAutoTextField(tf);
         _loc3_.setVerticalAlignment(1,false);
         _loc3_.setHorizontalAlignment(3,false);
         if(text != null)
         {
            _loc3_.setText(text);
         }
         return _loc3_;
      }
      
      public static function getScaleFactor(dWidth:int, dHeight:int, sWidth:int, sHeigth:int) : Number
      {
         var scaleX:Number = 1;
         var scaleY:Number = 1;
         var scale:Number = 1;
         var _loc10_:DCGame = DCGame;
         var _loc9_:int = int(com.dchoc.game.DCGame._stage.stageWidth);
         var _loc11_:DCGame = DCGame;
         var _loc5_:int = int(com.dchoc.game.DCGame._stage.stageHeight);
         if(dWidth < sWidth || dWidth > sWidth)
         {
            scaleX = _loc9_ / dWidth;
         }
         if(dHeight < sHeigth || dHeight > sHeigth)
         {
            scaleY = _loc5_ / dHeight;
         }
         if(scaleX >= 1 || scaleY >= 1)
         {
            scale = Math.max(scaleX,scaleY);
         }
         else if(scaleX < 1 || scaleY < 1)
         {
            scale = Math.min(scaleX,scaleY);
         }
         return scale;
      }
      
      public static function getPlayersSortedByScore(players:Array) : Array
      {
         var tmpArray:Array = players.slice();
         tmpArray.sort(function(score1:IScore, score2:IScore):int
         {
            return score2.getScore() - score1.getScore();
         });
         return tmpArray;
      }
      
      public static function numberFormat(number:Number, maxDecimals:int = 2, forceDecimals:Boolean = false, siStyle:Boolean = true) : String
      {
         var hasSep:Boolean = false;
         var j:int = 0;
         var i:int = 0;
         var inc:Number = Math.pow(10,maxDecimals);
         var str:String = String(Math.round(inc * number) / inc);
         hasSep = str.indexOf(".") == -1;
         var sep:int = hasSep ? str.length : str.indexOf(".");
         var ret:String = (hasSep && !forceDecimals ? "" : (siStyle ? "," : ".")) + str.substr(sep + 1);
         if(forceDecimals)
         {
            for(j = 0; j <= maxDecimals - (str.length - (hasSep ? sep - 1 : sep)); ret += "0",j++)
            {
            }
         }
         while(i + 3 < (str.substr(0,1) == "-" ? sep - 1 : sep))
         {
            ret = (siStyle ? "." : ",") + str.substr(sep - (i += 3),3) + ret;
         }
         return str.substr(0,sep - i) + ret;
      }
      
      public static function createTransition(transition:UITransition, whatToTransition:MovieClip, nameOfTransition:String, endedCallback:Function, useBitmap:Boolean = true) : UITransition
      {
         var _loc6_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf",nameOfTransition);
         if(_loc6_)
         {
            transition = new UITransition(whatToTransition,_loc6_,useBitmap);
            if(Boolean(endedCallback))
            {
               whatToTransition.addEventListener("transition_end",endedCallback);
            }
            return transition;
         }
         LogUtils.log("Did not find a Transition named: " + nameOfTransition + " in " + "flash/ui/hud_shared.swf","TuxUiUtils",3,"Transitions",true,true,true);
         return null;
      }
      
      public static function getRandomProbability(percentage:uint, reference:String = "") : Boolean
      {
         var num:Number = randomNumbers(1,100);
         return num < percentage;
      }
      
      public static function randomNumbers(min:Number, max:Number) : Number
      {
         return Math.floor(Math.random() * max) + min;
      }
   }
}
