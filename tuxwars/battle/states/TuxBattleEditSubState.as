package tuxwars.battle.states
{
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.actions.*;
   import tuxwars.battle.editor.*;
   import tuxwars.battle.gameobjects.*;
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
      
      public function TuxBattleEditSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         this.tuxWorld = param1.tuxWorld;
         this.keyboardHandler = new EditKeyboardHandler(this);
         this.mouseHandler = new EditMouseHandler(this);
         this.stage = DCGame.getMainMovieClip();
      }
      
      override public function enter() : void
      {
         GameWorld.getInputSystem().addInputAction(this.keyboardHandler);
         GameWorld.getInputSystem().addInputAction(this.mouseHandler);
         var _loc1_:Array = [];
         _loc1_.push("mouseUp");
         var _loc2_:TuxWorld = this.tuxWorld;
         _loc2_._gameObjects.addEventListenersToGameDisplayObjects(_loc1_,this.mouseEventHandler,true,false);
         this.createStateHuds();
         this.stage.addChild(this.hud);
         super.enter();
      }
      
      override public function exit() : void
      {
         GameWorld.getInputSystem().removeInputAction(this.keyboardHandler);
         GameWorld.getInputSystem().removeInputAction(this.mouseHandler);
         var _loc1_:Array = [];
         _loc1_.push("mouseUp");
         var _loc2_:TuxWorld = this.tuxWorld;
         _loc2_._gameObjects.removeEventListenersFromGameDisplayObjects(_loc1_,this.mouseEventHandler,true);
         if(this.stage.contains(this.tooltip))
         {
            this.stage.removeChild(this.tooltip);
         }
         GameObjectValueEditor.showGameObjectEditScreen(null,null);
         this.stage.removeChild(this.hud);
         super.exit();
      }
      
      private function mouseEventHandler(param1:MouseEvent) : void
      {
         if(this.mouseHandler.isMoving)
         {
            return;
         }
         var _loc2_:TuxGameObject = GameDisplayObject(param1.target).gameObject as TuxGameObject;
         var _loc3_:Class = GameDisplayObject(param1.target).gameObject.objClass;
         if(param1.type == "mouseUp")
         {
            if(Boolean(this.tooltip) && Boolean(this.stage.contains(this.tooltip)))
            {
               this.stage.removeChild(this.tooltip);
            }
            this.updateTooltip(_loc2_,_loc3_);
            this.stage.addChild(this.tooltip);
         }
      }
      
      private function updateTooltip(param1:GameObject, param2:Class) : void
      {
         var _loc3_:PhysicsGameObject = param1 as PhysicsGameObject;
         this.updateTooltipText(_loc3_);
         var _loc4_:int = int(this.tooltipText.textWidth);
         var _loc5_:int = int(this.tooltipText.textHeight);
         this.tooltip.graphics.clear();
         this.tooltip.graphics.beginFill(85);
         this.tooltip.graphics.drawRect(0,0,_loc4_ + 4,_loc5_ + 4);
         if(_loc3_.isEdited())
         {
            this.tooltip.graphics.beginFill(16755370);
         }
         else
         {
            this.tooltip.graphics.beginFill(15663086);
         }
         this.tooltip.graphics.drawRect(2,2,_loc4_,_loc5_);
         this.tooltip.graphics.endFill();
         var _loc6_:* = param1;
         var _loc7_:* = _loc6_._displayObject;
         var _loc8_:TuxWorld = this.tuxWorld;
         var _loc9_:Number = Number(_loc8_._camera.zoom);
         var _loc10_:int = (_loc7_.x - this.tooltip.width) * _loc9_;
         var _loc11_:int = (_loc7_.y - this.tooltip.height) * _loc9_;
         if(_loc10_ < 0)
         {
            _loc10_ = 0;
         }
         if(_loc10_ + this.tooltip.width > DCGame.getStage().stageWidth)
         {
            _loc10_ = DCGame.getStage().stageWidth - this.tooltip.width;
         }
         if(_loc11_ < 0)
         {
            _loc11_ = 0;
         }
         else if(_loc11_ + this.tooltip.height > DCGame.getStage().stageHeight)
         {
            _loc11_ = DCGame.getStage().stageHeight - this.tooltip.height;
         }
         this.tooltip.x = _loc10_;
         this.tooltip.y = _loc11_;
      }
      
      private function updateTooltipText(param1:PhysicsGameObject) : void
      {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc2_:* = "";
         if(param1.isEdited())
         {
            _loc2_ += "*** Edited ***\n";
         }
         var _loc3_:* = param1;
         _loc2_ += "ID: " + _loc3_._id;
         var _loc4_:* = param1;
         _loc2_ += " UID: " + _loc4_._uniqueId;
         if(!(param1 is TerrainGameObject) && (!!_loc8_.stats ? _loc8_.stats.getStat(_loc17_) : null) != null)
         {
            _loc2_ += " HP: " + param1.calculateHitPoints() + "/" + param1.calculateMaxHitPoints();
         }
         if(param1.state != null)
         {
            _loc2_ += "\nState: " + param1.state;
         }
         var _loc5_:* = param1;
         var _loc6_:* = param1;
         _loc2_ += "\nDisplay: " + new Point(_loc5_._displayObject.x,_loc6_._displayObject.y);
         _loc2_ += "\nPhysics: " + param1.bodyLocation;
         if(!(param1 is TerrainGameObject))
         {
            _loc2_ += "\nMass: " + param1.body.mass;
            _loc2_ += "\nVelocity: " + param1.linearVelocity;
            _loc2_ += "\nAngle: " + param1.body.rotation;
         }
         var _loc7_:Vector.<Tagger> = PhysicsGameObject(param1).tag.taggers;
         if(param1 is PhysicsGameObject && (param1 as PhysicsGameObject).tag != null && _loc7_ != null && _loc7_.length > 0)
         {
            _loc2_ += "\nTaggers: ";
            for each(_loc8_ in _loc7_)
            {
               if(_loc8_.gameObject)
               {
                  _loc9_ = _loc8_.gameObject;
                  _loc2_ += _loc9_._id + ", ";
               }
            }
         }
         if(param1 is PhysicsGameObject && (param1 as PhysicsGameObject).followers != null && (param1 as PhysicsGameObject).followers.length > 0)
         {
            _loc2_ += "\nFollowers: ";
            for each(_loc10_ in (param1 as PhysicsGameObject).followers)
            {
               _loc11_ = _loc10_;
               _loc2_ += _loc11_._id + ", ";
            }
         }
         this.tooltipText.text = _loc2_;
      }
      
      private function createStateHuds() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this.hud)
         {
            this.hud = new MovieClip();
            _loc1_ = new TextField();
            _loc2_ = "";
            _loc2_ += "Edit Mode";
            _loc2_ += "\nExit (e)";
            _loc2_ += "\nMouse Click Object";
            _loc1_.text = _loc2_;
            _loc3_ = _loc1_.textWidth;
            _loc4_ = _loc1_.textHeight;
            this.hud.graphics.beginFill(102);
            this.hud.graphics.drawRect(0,0,_loc3_ + 4,_loc4_ + 4);
            this.hud.graphics.beginFill(16777215);
            this.hud.graphics.drawRect(2,2,_loc3_,_loc4_);
            this.hud.graphics.endFill();
            this.hud.x = 5;
            this.hud.y = DCGame.getStage().stageHeight - _loc4_ - 1;
            this.hud.mouseChildren = false;
            this.hud.mouseEnabled = false;
            this.hud.addChild(_loc1_);
         }
         if(!this.tooltip)
         {
            this.tooltip = new MovieClip();
            this.tooltip.graphics.beginFill(2228224);
            this.tooltip.graphics.drawRect(0,0,80,60);
            this.tooltip.graphics.beginFill(16777215);
            this.tooltip.graphics.drawRect(2,2,76,56);
            this.tooltip.graphics.endFill();
            this.tooltipText = new TextField();
            this.tooltipText.autoSize = "left";
            this.tooltipText.text = "Placeholder";
            this.tooltip.addChild(this.tooltipText);
            this.tooltip.mouseChildren = false;
            this.tooltip.mouseEnabled = false;
         }
      }
   }
}

