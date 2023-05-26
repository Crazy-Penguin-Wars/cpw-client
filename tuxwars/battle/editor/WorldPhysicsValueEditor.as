package tuxwars.battle.editor
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import nape.geom.Vec2;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.states.TuxBattleState;
   import tuxwars.battle.world.PhysicsWorld;
   import tuxwars.battle.world.TuxWorld;
   
   public class WorldPhysicsValueEditor
   {
      
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
      
      private static var screen:MovieClip;
      
      private static var okButton:Sprite;
      
      private static var battleState:TuxBattleState;
      
      private static var tuxWorld:TuxWorld;
      
      private static var physicsWorld:PhysicsWorld;
      
      private static var editFields:Array;
       
      
      public function WorldPhysicsValueEditor()
      {
         super();
         throw new Error("WorldPhysicsValueEditor is a static class!");
      }
      
      public static function setBattleState(state:TuxBattleState) : void
      {
         battleState = state;
         tuxWorld = battleState.tuxGame.tuxWorld;
         physicsWorld = battleState.tuxGame.tuxWorld.physicsWorld;
      }
      
      public static function isShown() : Boolean
      {
         return showWorldPhysics;
      }
      
      public static function showWorldPhysicsEditScreen() : void
      {
         var rect:* = null;
         var tf:* = null;
         var players:* = null;
         showWorldPhysics = !showWorldPhysics;
         if(isShown())
         {
            screen = new MovieClip();
            var _loc6_:DCGame = DCGame;
            screen.x = Number(com.dchoc.game.DCGame._stage.stageWidth) / 2;
            var _loc7_:DCGame = DCGame;
            screen.y = Number(com.dchoc.game.DCGame._stage.stageHeight) / 2;
            rect = addBackground(0,0,400,180,3,136,16777215,screen);
            tf = addTextField("World Physics Values (edit numbers, press ok)","center",screen,rect.height / 2 - 5);
            tf.x += rect.width / 2;
            editFields = [];
            addTextField("Gravity","left",screen,rect.height / 2 - 40,WorldPhysics.getGravity());
            addTextField("WalkSpeed","left",screen,rect.height / 2 - 60,WorldPhysics.getWalkSpeed());
            addTextField("JumpPower","left",screen,rect.height / 2 - 80,WorldPhysics.getJumpPower());
            addTextField("FallDamageMultiplier","left",screen,rect.height / 2 - 100,WorldPhysics.getFallDamageMultiplier());
            addTextField("FallDamageEffectStartValue","left",screen,rect.height / 2 - 120,WorldPhysics.getFallDamageEffectStartValue());
            addTextField("FallImpulseThreshold","left",screen,rect.height / 2 - 140,WorldPhysics.getFallImpulseThreshold());
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
            players = tuxWorld.players;
            for each(var player in players)
            {
               player.playerStats.walkSpeed = WorldPhysics.getWalkSpeed();
               player.playerStats.jumpPower = WorldPhysics.getJumpPower();
            }
         }
      }
      
      private static function storeLine(line:String, klazz:Class) : void
      {
         var s1:String = TextField(editFields[line]["field"]).text;
         setValue(line,new klazz(s1));
         var s2:String = editFields[line]["old_value"] as String;
         if(s1 != s2)
         {
            LogUtils.log(line + " new value: " + s1 + " (old value:" + s2 + ")",WorldPhysicsValueEditor,4,"All",false,false,false);
         }
      }
      
      private static function addBackground(x:int, y:int, w:int, h:int, borderThickness:int, borderColor:int, fillColor:int, screen:MovieClip) : Sprite
      {
         var rect:Sprite = new Sprite();
         rect.graphics.lineStyle(borderThickness,borderColor);
         rect.graphics.beginFill(fillColor);
         rect.graphics.drawRect(x,y,w,h);
         rect.graphics.endFill();
         rect.x -= rect.width / 2;
         rect.y -= rect.height / 2;
         screen.addChild(rect);
         return rect;
      }
      
      private static function addButton(screen:MovieClip) : void
      {
         var button:Sprite = new Sprite();
         button.graphics.lineStyle(2,10066329);
         button.graphics.beginFill(16777215);
         button.graphics.drawRect(0,0,45,25);
         button.graphics.endFill();
         button.x -= button.width / 2 - 160;
         button.y -= button.height / 2 - 50;
         button.useHandCursor = true;
         button.buttonMode = true;
         button.mouseChildren = false;
         var btf:TextField = new TextField();
         btf.autoSize = "left";
         btf.text = "OK";
         btf.x += 10;
         btf.y += 3;
         btf.selectable = false;
         button.addChild(btf);
         button.addEventListener("click",buttonClickHandler);
         okButton = button;
         screen.addChild(button);
      }
      
      private static function buttonClickHandler(event:MouseEvent) : void
      {
         showWorldPhysicsEditScreen();
      }
      
      private static function addTextField(text:String, align:String, screen:MovieClip, y:int, value:* = null) : TextField
      {
         var obj:* = null;
         var vtf:* = null;
         var tf:TextField = new TextField();
         tf.text = text;
         tf.autoSize = align;
         tf.x -= tf.width;
         tf.y -= y;
         tf.selectable = false;
         screen.addChild(tf);
         if(value != null)
         {
            obj = {};
            vtf = new TextField();
            vtf.text = "" + value;
            vtf.autoSize = "right";
            vtf.y -= y;
            vtf.selectable = true;
            vtf.doubleClickEnabled = true;
            vtf.type = "input";
            obj["old_value"] = "" + value;
            obj["field"] = vtf;
            editFields[text] = obj;
            screen.addChild(vtf);
         }
         return tf;
      }
      
      private static function getValue(fieldName:String) : *
      {
         var _loc4_:* = fieldName;
         var _loc2_:* = getRow();
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc3_:* = _loc2_._cache[_loc4_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      private static function setValue(fieldName:String, value:*) : void
      {
         var _loc4_:* = fieldName;
         var _loc3_:* = getRow();
         if(!_loc3_._cache[_loc4_])
         {
            _loc3_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc4_);
         }
         _loc3_._cache[_loc4_].value = value;
      }
      
      private static function getRow() : Row
      {
         var _loc1_:ProjectManager = ProjectManager;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("WorldPhysic");
         if(!_loc2_._cache["Default"])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Default");
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache["Default"] = _loc5_;
         }
         return _loc2_._cache["Default"];
      }
   }
}
