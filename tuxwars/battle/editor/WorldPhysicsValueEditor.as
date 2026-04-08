package tuxwars.battle.editor
{
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import nape.geom.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.states.TuxBattleState;
   import tuxwars.battle.world.PhysicsWorld;
   import tuxwars.battle.world.TuxWorld;
   
   public class WorldPhysicsValueEditor
   {
      private static var screen:MovieClip;
      
      private static var okButton:Sprite;
      
      private static var battleState:TuxBattleState;
      
      private static var tuxWorld:TuxWorld;
      
      private static var physicsWorld:PhysicsWorld;
      
      private static var editFields:Array;
      
      private static const OLD_VALUE:String = "old_value";
      
      private static const FIELD:String = "field";
      
      private static const TABLE_NAME:String = "WorldPhysic";
      
      private static const GRAVITY:String = "Gravity";
      
      private static const WALK_SPEED:String = "WalkSpeed";
      
      private static const JUMP_POWER:String = "JumpPower";
      
      private static const FALL_DAMAGE_MULTIPLIER:String = "FallDamageMultiplier";
      
      private static const FALL_DAMAGE_EFFECT_START_VALUE:String = "FallDamageEffectStartValue";
      
      private static const FALL_IMPULSE_THRESHOLD:String = "FallImpulseThreshold";
      
      private static var showWorldPhysics:Boolean = false;
      
      public function WorldPhysicsValueEditor()
      {
         super();
         throw new Error("WorldPhysicsValueEditor is a static class!");
      }
      
      public static function setBattleState(param1:TuxBattleState) : void
      {
         battleState = param1;
         tuxWorld = battleState.tuxGame.tuxWorld;
         physicsWorld = battleState.tuxGame.tuxWorld.physicsWorld;
      }
      
      public static function isShown() : Boolean
      {
         return showWorldPhysics;
      }
      
      public static function showWorldPhysicsEditScreen() : void
      {
         var _loc1_:Sprite = null;
         var _loc5_:* = undefined;
         _loc1_ = null;
         var _loc2_:TextField = null;
         var _loc3_:* = null;
         var _loc4_:Array = null;
         showWorldPhysics = !showWorldPhysics;
         if(isShown())
         {
            screen = new MovieClip();
            screen.x = DCGame.getStage().stageWidth / 2;
            screen.y = DCGame.getStage().stageHeight / 2;
            _loc1_ = addBackground(0,0,400,180,3,136,16777215,screen);
            _loc2_ = addTextField("World Physics Values (edit numbers, press ok)","center",screen,_loc1_.height / 2 - 5);
            _loc2_.x += _loc1_.width / 2;
            editFields = [];
            addTextField("Gravity","left",screen,_loc1_.height / 2 - 40,WorldPhysics.getGravity());
            addTextField("WalkSpeed","left",screen,_loc1_.height / 2 - 60,WorldPhysics.getWalkSpeed());
            addTextField("JumpPower","left",screen,_loc1_.height / 2 - 80,WorldPhysics.getJumpPower());
            addTextField("FallDamageMultiplier","left",screen,_loc1_.height / 2 - 100,WorldPhysics.getFallDamageMultiplier());
            addTextField("FallDamageEffectStartValue","left",screen,_loc1_.height / 2 - 120,WorldPhysics.getFallDamageEffectStartValue());
            addTextField("FallImpulseThreshold","left",screen,_loc1_.height / 2 - 140,WorldPhysics.getFallImpulseThreshold());
            addButton(screen);
            DCGame.getMainMovieClip().addChild(screen);
         }
         else
         {
            if(okButton)
            {
               okButton.removeEventListener("click",buttonClickHandler);
            }
            DCGame.getMainMovieClip().removeChild(screen);
            storeLine("Gravity",int);
            storeLine("WalkSpeed",int);
            storeLine("JumpPower",int);
            storeLine("FallDamageMultiplier",Number);
            storeLine("FallDamageEffectStartValue",Number);
            storeLine("FallImpulseThreshold",int);
            physicsWorld.space.gravity = Vec2.weak(0,WorldPhysics.getGravity());
            _loc4_ = tuxWorld.players;
            for each(_loc5_ in _loc4_)
            {
               _loc5_.playerStats.walkSpeed = WorldPhysics.getWalkSpeed();
               _loc5_.playerStats.jumpPower = WorldPhysics.getJumpPower();
            }
         }
      }
      
      private static function storeLine(param1:String, param2:Class) : void
      {
         var _loc3_:String = TextField(editFields[param1]["field"]).text;
         setValue(param1,new param2(_loc3_));
         var _loc4_:String = editFields[param1]["old_value"] as String;
         if(_loc3_ != _loc4_)
         {
            LogUtils.log(param1 + " new value: " + _loc3_ + " (old value:" + _loc4_ + ")",WorldPhysicsValueEditor,4,"All",false,false,false);
         }
      }
      
      private static function addBackground(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:MovieClip) : Sprite
      {
         var _loc9_:Sprite = new Sprite();
         _loc9_.graphics.lineStyle(param5,param6);
         _loc9_.graphics.beginFill(param7);
         _loc9_.graphics.drawRect(param1,param2,param3,param4);
         _loc9_.graphics.endFill();
         _loc9_.x -= _loc9_.width / 2;
         _loc9_.y -= _loc9_.height / 2;
         param8.addChild(_loc9_);
         return _loc9_;
      }
      
      private static function addButton(param1:MovieClip) : void
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.lineStyle(2,10066329);
         _loc2_.graphics.beginFill(16777215);
         _loc2_.graphics.drawRect(0,0,45,25);
         _loc2_.graphics.endFill();
         _loc2_.x -= _loc2_.width / 2 - 160;
         _loc2_.y -= _loc2_.height / 2 - 50;
         _loc2_.useHandCursor = true;
         _loc2_.buttonMode = true;
         _loc2_.mouseChildren = false;
         var _loc3_:TextField = new TextField();
         _loc3_.autoSize = "left";
         _loc3_.text = "OK";
         _loc3_.x += 10;
         _loc3_.y += 3;
         _loc3_.selectable = false;
         _loc2_.addChild(_loc3_);
         _loc2_.addEventListener("click",buttonClickHandler);
         okButton = _loc2_;
         param1.addChild(_loc2_);
      }
      
      private static function buttonClickHandler(param1:MouseEvent) : void
      {
         showWorldPhysicsEditScreen();
      }
      
      private static function addTextField(param1:String, param2:String, param3:MovieClip, param4:int, param5:* = null) : TextField
      {
         var _loc6_:Object = null;
         var _loc7_:TextField = null;
         var _loc8_:TextField = new TextField();
         _loc8_.text = param1;
         _loc8_.autoSize = param2;
         _loc8_.x -= _loc8_.width;
         _loc8_.y -= param4;
         _loc8_.selectable = false;
         param3.addChild(_loc8_);
         if(param5 != null)
         {
            _loc6_ = {};
            _loc7_ = new TextField();
            _loc7_.text = "" + param5;
            _loc7_.autoSize = "right";
            _loc7_.y -= param4;
            _loc7_.selectable = true;
            _loc7_.doubleClickEnabled = true;
            _loc7_.type = "input";
            _loc6_["old_value"] = "" + param5;
            _loc6_["field"] = _loc7_;
            editFields[param1] = _loc6_;
            param3.addChild(_loc7_);
         }
         return _loc8_;
      }
      
      private static function getValue(param1:String) : *
      {
         var _loc2_:* = param1;
         var _loc3_:* = getRow();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:* = _loc3_.getCache[_loc2_];
         return _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
      }
      
      private static function setValue(param1:String, param2:*) : void
      {
         var _loc3_:* = param1;
         var _loc4_:* = getRow();
         if(!_loc4_.getCache[_loc3_])
         {
            _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
         }
         _loc4_.getCache[_loc3_].value = param2;
      }
      
      private static function getRow() : Row
      {
         var _loc4_:Row = null;
         var _loc1_:String = "WorldPhysic";
         var _loc2_:String = "Default";
         var _loc3_:* = ProjectManager.findTable(_loc1_);
         if(!_loc3_.getCache[_loc2_])
         {
            _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc4_;
         }
         return _loc3_.getCache[_loc2_];
      }
   }
}

