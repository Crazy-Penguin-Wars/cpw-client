package tuxwars.home.ui.screen.friendselector
{
   public class CellList
   {
       
      
      private var mListIndex:uint = 0;
      
      private var mPanelList:Vector.<CellPanel>;
      
      private var mDataList:Vector.<Object>;
      
      private var mOutputList:Vector.<Object>;
      
      private var init:Boolean = false;
      
      public function CellList()
      {
         mPanelList = new Vector.<CellPanel>();
         mDataList = new Vector.<Object>();
         mOutputList = new Vector.<Object>();
         super();
      }
      
      public static function checkIndex(num:int, max:int, min:int, loop:Boolean = false) : int
      {
         if(num > max)
         {
            if(!loop)
            {
               num = max;
            }
            else
            {
               num = min;
            }
         }
         else if(num < min)
         {
            if(!loop)
            {
               num = min;
            }
            else
            {
               num = max;
            }
         }
         return num;
      }
      
      public function set setDataList(list:Vector.<Object>) : void
      {
         if(list != null)
         {
            mDataList = new Vector.<Object>();
            mOutputList = new Vector.<Object>();
            mDataList = list;
            mOutputList = list;
         }
      }
      
      public function get dataList() : Vector.<Object>
      {
         return mDataList;
      }
      
      public function set dataList(value:Vector.<Object>) : void
      {
         mDataList = value;
      }
      
      public function get panelList() : Vector.<CellPanel>
      {
         return mPanelList;
      }
      
      public function set listIndex(value:uint) : void
      {
         var max:int = Math.ceil(mOutputList.length - mPanelList.length);
         if(max < 0)
         {
            max = 0;
         }
         mListIndex = checkIndex(value,max,0);
      }
      
      public function get listIndex() : uint
      {
         return mListIndex;
      }
      
      public function get currentLength() : uint
      {
         return mOutputList.length;
      }
      
      public function addPanel(panel:CellPanel) : void
      {
         if(panel)
         {
            mPanelList.push(panel);
         }
      }
      
      public function removePanel(panel:CellPanel) : void
      {
         var i:int = 0;
         if(panel)
         {
            for(i = 0; i < mPanelList.length; )
            {
               if(mPanelList[i].id == panel.id)
               {
                  mPanelList.splice(i,1);
               }
               i++;
            }
         }
      }
      
      public function empty() : void
      {
         mDataList = new Vector.<Object>();
      }
      
      public function updateFromIndex(dataIndex:int, excluded:Vector.<Object> = null) : void
      {
         var panel:* = null;
         var data:* = null;
         mOutputList = new Vector.<Object>();
         var x:uint = 0;
         if(excluded != null && excluded.length > 0)
         {
            mOutputList = mDataList.concat();
            for(x = 0; x < excluded.length; )
            {
               FriendsSelectorBase.removeFromList(excluded[x].id,mOutputList);
               x++;
            }
         }
         else
         {
            mOutputList = mDataList.concat();
         }
         var panelIndex:uint = 0;
         var z:* = dataIndex;
         if(mListIndex != dataIndex || !init)
         {
            if(mOutputList != null && mOutputList.length < dataIndex + mPanelList.length && mOutputList.length > panelList.length)
            {
               dataIndex--;
            }
            if(dataIndex > -1)
            {
               mListIndex = dataIndex;
               for(panelIndex = 0; panelIndex < mPanelList.length; )
               {
                  if(mPanelList.length > panelIndex && mPanelList[panelIndex])
                  {
                     panel = mPanelList[panelIndex] as CellPanel;
                     if(mOutputList != null && mOutputList.length > dataIndex)
                     {
                        data = mOutputList[dataIndex] as Object;
                        panel.setData(data);
                        dataIndex++;
                     }
                     else
                     {
                        panel.setData(null);
                     }
                  }
                  panelIndex++;
               }
            }
         }
      }
      
      public function clean() : void
      {
         mPanelList = null;
         mDataList = null;
         mOutputList = null;
      }
   }
}
