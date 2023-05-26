package tuxwars.battle.editor
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getQualifiedClassName;
   import tuxwars.battle.data.PhysicsReference;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.TuxGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.states.TuxBattleState;
   
   public class GameObjectValueEditor
   {
      
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
      
      private static var stage:MovieClip;
      
      private static var screen:MovieClip;
      
      private static var applyButton:Sprite;
      
      private static var applyAllButton:Sprite;
      
      private static var showGameObjectScreen:Boolean = false;
      
      private static var battleState:TuxBattleState;
      
      private static var lastEditedKlazz:Class;
      
      private static var lastEditedTuxGameObject:TuxGameObject;
      
      private static var fields:Array;
      
      private static var textLinePosX:int;
       
      
      public function GameObjectValueEditor()
      {
         super();
         throw new Error("GameObjectValueEditor is a static class!");
      }
      
      public static function showGameObjectEditScreen(gameObj:GameObject = null, klazz:Class = null) : void
      {
         showGameObjectScreen = !showGameObjectScreen;
         if(isShown() && gameObj != null && klazz != null)
         {
            createScreen(gameObj,klazz);
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
            if(stage != null && stage.contains(screen))
            {
               stage.removeChild(screen);
            }
         }
      }
      
      public static function isShown() : Boolean
      {
         return showGameObjectScreen;
      }
      
      public static function setBattleState(state:TuxBattleState) : void
      {
         battleState = state;
      }
      
      private static function createScreenTexts(tuxGameObject:TuxGameObject, klazz:Class) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         fields = [];
         var _loc7_:String = getQualifiedClassName(klazz);
         var _loc6_:TextField = new TextField();
         _loc6_.autoSize = "left";
         var _loc8_:* = tuxGameObject;
         _loc6_.text = "ID: " + _loc8_._id + " " + klazz;
         _loc6_.x = screen.width / 2 - _loc6_.textWidth / 2;
         _loc6_.selectable = false;
         screen.addChild(_loc6_);
         textLinePosX = _loc6_.textHeight + 15;
         lastEditedKlazz = klazz;
         lastEditedTuxGameObject = tuxGameObject;
         switch(_loc7_)
         {
            case getQualifiedClassName(Missile):
               _loc4_ = tuxGameObject as Missile;
               break;
            case getQualifiedClassName(PlayerGameObject):
               _loc3_ = tuxGameObject as PlayerGameObject;
               break;
            case getQualifiedClassName(LevelGameObject):
               _loc5_ = tuxGameObject as LevelGameObject;
               createLine("Toughness",new String(_loc5_.getToughness()));
               break;
            case getQualifiedClassName(PhysicsGameObject):
            default:
               LogUtils.log("No configured class of game object",GameObjectValueEditor,2,"All",false,false,false);
         }
         if(!(tuxGameObject is TerrainGameObject))
         {
            createLine("HP",new String(tuxGameObject.calculateHitPoints()),tuxGameObject is PlayerGameObject);
            createLine("Max HP",new String(tuxGameObject.calculateMaxHitPoints()),tuxGameObject is PlayerGameObject);
         }
      }
      
      private static function storeRealTimeValues(gameObject:TuxGameObject, obj:Object) : void
      {
         var maxHP:int = 0;
         var newHP:int = 0;
         var statOne:* = null;
         var baseName:* = null;
         switch(obj["key"])
         {
            case "HP":
               if(gameObject._hasHPs)
               {
                  var _loc9_:String = "HP";
                  var _loc7_:* = gameObject;
                  (!!_loc7_.stats ? _loc7_.stats.getStat(_loc9_) : null).clearTemp();
                  maxHP = gameObject.calculateMaxHitPoints();
                  newHP = int((obj["edit field"] as TextField).text);
                  break;
               }
               break;
            case "Max HP":
               if(gameObject._hasHPs)
               {
                  var _loc8_:* = gameObject;
                  statOne = !!_loc8_.stats ? _loc8_.stats.getStat("HP") : null;
                  baseName = statOne.getBaseModifierName();
                  statOne.getModifier(baseName).value = int((obj["edit field"] as TextField).text);
                  break;
               }
               break;
            case "Friction":
            case "Restitution":
            case "Density":
               updateRealtimePhysicsReference(gameObject);
               break;
            case "FiringImpulse":
            case "FiringImpulseMin":
               break;
            case "Toughness":
               (gameObject as LevelGameObject).setToughness(int((obj["edit field"] as TextField).text));
         }
      }
      
      private static function updateRealtimePhysicsReference(gameObject:TuxGameObject) : void
      {
         var _loc4_:* = gameObject;
         var _loc10_:* = _loc4_._tableName;
         var _loc5_:ProjectManager = ProjectManager;
         var _loc6_:* = gameObject;
         var _loc11_:* = _loc6_._id;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc10_);
         if(!_loc7_._cache[_loc11_])
         {
            var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc7_.rows,"id",_loc11_);
            if(!_loc12_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
            }
            _loc7_._cache[_loc11_] = _loc12_;
         }
         var row:Row = _loc7_._cache[_loc11_];
         var _loc8_:* = row;
         §§push(§§findproperty(PhysicsReference));
         if(!_loc8_._cache["Physics"])
         {
            _loc8_._cache["Physics"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Physics");
         }
         var _loc9_:* = _loc8_._cache["Physics"];
         var newPhysicsReference:PhysicsReference = new §§pop().PhysicsReference(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
      }
      
      private static function storeToConfig(obj:Object) : void
      {
         if(obj["old value"].toString().indexOf(".") != -1 || (obj["edit field"] as TextField).text.indexOf(".") != -1)
         {
            var _loc2_:TuxGameObject = lastEditedTuxGameObject;
            var _loc3_:TuxGameObject = lastEditedTuxGameObject;
            setValue(_loc2_._tableName,_loc3_._id,obj["key"],new Number((obj["edit field"] as TextField).text));
         }
         else
         {
            var _loc4_:TuxGameObject = lastEditedTuxGameObject;
            var _loc5_:TuxGameObject = lastEditedTuxGameObject;
            setValue(_loc4_._tableName,_loc5_._id,obj["key"],new int((obj["edit field"] as TextField).text));
         }
         var _loc6_:TuxGameObject = lastEditedTuxGameObject;
         var _loc7_:TuxGameObject = lastEditedTuxGameObject;
         LogUtils.log("new " + obj["key"] + ":" + getValue(_loc6_._tableName,_loc7_._id,obj["key"]),GameObjectValueEditor,4,"All",false,false,false);
      }
      
      private static function getValue(tableName:String, id:String, fieldName:String) : *
      {
         if(tableName == null)
         {
            LogUtils.log("TableNem is null",GameObjectValueEditor,0,"Warning",false,false,false);
            return;
         }
         if(tableName.indexOf("Element_") != -1)
         {
            return;
         }
         switch(fieldName)
         {
            case "HP":
            case "Max HP":
               var _loc18_:* = tableName;
               var _loc4_:ProjectManager = ProjectManager;
               var _loc19_:* = id;
               var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc18_);
               if(!_loc5_._cache[_loc19_])
               {
                  var _loc20_:Row = com.dchoc.utils.DCUtils.find(_loc5_.rows,"id",_loc19_);
                  if(!_loc20_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc19_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
                  }
                  _loc5_._cache[_loc19_] = _loc20_;
               }
               var _loc6_:* = _loc5_._cache[_loc19_];
               if(!_loc6_._cache["HitPoints"])
               {
                  _loc6_._cache["HitPoints"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","HitPoints");
               }
               var _loc7_:* = _loc6_._cache["HitPoints"];
               return _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
            case "Damage":
            case "Impulse":
            case "DamageRadius":
            case "ImpulseRadius":
            case "Timer":
            case "FiringImpulse":
               break;
            case "FiringImpulseMin":
               break;
            case "Density":
            case "Friction":
            case "Restitution":
               var _loc26_:* = tableName;
               var _loc12_:ProjectManager = ProjectManager;
               var _loc27_:* = id;
               var _loc13_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc26_);
               if(!_loc13_._cache[_loc27_])
               {
                  var _loc28_:Row = com.dchoc.utils.DCUtils.find(_loc13_.rows,"id",_loc27_);
                  if(!_loc28_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc27_ + "\' was found in table: \'" + _loc13_.name + "\'",_loc13_,3);
                  }
                  _loc13_._cache[_loc27_] = _loc28_;
               }
               var _loc14_:* = _loc13_._cache[_loc27_];
               if(!_loc14_._cache["Physics"])
               {
                  _loc14_._cache["Physics"] = com.dchoc.utils.DCUtils.find(_loc14_._fields,"name","Physics");
               }
               var _loc15_:* = _loc14_._cache["Physics"];
               var _loc30_:* = fieldName;
               var _loc16_:* = (_loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value) as Row;
               if(!_loc16_._cache[_loc30_])
               {
                  _loc16_._cache[_loc30_] = com.dchoc.utils.DCUtils.find(_loc16_._fields,"name",_loc30_);
               }
               var _loc17_:* = _loc16_._cache[_loc30_];
               return _loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value;
            default:
               LogUtils.log("Not defined as an editable parameter for fieldName:" + fieldName,GameObjectValueEditor,0,"Warning",false,false,false);
               return;
         }
         var _loc22_:* = tableName;
         var _loc8_:ProjectManager = ProjectManager;
         var _loc23_:* = id;
         var _loc9_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc22_);
         if(!_loc9_._cache[_loc23_])
         {
            var _loc24_:Row = com.dchoc.utils.DCUtils.find(_loc9_.rows,"id",_loc23_);
            if(!_loc24_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc23_ + "\' was found in table: \'" + _loc9_.name + "\'",_loc9_,3);
            }
            _loc9_._cache[_loc23_] = _loc24_;
         }
         var _loc25_:* = fieldName;
         var _loc10_:* = _loc9_._cache[_loc23_];
         if(!_loc10_._cache[_loc25_])
         {
            _loc10_._cache[_loc25_] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name",_loc25_);
         }
         var _loc11_:* = _loc10_._cache[_loc25_];
         return _loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value;
      }
      
      private static function setValue(tableName:String, id:String, fieldName:String, value:*) : void
      {
         if(tableName == null)
         {
            LogUtils.log("TableNem is null",GameObjectValueEditor,0,"Warning",false,false,false);
            return;
         }
         if(tableName.indexOf("Element_") != -1)
         {
            return;
         }
         switch(fieldName)
         {
            case "HP":
               break;
            case "Max HP":
               var _loc16_:* = tableName;
               var _loc5_:ProjectManager = ProjectManager;
               var _loc17_:* = id;
               var _loc6_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc16_);
               if(!_loc6_._cache[_loc17_])
               {
                  var _loc18_:Row = com.dchoc.utils.DCUtils.find(_loc6_.rows,"id",_loc17_);
                  if(!_loc18_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc17_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
                  }
                  _loc6_._cache[_loc17_] = _loc18_;
               }
               var _loc7_:* = _loc6_._cache[_loc17_];
               if(!_loc7_._cache["HitPoints"])
               {
                  _loc7_._cache["HitPoints"] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name","HitPoints");
               }
               _loc7_._cache["HitPoints"].value = value;
               break;
            case "Damage":
            case "Impulse":
            case "DamageRadius":
            case "ImpulseRadius":
            case "Timer":
            case "FiringImpulse":
            case "FiringImpulseMin":
               var _loc20_:* = tableName;
               var _loc8_:ProjectManager = ProjectManager;
               var _loc21_:* = id;
               var _loc9_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc20_);
               if(!_loc9_._cache[_loc21_])
               {
                  var _loc22_:Row = com.dchoc.utils.DCUtils.find(_loc9_.rows,"id",_loc21_);
                  if(!_loc22_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc21_ + "\' was found in table: \'" + _loc9_.name + "\'",_loc9_,3);
                  }
                  _loc9_._cache[_loc21_] = _loc22_;
               }
               var _loc23_:* = fieldName;
               var _loc10_:* = _loc9_._cache[_loc21_];
               if(!_loc10_._cache[_loc23_])
               {
                  _loc10_._cache[_loc23_] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name",_loc23_);
               }
               _loc10_._cache[_loc23_].value = value;
               break;
            case "Density":
            case "Friction":
            case "Restitution":
               var _loc24_:* = tableName;
               var _loc11_:ProjectManager = ProjectManager;
               var _loc25_:* = id;
               var _loc12_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc24_);
               if(!_loc12_._cache[_loc25_])
               {
                  var _loc26_:Row = com.dchoc.utils.DCUtils.find(_loc12_.rows,"id",_loc25_);
                  if(!_loc26_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc25_ + "\' was found in table: \'" + _loc12_.name + "\'",_loc12_,3);
                  }
                  _loc12_._cache[_loc25_] = _loc26_;
               }
               var _loc13_:* = _loc12_._cache[_loc25_];
               if(!_loc13_._cache["Physics"])
               {
                  _loc13_._cache["Physics"] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name","Physics");
               }
               var _loc14_:* = _loc13_._cache["Physics"];
               var _loc28_:* = fieldName;
               var _loc15_:* = (_loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value) as Row;
               if(!_loc15_._cache[_loc28_])
               {
                  _loc15_._cache[_loc28_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc28_);
               }
               _loc15_._cache[_loc28_].value = value;
               break;
            default:
               LogUtils.log("Not defined as an editable parameter for fieldName:" + fieldName,GameObjectValueEditor,0,"Warning",false,false,false);
         }
      }
      
      private static function buttonClickHandlerAll(event:MouseEvent) : void
      {
         var obj:* = null;
         var _loc5_:* = battleState.tuxGame.tuxWorld;
         var _loc6_:TuxGameObject = lastEditedTuxGameObject;
         var _loc7_:TuxGameObject = lastEditedTuxGameObject;
         var gameObjects:Array = _loc5_._gameObjects.findGameObjectsByTableAndId(_loc6_._tableName,_loc7_._id);
         while(fields.length > 0)
         {
            obj = fields.pop();
            if((obj["edit field"] as TextField).text != String(obj["old value"]))
            {
               storeToConfig(obj);
               for each(var gameObj in gameObjects)
               {
                  gameObj.markEdited();
                  storeRealTimeValues(gameObj as TuxGameObject,obj);
               }
            }
         }
         showGameObjectEditScreen();
      }
      
      private static function buttonClickHandler(event:MouseEvent) : void
      {
         var obj:* = null;
         while(fields.length > 0)
         {
            obj = fields.pop();
            if((obj["edit field"] as TextField).text != String(obj["old value"]))
            {
               storeToConfig(obj);
               lastEditedTuxGameObject.markEdited();
               storeRealTimeValues(lastEditedTuxGameObject,obj);
            }
         }
         showGameObjectEditScreen();
      }
      
      private static function addButton(screen:MovieClip) : void
      {
         var button:* = null;
         var btf:* = null;
         var buttonAll:* = null;
         var btfAll:* = null;
         if(!applyButton)
         {
            button = new Sprite();
            button.graphics.lineStyle(2,10066329);
            button.graphics.beginFill(16777215);
            button.graphics.drawRect(0,0,55,25);
            button.graphics.endFill();
            button.x -= button.width - screen.width + 5;
            button.y -= button.height - screen.height + 5;
            button.useHandCursor = true;
            button.buttonMode = true;
            button.mouseChildren = false;
            btf = new TextField();
            btf.autoSize = "left";
            btf.text = "Apply";
            btf.x += 10;
            btf.y += 3;
            btf.selectable = false;
            button.addChild(btf);
            applyButton = button;
         }
         if(!applyAllButton)
         {
            buttonAll = new Sprite();
            buttonAll.graphics.lineStyle(2,10066329);
            buttonAll.graphics.beginFill(16777215);
            buttonAll.graphics.drawRect(0,0,75,25);
            buttonAll.graphics.endFill();
            buttonAll.x -= -5;
            buttonAll.y -= buttonAll.height - screen.height + 5;
            buttonAll.useHandCursor = true;
            buttonAll.buttonMode = true;
            buttonAll.mouseChildren = false;
            btfAll = new TextField();
            btfAll.autoSize = "left";
            btfAll.text = "Apply All";
            btfAll.x += 10;
            btfAll.y += 3;
            btfAll.selectable = false;
            buttonAll.addChild(btfAll);
            applyAllButton = buttonAll;
         }
         applyButton.addEventListener("click",buttonClickHandler);
         applyAllButton.addEventListener("click",buttonClickHandlerAll);
         screen.addChild(applyButton);
         screen.addChild(applyAllButton);
      }
      
      private static function createLine(fieldName:String, value:String, editable:Boolean = true) : void
      {
         var _loc4_:TextField = new TextField();
         _loc4_.autoSize = "left";
         _loc4_.selectable = false;
         _loc4_.text = fieldName;
         _loc4_.y = textLinePosX;
         screen.addChild(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.autoSize = "right";
         _loc5_.selectable = editable;
         _loc5_.type = "input";
         _loc5_.text = value;
         _loc5_.x = 200;
         _loc5_.y = textLinePosX;
         screen.addChild(_loc5_);
         var _loc6_:Object = {};
         _loc6_["key"] = fieldName;
         _loc6_["old value"] = value;
         _loc6_["edit field"] = _loc5_;
         fields.push(_loc6_);
         textLinePosX += _loc4_.textHeight;
      }
      
      private static function createScreen(gameObj:GameObject, klazz:Class) : void
      {
         screen = new MovieClip();
         var _loc6_:* = gameObj;
         var _loc4_:TuxGameObject = _loc6_._displayObject.gameObject as TuxGameObject;
         screen.graphics.clear();
         screen.graphics.beginFill(85);
         screen.graphics.drawRect(0,0,400 + 4,400 + 4);
         screen.graphics.beginFill(16777215);
         screen.graphics.drawRect(2,2,400,400);
         screen.graphics.endFill();
         var _loc7_:DCGame = DCGame;
         screen.x = Number(com.dchoc.game.DCGame._stage.stageWidth) / 2 - 400 / 2;
         var _loc8_:DCGame = DCGame;
         screen.y = Number(com.dchoc.game.DCGame._stage.stageHeight) / 2 - 400 / 2;
         createScreenTexts(_loc4_,klazz);
         addButton(screen);
      }
   }
}
