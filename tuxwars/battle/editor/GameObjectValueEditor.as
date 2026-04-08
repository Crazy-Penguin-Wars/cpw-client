package tuxwars.battle.editor
{
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import flash.utils.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.states.TuxBattleState;
   
   public class GameObjectValueEditor
   {
      private static var stage:MovieClip;
      
      private static var screen:MovieClip;
      
      private static var applyButton:Sprite;
      
      private static var applyAllButton:Sprite;
      
      private static var battleState:TuxBattleState;
      
      private static var lastEditedKlazz:Class;
      
      private static var lastEditedTuxGameObject:TuxGameObject;
      
      private static var fields:Array;
      
      private static var textLinePosX:int;
      
      private static const KEY:String = "key";
      
      private static const OLD_VALUE:String = "old value";
      
      private static const EDIT_FIELD:String = "edit field";
      
      private static const COMMON_HP:String = "HP";
      
      private static const COMMON_MAX_HP:String = "Max HP";
      
      private static const COMMON_FIELD_HP:String = "HitPoints";
      
      private static const TOUGHNESS:String = "Toughness";
      
      private static const COMMON_DENSITY:String = "Density";
      
      private static const COMMON_FRICTION:String = "Friction";
      
      private static const COMMON_RESTITUTION:String = "Restitution";
      
      private static const MISSILE_DAMAGE:String = "Damage";
      
      private static const MISSILE_DAMAGE_RADIUS:String = "DamageRadius";
      
      private static const MISSILE_RADIUS:String = "ImpulseRadius";
      
      private static const MISSILE_IMPULSE:String = "Impulse";
      
      private static const GRENADE_TIMER:String = "Timer";
      
      private static const FIRING_IMPULSE:String = "FiringImpulse";
      
      private static const FIRING_IMPULSE_MIN:String = "FiringImpulseMin";
      
      private static var showGameObjectScreen:Boolean = false;
      
      public function GameObjectValueEditor()
      {
         super();
         throw new Error("GameObjectValueEditor is a static class!");
      }
      
      public static function showGameObjectEditScreen(param1:GameObject = null, param2:Class = null) : void
      {
         showGameObjectScreen = !showGameObjectScreen;
         if(isShown() && param1 != null && param2 != null)
         {
            createScreen(param1,param2);
            if(!stage)
            {
               stage = DCGame.getMainMovieClip();
            }
            stage.addChild(screen);
         }
         else
         {
            if(applyButton)
            {
               applyButton.removeEventListener("click",buttonClickHandler);
            }
            if(applyAllButton)
            {
               applyAllButton.removeEventListener("click",buttonClickHandlerAll);
            }
            if(stage != null && Boolean(stage.contains(screen)))
            {
               stage.removeChild(screen);
            }
         }
      }
      
      public static function isShown() : Boolean
      {
         return showGameObjectScreen;
      }
      
      public static function setBattleState(param1:TuxBattleState) : void
      {
         battleState = param1;
      }
      
      private static function createScreenTexts(param1:TuxGameObject, param2:Class) : void
      {
         var _loc3_:Missile = null;
         var _loc4_:PlayerGameObject = null;
         var _loc5_:LevelGameObject = null;
         fields = [];
         var _loc6_:String = getQualifiedClassName(param2);
         var _loc7_:TextField = new TextField();
         _loc7_.autoSize = "left";
         var _loc8_:* = param1;
         _loc7_.text = "ID: " + _loc8_._id + " " + param2;
         _loc7_.x = screen.width / 2 - _loc7_.textWidth / 2;
         _loc7_.selectable = false;
         screen.addChild(_loc7_);
         textLinePosX = _loc7_.textHeight + 15;
         lastEditedKlazz = param2;
         lastEditedTuxGameObject = param1;
         switch(_loc6_)
         {
            case getQualifiedClassName(Missile):
               _loc3_ = param1 as Missile;
               break;
            case getQualifiedClassName(PlayerGameObject):
               _loc4_ = param1 as PlayerGameObject;
               break;
            case getQualifiedClassName(LevelGameObject):
               _loc5_ = param1 as LevelGameObject;
               createLine("Toughness",new String(_loc5_.getToughness()));
               break;
            case getQualifiedClassName(PhysicsGameObject):
            default:
               LogUtils.log("No configured class of game object",GameObjectValueEditor,2,"All",false,false,false);
         }
         if(!(param1 is TerrainGameObject))
         {
            createLine("HP",new String(param1.calculateHitPoints()),param1 is PlayerGameObject);
            createLine("Max HP",new String(param1.calculateMaxHitPoints()),param1 is PlayerGameObject);
         }
      }
      
      private static function storeRealTimeValues(param1:TuxGameObject, param2:Object) : void
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Stat = null;
         var _loc6_:String = null;
         switch(param2["key"])
         {
            case "HP":
               if(param1._hasHPs)
               {
                  _loc7_ = "HP";
                  _loc8_ = param1;
                  (!!_loc8_.stats ? _loc8_.stats.getStat(_loc7_) : null).clearTemp();
                  _loc3_ = param1.calculateMaxHitPoints();
                  _loc4_ = int((param2["edit field"] as TextField).text);
               }
               break;
            case "Max HP":
               if(param1._hasHPs)
               {
                  _loc9_ = "HP";
                  _loc10_ = param1;
                  _loc5_ = !!_loc10_.stats ? _loc10_.stats.getStat(_loc9_) : null;
                  _loc6_ = _loc5_.getBaseModifierName();
                  _loc5_.getModifier(_loc6_).value = int((param2["edit field"] as TextField).text);
               }
               break;
            case "Friction":
            case "Restitution":
            case "Density":
               updateRealtimePhysicsReference(param1);
               break;
            case "FiringImpulse":
            case "FiringImpulseMin":
               break;
            case "Toughness":
               (param1 as LevelGameObject).setToughness(int((param2["edit field"] as TextField).text));
         }
      }
      
      private static function updateRealtimePhysicsReference(param1:TuxGameObject) : void
      {
         var _loc8_:Row = null;
         var _loc9_:PhysicsReference = null;
         var _loc2_:String = param1.tableName;
         var _loc3_:String = param1._id;
         var _loc4_:Table = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc8_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc8_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc8_;
         }
         var _loc5_:Row = _loc4_.getCache[_loc3_];
         if(!_loc5_.getCache["Physics"])
         {
            _loc5_.getCache["Physics"] = DCUtils.find(_loc5_.getFields(),"name","Physics");
         }
         var _loc6_:Field = _loc5_.getCache["Physics"];
         var _loc7_:Row = !!_loc6_ ? (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null;
         if(_loc7_)
         {
            _loc9_ = new PhysicsReference(_loc7_);
         }
      }
      
      private static function storeToConfig(param1:Object) : void
      {
         var _loc4_:TuxGameObject = null;
         var _loc5_:TuxGameObject = null;
         var _loc6_:TuxGameObject = null;
         var _loc7_:TuxGameObject = null;
         if(param1["old value"].toString().indexOf(".") != -1 || (param1["edit field"] as TextField).text.indexOf(".") != -1)
         {
            _loc4_ = lastEditedTuxGameObject;
            _loc5_ = lastEditedTuxGameObject;
            setValue(_loc4_.tableName,_loc5_._id,param1["key"],new Number((param1["edit field"] as TextField).text));
         }
         else
         {
            _loc6_ = lastEditedTuxGameObject;
            _loc7_ = lastEditedTuxGameObject;
            setValue(_loc6_.tableName,_loc7_._id,param1["key"],new int((param1["edit field"] as TextField).text));
         }
         var _loc2_:TuxGameObject = lastEditedTuxGameObject;
         var _loc3_:TuxGameObject = lastEditedTuxGameObject;
         LogUtils.log("new " + param1["key"] + ":" + getValue(_loc2_.tableName,_loc3_._id,param1["key"]),GameObjectValueEditor,4,"All",false,false,false);
      }
      
      private static function getValue(param1:String, param2:String, param3:String) : *
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:String = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:String = null;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc25_:Row = null;
         var _loc26_:Row = null;
         var _loc27_:Row = null;
         if(param1 == null)
         {
            LogUtils.log("TableNem is null",GameObjectValueEditor,0,"Warning",false,false,false);
            return;
         }
         if(param1.indexOf("Element_") != -1)
         {
            return;
         }
         switch(param3)
         {
            case "HP":
            case "Max HP":
               _loc10_ = param1;
               _loc11_ = param2;
               _loc12_ = ProjectManager.findTable(_loc10_);
               if(!_loc12_.getCache[_loc11_])
               {
                  _loc25_ = DCUtils.find(_loc12_.rows,"id",_loc11_);
                  if(!_loc25_)
                  {
                     LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc12_.name + "\'",_loc12_,3);
                  }
                  _loc12_.getCache[_loc11_] = _loc25_;
               }
               _loc13_ = "HitPoints";
               _loc14_ = _loc12_.getCache[_loc11_];
               if(!_loc14_.getCache[_loc13_])
               {
                  _loc14_.getCache[_loc13_] = DCUtils.find(_loc14_.getFields(),"name",_loc13_);
               }
               _loc15_ = _loc14_.getCache[_loc13_];
               return _loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value;
            case "Damage":
            case "Impulse":
            case "DamageRadius":
            case "ImpulseRadius":
            case "Timer":
            case "FiringImpulse":
            case "FiringImpulseMin":
               var _loc4_:* = param1;
               var _loc5_:* = param2;
               var _loc6_:* = ProjectManager.findTable(_loc4_);
               if(!_loc6_.getCache[_loc5_])
               {
                  _loc27_ = DCUtils.find(_loc6_.rows,"id",_loc5_);
                  if(!_loc27_)
                  {
                     LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
                  }
                  _loc6_.getCache[_loc5_] = _loc27_;
               }
               var _loc7_:* = param3;
               var _loc8_:* = _loc6_.getCache[_loc5_];
               if(!_loc8_.getCache[_loc7_])
               {
                  _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
               }
               var _loc9_:* = _loc8_.getCache[_loc7_];
               return _loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value;
            case "Density":
            case "Friction":
            case "Restitution":
               _loc16_ = param1;
               _loc17_ = param2;
               _loc18_ = ProjectManager.findTable(_loc16_);
               if(!_loc18_.getCache[_loc17_])
               {
                  _loc26_ = DCUtils.find(_loc18_.rows,"id",_loc17_);
                  if(!_loc26_)
                  {
                     LogUtils.log("No row with name: \'" + _loc17_ + "\' was found in table: \'" + _loc18_.name + "\'",_loc18_,3);
                  }
                  _loc18_.getCache[_loc17_] = _loc26_;
               }
               _loc19_ = "Physics";
               _loc20_ = _loc18_.getCache[_loc17_];
               if(!_loc20_.getCache[_loc19_])
               {
                  _loc20_.getCache[_loc19_] = DCUtils.find(_loc20_.getFields(),"name",_loc19_);
               }
               _loc21_ = _loc20_.getCache[_loc19_];
               _loc22_ = param3;
               _loc23_ = (_loc21_.overrideValue != null ? _loc21_.overrideValue : _loc21_._value) as Row;
               if(!_loc23_.getCache[_loc22_])
               {
                  _loc23_.getCache[_loc22_] = DCUtils.find(_loc23_.getFields(),"name",_loc22_);
               }
               _loc24_ = _loc23_.getCache[_loc22_];
               return _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
            default:
               LogUtils.log("Not defined as an editable parameter for fieldName:" + param3,GameObjectValueEditor,0,"Warning",false,false,false);
               return;
         }
      }
      
      private static function setValue(param1:String, param2:String, param3:String, param4:*) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:String = null;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:Row = null;
         var _loc24_:Row = null;
         var _loc25_:Row = null;
         if(param1 == null)
         {
            LogUtils.log("TableNem is null",GameObjectValueEditor,0,"Warning",false,false,false);
            return;
         }
         if(param1.indexOf("Element_") != -1)
         {
            return;
         }
         switch(param3)
         {
            case "HP":
               break;
            case "Max HP":
               _loc5_ = param1;
               _loc6_ = param2;
               _loc7_ = ProjectManager.findTable(_loc5_);
               if(!_loc7_.getCache[_loc6_])
               {
                  _loc23_ = DCUtils.find(_loc7_.rows,"id",_loc6_);
                  if(!_loc23_)
                  {
                     LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
                  }
                  _loc7_.getCache[_loc6_] = _loc23_;
               }
               _loc8_ = "HitPoints";
               _loc9_ = _loc7_.getCache[_loc6_];
               if(!_loc9_.getCache[_loc8_])
               {
                  _loc9_.getCache[_loc8_] = DCUtils.find(_loc9_.getFields(),"name",_loc8_);
               }
               _loc9_.getCache[_loc8_].value = param4;
               break;
            case "Damage":
            case "Impulse":
            case "DamageRadius":
            case "ImpulseRadius":
            case "Timer":
            case "FiringImpulse":
            case "FiringImpulseMin":
               _loc10_ = param1;
               _loc11_ = param2;
               _loc12_ = ProjectManager.findTable(_loc10_);
               if(!_loc12_.getCache[_loc11_])
               {
                  _loc24_ = DCUtils.find(_loc12_.rows,"id",_loc11_);
                  if(!_loc24_)
                  {
                     LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc12_.name + "\'",_loc12_,3);
                  }
                  _loc12_.getCache[_loc11_] = _loc24_;
               }
               _loc13_ = param3;
               _loc14_ = _loc12_.getCache[_loc11_];
               if(!_loc14_.getCache[_loc13_])
               {
                  _loc14_.getCache[_loc13_] = DCUtils.find(_loc14_.getFields(),"name",_loc13_);
               }
               _loc14_.getCache[_loc13_].value = param4;
               break;
            case "Density":
            case "Friction":
            case "Restitution":
               _loc15_ = param1;
               _loc16_ = param2;
               _loc17_ = ProjectManager.findTable(_loc15_);
               if(!_loc17_.getCache[_loc16_])
               {
                  _loc25_ = DCUtils.find(_loc17_.rows,"id",_loc16_);
                  if(!_loc25_)
                  {
                     LogUtils.log("No row with name: \'" + _loc16_ + "\' was found in table: \'" + _loc17_.name + "\'",_loc17_,3);
                  }
                  _loc17_.getCache[_loc16_] = _loc25_;
               }
               _loc18_ = "Physics";
               _loc19_ = _loc17_.getCache[_loc16_];
               if(!_loc19_.getCache[_loc18_])
               {
                  _loc19_.getCache[_loc18_] = DCUtils.find(_loc19_.getFields(),"name",_loc18_);
               }
               _loc20_ = _loc19_.getCache[_loc18_];
               _loc21_ = param3;
               _loc22_ = (_loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value) as Row;
               if(!_loc22_.getCache[_loc21_])
               {
                  _loc22_.getCache[_loc21_] = DCUtils.find(_loc22_.getFields(),"name",_loc21_);
               }
               _loc22_.getCache[_loc21_].value = param4;
               break;
            default:
               LogUtils.log("Not defined as an editable parameter for fieldName:" + param3,GameObjectValueEditor,0,"Warning",false,false,false);
         }
      }
      
      private static function buttonClickHandlerAll(param1:MouseEvent) : void
      {
         var _loc7_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:* = battleState.tuxGame.tuxWorld;
         var _loc4_:TuxGameObject = lastEditedTuxGameObject;
         var _loc5_:TuxGameObject = lastEditedTuxGameObject;
         var _loc6_:Array = _loc3_._gameObjects.findGameObjectsByTableAndId(_loc4_.tableName,_loc5_._id);
         while(fields.length > 0)
         {
            _loc2_ = fields.pop();
            if((_loc2_["edit field"] as TextField).text != String(_loc2_["old value"]))
            {
               storeToConfig(_loc2_);
               for each(_loc7_ in _loc6_)
               {
                  _loc7_.markEdited();
                  storeRealTimeValues(_loc7_ as TuxGameObject,_loc2_);
               }
            }
         }
         showGameObjectEditScreen();
      }
      
      private static function buttonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         while(fields.length > 0)
         {
            _loc2_ = fields.pop();
            if((_loc2_["edit field"] as TextField).text != String(_loc2_["old value"]))
            {
               storeToConfig(_loc2_);
               lastEditedTuxGameObject.markEdited();
               storeRealTimeValues(lastEditedTuxGameObject,_loc2_);
            }
         }
         showGameObjectEditScreen();
      }
      
      private static function addButton(param1:MovieClip) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:TextField = null;
         var _loc4_:Sprite = null;
         var _loc5_:TextField = null;
         if(!applyButton)
         {
            _loc2_ = new Sprite();
            _loc2_.graphics.lineStyle(2,10066329);
            _loc2_.graphics.beginFill(16777215);
            _loc2_.graphics.drawRect(0,0,55,25);
            _loc2_.graphics.endFill();
            _loc2_.x -= _loc2_.width - param1.width + 5;
            _loc2_.y -= _loc2_.height - param1.height + 5;
            _loc2_.useHandCursor = true;
            _loc2_.buttonMode = true;
            _loc2_.mouseChildren = false;
            _loc3_ = new TextField();
            _loc3_.autoSize = "left";
            _loc3_.text = "Apply";
            _loc3_.x += 10;
            _loc3_.y += 3;
            _loc3_.selectable = false;
            _loc2_.addChild(_loc3_);
            applyButton = _loc2_;
         }
         if(!applyAllButton)
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.lineStyle(2,10066329);
            _loc4_.graphics.beginFill(16777215);
            _loc4_.graphics.drawRect(0,0,75,25);
            _loc4_.graphics.endFill();
            _loc4_.x -= -5;
            _loc4_.y -= _loc4_.height - param1.height + 5;
            _loc4_.useHandCursor = true;
            _loc4_.buttonMode = true;
            _loc4_.mouseChildren = false;
            _loc5_ = new TextField();
            _loc5_.autoSize = "left";
            _loc5_.text = "Apply All";
            _loc5_.x += 10;
            _loc5_.y += 3;
            _loc5_.selectable = false;
            _loc4_.addChild(_loc5_);
            applyAllButton = _loc4_;
         }
         applyButton.addEventListener("click",buttonClickHandler);
         applyAllButton.addEventListener("click",buttonClickHandlerAll);
         param1.addChild(applyButton);
         param1.addChild(applyAllButton);
      }
      
      private static function createLine(param1:String, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:TextField = new TextField();
         _loc4_.autoSize = "left";
         _loc4_.selectable = false;
         _loc4_.text = param1;
         _loc4_.y = textLinePosX;
         screen.addChild(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.autoSize = "right";
         _loc5_.selectable = param3;
         _loc5_.type = "input";
         _loc5_.text = param2;
         _loc5_.x = 200;
         _loc5_.y = textLinePosX;
         screen.addChild(_loc5_);
         var _loc6_:Object = {};
         _loc6_["key"] = param1;
         _loc6_["old value"] = param2;
         _loc6_["edit field"] = _loc5_;
         fields.push(_loc6_);
         textLinePosX += _loc4_.textHeight;
      }
      
      private static function createScreen(param1:GameObject, param2:Class) : void
      {
         screen = new MovieClip();
         var _loc3_:* = param1;
         var _loc4_:TuxGameObject = _loc3_._displayObject.gameObject as TuxGameObject;
         var _loc5_:int = 400;
         var _loc6_:int = 400;
         screen.graphics.clear();
         screen.graphics.beginFill(85);
         screen.graphics.drawRect(0,0,_loc5_ + 4,_loc6_ + 4);
         screen.graphics.beginFill(16777215);
         screen.graphics.drawRect(2,2,_loc5_,_loc6_);
         screen.graphics.endFill();
         screen.x = DCGame.getStage().stageWidth / 2 - _loc5_ / 2;
         screen.y = DCGame.getStage().stageHeight / 2 - _loc6_ / 2;
         createScreenTexts(_loc4_,param2);
         addButton(screen);
      }
   }
}

