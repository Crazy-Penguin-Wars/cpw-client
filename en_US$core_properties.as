package
{
   import mx.resources.ResourceBundle;
   
   public dynamic class en_US$core_properties extends ResourceBundle
   {
       
      
      public function en_US$core_properties()
      {
         super("en_US","core");
      }
      
      override protected function getContent() : Object
      {
         return {
            "truncationIndicator":"...",
            "multipleChildSets_ClassAndInstance":"Multiple sets of visual children have been specified for this component (component definition and component instance).",
            "multipleChildSets_ClassAndSubclass":"Multiple sets of visual children have been specified for this component (base component definition and derived component definition).",
            "fontIncompatible":"warning: incompatible embedded font \'{0}\' specified for {1}. This component requires that the embedded font be declared with embedAsCFF={2}.",
            "notExecuting":"Repeater is not executing.",
            "stateUndefined":"Undefined state \'{0}\'.",
            "viewSource":"View Source",
            "badFile":"File does not exist.",
            "versionAlreadySet":"Compatibility version has already been set.",
            "versionAlreadyRead":"Compatibility version has already been read.",
            "badParameter":"Parameter {0} must be one of the accepted values.",
            "nullParameter":"Parameter {0} must be non-null.",
            "badIndex":"The supplied index is out of bounds.",
            "notImplementedInFTETextField":"{0}\' is not implemented in FTETextField.",
            "unsupportedTypeInFTETextField":"FTETextField does not support setting type to \"input\".",
            "remoteClassMemoryLeak":"warning: The class {0} has been used in a call to net.registerClassAlias() in {2}. This will cause {1} to be leaked. To resolve the leak, define {0} in the top-level application.   "
         };
      }
   }
}
