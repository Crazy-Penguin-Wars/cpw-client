package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.tournament.Tournament;
   import tuxwars.tournament.TournamentPlayer;
   
   public class LeagueSlot implements IResourceLoaderURL
   {
      private static const SLOT_LEAST:String = "Slot_Least";
      
      private static const SLOT_DEFAULT:String = "Slot_Default";
      
      private static const SLOT_RED:String = "Slot_Red";
      
      private static const SLOT_TOP:String = "Slot_Top";
      
      private static const SLOT_GREEN:String = "Slot_Green";
      
      private static const SLOT_OPTION_ACTIVE:String = "_Active";
      
      private static const TEXT_POSITION:String = "Text_Position";
      
      private static const TAG:String = "Tag";
      
      private static const TEXT_NAME:String = "Text_Name";
      
      private static const TEXT_GAMES:String = "Text_Games";
      
      private static const TEXT_SCORE_VALUE:String = "Text_Points";
      
      private static const TEXT_POINTS_VALUE:String = "Text_Points_Value";
      
      private static const PICTURE_CONTAINER:String = "Container_Profile_Picture";
      
      private var _player:TournamentPlayer;
      
      private var _position:int;
      
      private var _design:MovieClip;
      
      private var _slotGraphics:MovieClip;
      
      private var loader:URLResourceLoader;
      
      public function LeagueSlot(param1:MovieClip)
      {
         super();
         this._design = param1;
         this.hideSlots();
      }
      
      private function hideSlots() : void
      {
         (this._design.getChildByName("Slot_Least") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Least" + "_Active") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Default") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Default" + "_Active") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Red") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Red" + "_Active") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Top") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Top" + "_Active") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Green") as MovieClip).visible = false;
         (this._design.getChildByName("Slot_Green" + "_Active") as MovieClip).visible = false;
      }
      
      public function setPlayer(param1:TournamentPlayer, param2:Tournament, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         this._player = param1;
         var _loc7_:* = param2.league.findMyIndex() == param3;
         this.hideSlots();
         if(param3 == 0 && param1.rank == 1)
         {
            if(param2.league.promotedPlayers > 0)
            {
               _loc4_ = "Slot_Top";
            }
            else
            {
               _loc4_ = "Slot_Default";
            }
         }
         else if(param1.rank <= param2.league.promotedPlayers)
         {
            _loc4_ = "Slot_Green";
         }
         else if(param2.league.relegatedPlayers > 0 && param1.rank > param2.league.getPlayers().length - param2.league.relegatedPlayers)
         {
            if(param3 == param2.league.getPlayers().length - 1)
            {
               _loc4_ = "Slot_Least";
            }
            else
            {
               _loc4_ = "Slot_Red";
            }
         }
         else
         {
            _loc4_ = "Slot_Default";
         }
         if(_loc7_)
         {
            _loc4_ += "_Active";
         }
         this._slotGraphics = this._design.getChildByName(_loc4_) as MovieClip;
         this._slotGraphics.visible = true;
         if(this.getResourceUrl())
         {
            this.loader = ResourceLoaderURL.getInstance().load(this,null);
            this.getTargetMovieClip().visible = true;
         }
         else
         {
            this.getTargetMovieClip().visible = false;
         }
         var _loc8_:MovieClip = this._slotGraphics.getChildByName("Tag") as MovieClip;
         if(_loc7_)
         {
            if(this._player.previous_rank < this._player.rank)
            {
               (_loc8_.getChildByName("Tag_Up") as MovieClip).visible = false;
               (_loc8_.getChildByName("Tag_Stay") as MovieClip).visible = false;
               _loc5_ = _loc8_.getChildByName("Tag_Down") as MovieClip;
               _loc5_.visible = true;
               _loc6_ = MovieClip(_loc5_).getChildByName("Text") as TextField;
               _loc6_.text = "" + (this._player.rank - this._player.previous_rank);
            }
            else if(this._player.previous_rank > this._player.rank)
            {
               (_loc8_.getChildByName("Tag_Down") as MovieClip).visible = false;
               (_loc8_.getChildByName("Tag_Stay") as MovieClip).visible = false;
               _loc5_ = _loc8_.getChildByName("Tag_Up") as MovieClip;
               _loc5_.visible = true;
               _loc6_ = MovieClip(_loc5_).getChildByName("Text") as TextField;
               _loc6_.text = "" + (this._player.previous_rank - this._player.rank);
            }
            else
            {
               (_loc8_.getChildByName("Tag_Down") as MovieClip).visible = false;
               (_loc8_.getChildByName("Tag_Up") as MovieClip).visible = false;
               (_loc8_.getChildByName("Tag_Stay") as MovieClip).visible = true;
            }
         }
         else
         {
            (_loc8_.getChildByName("Tag_Down") as MovieClip).visible = false;
            (_loc8_.getChildByName("Tag_Up") as MovieClip).visible = false;
            (_loc8_.getChildByName("Tag_Stay") as MovieClip).visible = false;
         }
         var _loc9_:TextField = this._slotGraphics.getChildByName("Text_Position") as TextField;
         _loc9_.text = "" + this._player.rank;
         _loc9_ = this._slotGraphics.getChildByName("Text_Points") as TextField;
         _loc9_.text = this._player.score;
         _loc9_ = this._slotGraphics.getChildByName("Text_Points_Value") as TextField;
         _loc9_.text = "" + this._player.points;
         _loc9_ = this._slotGraphics.getChildByName("Text_Name") as TextField;
         _loc9_.text = this._player.name;
         _loc9_ = this._slotGraphics.getChildByName("Text_Games") as TextField;
         _loc9_.text = ProjectManager.getText("TOURNAMENT_SLOT_GAMES",[this._player.played_matches,param2.gameMaxAmount]);
      }
      
      public function getResourceUrl() : String
      {
         return !!this._player ? this._player.pic_url : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this._slotGraphics.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      public function getDesignMovieClip() : MovieClip
      {
         return this._design;
      }
   }
}

