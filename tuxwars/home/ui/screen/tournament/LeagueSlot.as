package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import flash.display.MovieClip;
   import flash.text.TextField;
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
      
      public function LeagueSlot(design:MovieClip)
      {
         super();
         _design = design;
         hideSlots();
      }
      
      private function hideSlots() : void
      {
         (_design.getChildByName("Slot_Least") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Least" + "_Active") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Default") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Default" + "_Active") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Red") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Red" + "_Active") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Top") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Top" + "_Active") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Green") as MovieClip).visible = false;
         (_design.getChildByName("Slot_Green" + "_Active") as MovieClip).visible = false;
      }
      
      public function setPlayer(player:TournamentPlayer, tournament:Tournament, playerIndex:int) : void
      {
         var slotGraphicsName:* = null;
         var tagIcon:* = null;
         var tagText:* = null;
         _player = player;
         var _loc6_:Boolean = tournament.league.findMyIndex() == playerIndex;
         hideSlots();
         if(playerIndex == 0 && player.rank == 1)
         {
            if(tournament.league.promotedPlayers > 0)
            {
               slotGraphicsName = "Slot_Top";
            }
            else
            {
               slotGraphicsName = "Slot_Default";
            }
         }
         else if(player.rank <= tournament.league.promotedPlayers)
         {
            slotGraphicsName = "Slot_Green";
         }
         else if(tournament.league.relegatedPlayers > 0 && player.rank > tournament.league.getPlayers().length - tournament.league.relegatedPlayers)
         {
            if(playerIndex == tournament.league.getPlayers().length - 1)
            {
               slotGraphicsName = "Slot_Least";
            }
            else
            {
               slotGraphicsName = "Slot_Red";
            }
         }
         else
         {
            slotGraphicsName = "Slot_Default";
         }
         if(_loc6_)
         {
            slotGraphicsName += "_Active";
         }
         _slotGraphics = _design.getChildByName(slotGraphicsName) as MovieClip;
         _slotGraphics.visible = true;
         if(getResourceUrl())
         {
            loader = ResourceLoaderURL.getInstance().load(this,null);
            getTargetMovieClip().visible = true;
         }
         else
         {
            getTargetMovieClip().visible = false;
         }
         var _loc4_:MovieClip = _slotGraphics.getChildByName("Tag") as MovieClip;
         if(_loc6_)
         {
            if(_player.previous_rank < _player.rank)
            {
               (_loc4_.getChildByName("Tag_Up") as MovieClip).visible = false;
               (_loc4_.getChildByName("Tag_Stay") as MovieClip).visible = false;
               tagIcon = _loc4_.getChildByName("Tag_Down") as MovieClip;
               tagIcon.visible = true;
               tagText = MovieClip(tagIcon).getChildByName("Text") as TextField;
               tagText.text = "" + (_player.rank - _player.previous_rank);
            }
            else if(_player.previous_rank > _player.rank)
            {
               (_loc4_.getChildByName("Tag_Down") as MovieClip).visible = false;
               (_loc4_.getChildByName("Tag_Stay") as MovieClip).visible = false;
               tagIcon = _loc4_.getChildByName("Tag_Up") as MovieClip;
               tagIcon.visible = true;
               tagText = MovieClip(tagIcon).getChildByName("Text") as TextField;
               tagText.text = "" + (_player.previous_rank - _player.rank);
            }
            else
            {
               (_loc4_.getChildByName("Tag_Down") as MovieClip).visible = false;
               (_loc4_.getChildByName("Tag_Up") as MovieClip).visible = false;
               (_loc4_.getChildByName("Tag_Stay") as MovieClip).visible = true;
            }
         }
         else
         {
            (_loc4_.getChildByName("Tag_Down") as MovieClip).visible = false;
            (_loc4_.getChildByName("Tag_Up") as MovieClip).visible = false;
            (_loc4_.getChildByName("Tag_Stay") as MovieClip).visible = false;
         }
         var tf:TextField = _slotGraphics.getChildByName("Text_Position") as TextField;
         tf.text = "" + _player.rank;
         tf = _slotGraphics.getChildByName("Text_Points") as TextField;
         tf.text = _player.score;
         tf = _slotGraphics.getChildByName("Text_Points_Value") as TextField;
         tf.text = "" + _player.points;
         tf = _slotGraphics.getChildByName("Text_Name") as TextField;
         tf.text = _player.name;
         tf = _slotGraphics.getChildByName("Text_Games") as TextField;
         tf.text = ProjectManager.getText("TOURNAMENT_SLOT_GAMES",[_player.played_matches,tournament.gameMaxAmount]);
      }
      
      public function getResourceUrl() : String
      {
         return !!_player ? _player.pic_url : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return _slotGraphics.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      public function getDesignMovieClip() : MovieClip
      {
         return _design;
      }
   }
}
