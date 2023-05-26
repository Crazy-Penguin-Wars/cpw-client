package
{
   import mx.resources.ResourceBundle;
   
   public dynamic class en_US$collections_properties extends ResourceBundle
   {
       
      
      public function en_US$collections_properties()
      {
         super("en_US","collections");
      }
      
      override protected function getContent() : Object
      {
         return {
            "outOfBounds":"Index \'{0}\' specified is out of bounds.",
            "invalidIndex":"Invalid index: \'{0}\'.",
            "unknownProperty":"Unknown Property: \'{0}\'.",
            "incorrectAddition":"Attempt to add an item already in the view.",
            "itemNotFound":"Cannot find when view is not sorted.",
            "bookmarkNotFound":"Bookmark is not from this view.",
            "invalidInsert":"Cannot insert when current is beforeFirst.",
            "invalidRemove":"Cannot remove when current is beforeFirst or afterLast.",
            "bookmarkInvalid":"Bookmark no longer valid.",
            "invalidCursor":"Cursor no longer valid.",
            "noItems":"No items to search.",
            "findCondition":"Find criteria must contain all sort fields leading up to \'{0}\'.",
            "findRestriction":"Find criteria must contain at least one sort field value.",
            "unknownMode":"Unknown find mode.",
            "nonUnique":"Non-unique values in items.",
            "noComparator":"Cannot determine comparator for \'{0}\'.",
            "noComparatorSortField":"Cannot determine comparator for SortField with name \'{0}\'.",
            "invalidType":"Incorrect type. Must be of type XML or a XMLList that contains one XML object. "
         };
      }
   }
}
