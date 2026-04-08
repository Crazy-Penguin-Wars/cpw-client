package tuxwars.utils
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.ui.transitions.*;
   import com.dchoc.utils.*;
   import flash.display.*;
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
      
      public static function setMovieClipPosition(param1:MovieClip, param2:String, param3:String) : void
      {
         var _loc4_:int = int(DCGame.getStage().stageWidth);
         var _loc5_:int = int(DCGame.getStage().stageHeight);
         var _loc6_:int = _loc4_ * 0.5;
         var _loc7_:int = _loc5_ * 0.5;
         var _loc8_:int = param1.x == 0 ? 0 : int(Math.abs(Math.abs(param1.x) - _loc6_));
         var _loc9_:int = param1.y == 0 ? 0 : int(Math.abs(Math.abs(param1.y) - _loc7_));
         var _loc10_:* = Math.abs(param1.y) - _loc7_ < 0;
         var _loc11_:* = Math.abs(param1.x) - _loc6_ < 0;
         switch(param2)
         {
            case "top":
               param1.y -= _loc10_ ? _loc9_ : -_loc9_;
               break;
            case "bottom":
               param1.y += _loc10_ ? _loc9_ : -_loc9_;
         }
         switch(param3)
         {
            case "left":
               param1.x -= _loc11_ ? _loc8_ : -_loc8_;
               break;
            case "right":
               param1.x += _loc11_ ? _loc8_ : -_loc8_;
         }
      }
      
      public static function createButton(param1:Class, param2:MovieClip, param3:String, param4:Function = null, param5:String = null, param6:Object = null, param7:Array = null) : *
      {
         var _loc8_:* = param3 != null ? param2.getChildByName(param3) as MovieClip : param2;
         var _loc9_:* = new param1(_loc8_);
         _loc9_.setParameter(param6);
         if(param5 != null)
         {
            _loc9_.setText(ProjectManager.getText(param5,param7));
         }
         if(param4 != null)
         {
            _loc9_.setMouseClickFunction(param4);
         }
         return _loc9_;
      }
      
      public static function createAutoTextField(param1:TextField, param2:String, param3:Array = null) : UIAutoTextField
      {
         return createAutoTextFieldWithText(param1,ProjectManager.getText(param2,param3));
      }
      
      public static function createAutoTextFieldWithText(param1:TextField, param2:String = null) : UIAutoTextField
      {
         param1.selectable = false;
         var _loc3_:UIAutoTextField = new UIAutoTextField(param1);
         _loc3_.setVerticalAlignment(1,false);
         _loc3_.setHorizontalAlignment(3,false);
         if(param2 != null)
         {
            _loc3_.setText(param2);
         }
         return _loc3_;
      }
      
      public static function getScaleFactor(param1:int, param2:int, param3:int, param4:int) : Number
      {
         var _loc5_:Number = 1;
         var _loc6_:Number = 1;
         var _loc7_:Number = 1;
         var _loc8_:int = int(DCGame.getStage().stageWidth);
         var _loc9_:int = int(DCGame.getStage().stageHeight);
         if(param1 < param3 || param1 > param3)
         {
            _loc5_ = _loc8_ / param1;
         }
         if(param2 < param4 || param2 > param4)
         {
            _loc6_ = _loc9_ / param2;
         }
         if(_loc5_ >= 1 || _loc6_ >= 1)
         {
            _loc7_ = Math.max(_loc5_,_loc6_);
         }
         else if(_loc5_ < 1 || _loc6_ < 1)
         {
            _loc7_ = Math.min(_loc5_,_loc6_);
         }
         return _loc7_;
      }
      
      public static function getPlayersSortedByScore(param1:Array) : Array
      {
         var players:Array = param1;
         var tmpArray:Array = players.slice();
         tmpArray.sort(function(param1:IScore, param2:IScore):int
         {
            return param2.getScore() - param1.getScore();
         });
         return tmpArray;
      }
      
      public static function numberFormat(param1:Number, param2:int = 2, param3:Boolean = false, param4:Boolean = true) : String
      {
         var _loc5_:* = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = Math.pow(10,param2);
         var _loc9_:String = String(Math.round(_loc8_ * param1) / _loc8_);
         _loc5_ = _loc9_.indexOf(".") == -1;
         var _loc10_:int = int(_loc5_ ? _loc9_.length : _loc9_.indexOf("."));
         var _loc11_:* = (_loc5_ && !param3 ? "" : (param4 ? "," : ".")) + _loc9_.substr(_loc10_ + 1);
         if(param3)
         {
            _loc6_ = 0;
            while(_loc6_ <= param2 - (_loc9_.length - (_loc5_ ? _loc10_ - 1 : _loc10_)))
            {
               _loc11_ += "0";
               _loc6_++;
            }
         }
         while(_loc7_ + 3 < (_loc9_.substr(0,1) == "-" ? _loc10_ - 1 : _loc10_))
         {
            _loc11_ = (param4 ? "." : ",") + _loc9_.substr(_loc10_ - (_loc7_ = _loc7_ + 3),3) + _loc11_;
         }
         return _loc9_.substr(0,_loc10_ - _loc7_) + _loc11_;
      }
      
      public static function createTransition(param1:UITransition, param2:MovieClip, param3:String, param4:Function, param5:Boolean = true) : UITransition
      {
         var _loc6_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf",param3);
         if(_loc6_)
         {
            param1 = new UITransition(param2,_loc6_,param5);
            if(Boolean(param4))
            {
               param2.addEventListener("transition_end",param4);
            }
            return param1;
         }
         LogUtils.log("Did not find a Transition named: " + param3 + " in " + "flash/ui/hud_shared.swf","TuxUiUtils",3,"Transitions",true,true,true);
         return null;
      }
      
      public static function getRandomProbability(param1:uint, param2:String = "") : Boolean
      {
         var _loc3_:Number = randomNumbers(1,100);
         return _loc3_ < param1;
      }
      
      public static function randomNumbers(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * param2) + param1;
      }
   }
}

