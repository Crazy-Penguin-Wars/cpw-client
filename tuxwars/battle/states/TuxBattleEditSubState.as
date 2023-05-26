package tuxwars.battle.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.GameWorld;
   import com.dchoc.gameobjects.GameDisplayObject;
   import com.dchoc.gameobjects.GameObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.actions.EditKeyboardHandler;
   import tuxwars.battle.actions.EditMouseHandler;
   import tuxwars.battle.editor.GameObjectValueEditor;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.TuxGameObject;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.states.TuxState;
   
   public class TuxBattleEditSubState extends TuxState
   {
      
      public static const SHOW_EXTRA_INFORMATION:Boolean = false;
       
      
      private var keyboardHandler:EditKeyboardHandler;
      
      private var mouseHandler:EditMouseHandler;
      
      private var stage:MovieClip;
      
      private var tuxWorld:TuxWorld;
      
      private var hud:MovieClip;
      
      private var tooltip:MovieClip;
      
      private var tooltipText:TextField;
      
      public function TuxBattleEditSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         tuxWorld = game.tuxWorld;
         keyboardHandler = new EditKeyboardHandler(this);
         mouseHandler = new EditMouseHandler(this);
         stage = DCGame.getMainMovieClip();
      }
      
      override public function enter() : void
      {
         GameWorld.getInputSystem().addInputAction(keyboardHandler);
         GameWorld.getInputSystem().addInputAction(mouseHandler);
         var _loc1_:Array = [];
         _loc1_.push("mouseUp");
         var _loc2_:TuxWorld = tuxWorld;
         _loc2_._gameObjects.addEventListenersToGameDisplayObjects(_loc1_,mouseEventHandler,true,false);
         createStateHuds();
         stage.addChild(hud);
         super.enter();
      }
      
      override public function exit() : void
      {
         GameWorld.getInputSystem().removeInputAction(keyboardHandler);
         GameWorld.getInputSystem().removeInputAction(mouseHandler);
         var _loc1_:Array = [];
         _loc1_.push("mouseUp");
         var _loc2_:TuxWorld = tuxWorld;
         _loc2_._gameObjects.removeEventListenersFromGameDisplayObjects(_loc1_,mouseEventHandler,true);
         if(stage.contains(tooltip))
         {
            stage.removeChild(tooltip);
         }
         GameObjectValueEditor.showGameObjectEditScreen(null,null);
         stage.removeChild(hud);
         super.exit();
      }
      
      private function mouseEventHandler(e:MouseEvent) : void
      {
         if(mouseHandler.isMoving)
         {
            return;
         }
         var _loc2_:TuxGameObject = GameDisplayObject(e.target).gameObject as TuxGameObject;
         var _loc3_:Class = GameDisplayObject(e.target).gameObject.objClass;
         if(e.type == "mouseUp")
         {
            if(tooltip && stage.contains(tooltip))
            {
               stage.removeChild(tooltip);
            }
            updateTooltip(_loc2_,_loc3_);
            stage.addChild(tooltip);
         }
      }
      
      private function updateTooltip(gameObj:GameObject, klazz:Class) : void
      {
         var _loc4_:PhysicsGameObject = gameObj as PhysicsGameObject;
         updateTooltipText(_loc4_);
         var w:int = tooltipText.textWidth;
         var h:int = tooltipText.textHeight;
         tooltip.graphics.clear();
         tooltip.graphics.beginFill(85);
         tooltip.graphics.drawRect(0,0,w + 4,h + 4);
         if(_loc4_.isEdited())
         {
            tooltip.graphics.beginFill(16755370);
         }
         else
         {
            tooltip.graphics.beginFill(15663086);
         }
         tooltip.graphics.drawRect(2,2,w,h);
         tooltip.graphics.endFill();
         var _loc10_:* = gameObj;
         var _loc6_:* = _loc10_._displayObject;
         var _loc11_:TuxWorld = tuxWorld;
         var _loc5_:Number = Number(_loc11_._camera.zoom);
         var x:int = (_loc6_.x - tooltip.width) * _loc5_;
         var y:int = (_loc6_.y - tooltip.height) * _loc5_;
         if(x < 0)
         {
            x = 0;
         }
         var _loc12_:DCGame = DCGame;
         if(x + tooltip.width > com.dchoc.game.DCGame._stage.stageWidth)
         {
            var _loc13_:DCGame = DCGame;
            x = Number(com.dchoc.game.DCGame._stage.stageWidth) - tooltip.width;
         }
         if(y < 0)
         {
            y = 0;
         }
         else
         {
            var _loc14_:DCGame = DCGame;
            if(y + tooltip.height > com.dchoc.game.DCGame._stage.stageHeight)
            {
               var _loc15_:DCGame = DCGame;
               y = Number(com.dchoc.game.DCGame._stage.stageHeight) - tooltip.height;
            }
         }
         tooltip.x = x;
         tooltip.y = y;
      }
      
      private function updateTooltipText(tuxGameObject:PhysicsGameObject) : void
      {
         var string:String = "";
         if(tuxGameObject.isEdited())
         {
            string += "*** Edited ***\n";
         }
         var _loc6_:* = tuxGameObject;
         string += "ID: " + _loc6_._id;
         var _loc7_:* = tuxGameObject;
         string += " UID: " + _loc7_._uniqueId;
         if(!(tuxGameObject is TerrainGameObject) && (!!_loc8_.stats ? _loc8_.stats.getStat("HP") : null) != null)
         {
            string += " HP: " + tuxGameObject.calculateHitPoints() + "/" + tuxGameObject.calculateMaxHitPoints();
         }
         if(tuxGameObject.state != null)
         {
            string += "\nState: " + tuxGameObject.state;
         }
         var _loc9_:* = tuxGameObject;
         var _loc10_:* = tuxGameObject;
         string += "\nDisplay: " + new Point(_loc9_._displayObject.x,_loc10_._displayObject.y);
         string += "\nPhysics: " + tuxGameObject.bodyLocation;
         if(!(tuxGameObject is TerrainGameObject))
         {
            string += "\nMass: " + tuxGameObject.body.mass;
            string += "\nVelocity: " + tuxGameObject.linearVelocity;
            string += "\nAngle: " + tuxGameObject.body.rotation;
         }
         var _loc2_:Vector.<Tagger> = PhysicsGameObject(tuxGameObject).tag.taggers;
         if(tuxGameObject is PhysicsGameObject && (tuxGameObject as PhysicsGameObject).tag != null && _loc2_ != null && _loc2_.length > 0)
         {
            string += "\nTaggers: ";
            for each(var tagger in _loc2_)
            {
               if(tagger.gameObject)
               {
                  var _loc11_:* = tagger.gameObject;
                  string += _loc11_._id + ", ";
               }
            }
         }
         if(tuxGameObject is PhysicsGameObject && (tuxGameObject as PhysicsGameObject).followers != null && (tuxGameObject as PhysicsGameObject).followers.length > 0)
         {
            string += "\nFollowers: ";
            for each(var fo in (tuxGameObject as PhysicsGameObject).followers)
            {
               var _loc14_:* = fo;
               string += _loc14_._id + ", ";
            }
         }
         tooltipText.text = string;
      }
      
      private function createStateHuds() : void
      {
         var tf:* = null;
         var string:* = null;
         var w:int = 0;
         var h:int = 0;
         if(!hud)
         {
            hud = new MovieClip();
            tf = new TextField();
            string = "";
            string += "Edit Mode";
            string += "\nExit (e)";
            string += "\nMouse Click Object";
            tf.text = string;
            w = tf.textWidth;
            h = tf.textHeight;
            hud.graphics.beginFill(102);
            hud.graphics.drawRect(0,0,w + 4,h + 4);
            hud.graphics.beginFill(16777215);
            hud.graphics.drawRect(2,2,w,h);
            hud.graphics.endFill();
            hud.x = 5;
            var _loc5_:DCGame = DCGame;
            hud.y = Number(com.dchoc.game.DCGame._stage.stageHeight) - h - 1;
            hud.mouseChildren = false;
            hud.mouseEnabled = false;
            hud.addChild(tf);
         }
         if(!tooltip)
         {
            tooltip = new MovieClip();
            tooltip.graphics.beginFill(2228224);
            tooltip.graphics.drawRect(0,0,80,60);
            tooltip.graphics.beginFill(16777215);
            tooltip.graphics.drawRect(2,2,76,56);
            tooltip.graphics.endFill();
            tooltipText = new TextField();
            tooltipText.autoSize = "left";
            tooltipText.text = "Placeholder";
            tooltip.addChild(tooltipText);
            tooltip.mouseChildren = false;
            tooltip.mouseEnabled = false;
         }
      }
   }
}
