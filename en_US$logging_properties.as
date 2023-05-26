package
{
   import mx.resources.ResourceBundle;
   
   public dynamic class en_US$logging_properties extends ResourceBundle
   {
       
      
      public function en_US$logging_properties()
      {
         super("en_US","logging");
      }
      
      override protected function getContent() : Object
      {
         return {
            "charsInvalid":"Error for filter \'{0}\': The following characters are not valid: []~$^&/(){}<>+=_-`!@#%?,:;\'\".",
            "charPlacement":"Error for filter \'{0}\': \'*\' must be the right most character.",
            "invalidTarget":"Invalid target specified.",
            "invalidLen":"Categories must be at least one character in length.",
            "invalidChars":"Categories can not contain any of the following characters: []`~,!@#$%*^&()]{}+=|\';?><./\".",
            "levelLimit":"Logging level cannot be set to LogEventLevel.ALL."
         };
      }
   }
}
