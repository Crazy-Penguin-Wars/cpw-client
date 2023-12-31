package
{
   import mx.resources.ResourceBundle;
   
   public dynamic class en_US$messaging_properties extends ResourceBundle
   {
       
      
      public function en_US$messaging_properties()
      {
         super("en_US","messaging");
      }
      
      override protected function getContent() : Object
      {
         return {
            "unknownDestination":"Unknown destination \'{0}\'.",
            "destinationWithInvalidMessageType":"Destination \'{0}\' cannot service messages of type \'{1}\'.",
            "unknownDestinationForService":"Unknown destination \'{1}\' for service with id \'{0}\'.",
            "noServiceForMessageType":"No service is configured to handle messages of type \'{0}\'.",
            "unknownChannelWithId":"Channel \'{0}\' does not exist in the configuration.",
            "unknownChannelClass":"The channel class \'{0}\' specified was not found.",
            "noChannelForDestination":"Destination \'{0}\' either does not exist or the destination has no channels defined (and the application does not define any default channels.)",
            "noDestinationSpecified":"A destination name must be specified.",
            "connectTimedOut":"Connect attempt timed out.",
            "noURLSpecified":"No url was specified for the channel.",
            "cannotAddWhenConfigured":"Channels cannot be added to a ChannelSet that targets a configured destination.",
            "cannotRemoveWhenConfigured":"Channels cannot be removed from a ChannelSet that targets a configured destination.",
            "noAvailableChannels":"No Channels are available for use.",
            "sendFailed":"Send failed",
            "cannotConnectToDestination":"No connection could be made to the message destination.",
            "cannotAddNullIdChannelWhenClustered":"Cannot add a channel with null id to ChannelSet when its clustered property is true.",
            "cannotSetClusteredWithdNullChannelIds":"Cannot change clustered property of ChannelSet to true when it contains channels with null ids. ",
            "resubscribeIntervalNegative":"resubscribeInterval cannot take a negative value.",
            "consumerSubscribeError":"Consumer subscribe error",
            "failedToSubscribe":"The consumer was not able to subscribe to its target destination.",
            "emptyDestinationName":"{0}\' is not a valid destination.",
            "destinationNotSet":"The MessageAgent\'s destination must be set to send messages.",
            "reconnectIntervalNegative":"reconnectInterval cannot take a negative value.",
            "producerConnectError":"Producer connect error",
            "failedToConnect":"The producer was not able to connect to its target destination.",
            "producerSendError":"Send failed",
            "producerSendErrorDetails":"The producer is not connected and the message cannot be sent.",
            "queuedMessagesNotAllowedDetails":"This producer does not have an assigned message queue so queued messages cannot be sent.",
            "messageQueueSendError":"Send failed",
            "wrongMessageQueueForProducerDetails":"The message did not come from the message store associated with this producer.",
            "lsoStorageNotAllowed":"The message store cannot initialize because local storage is not allowed. Please ensure that local storage is enabled for the Flash Player and that sufficient storage space is configured.",
            "messageQueueNotInitialized":"The message store has not been initialized.",
            "messageQueueFailedInitialize":"Message store initialization failed.",
            "couldNotAddMessageToQueue":"The message store could not store the message and the producer is not connected. The FaultEvent dispatched by the message store provides additional information.",
            "couldNotRemoveMessageFromQueue":"The message could not be removed from the message store before being sent.",
            "couldNotLoadCache":"The cache could not be loaded into the message store.",
            "couldNotSaveCache":"The cache could not be saved.",
            "couldNotClearCache":"The cache could not be cleared.",
            "couldNotLoadCacheIds":"The list of cache ids could not be loaded.",
            "emptySessionClientId":"Session clientId\'s must be non-zero in length.",
            "pollingIntervalNonPositive":"Channel pollingInterval may only be set to a positive value.",
            "pollingRequestNotAllowed":"Poll request made on \'{0}\' when polling is not enabled.",
            "invalidURL":"Invalid URL",
            "pollingNotSupportedAMF":"StreamingAMFChannel does not support polling. ",
            "noURIAllowed":"Error for DirectHTTPChannel. No URI can be specified.",
            "authenticationNotSupported":"Authentication not supported on DirectHTTPChannel (no proxy).",
            "httpRequestError":"HTTP request error",
            "httpRequestError.details":"Error: {0}",
            "securityError":"Security error accessing url",
            "securityError.details":"Destination: {0}",
            "noAMFXBody":"Invalid AMFX packet. Could not find message body",
            "unsupportedAMFXVersion":"Unsupported AMFX version: {0}",
            "noAMFXNode":"Invalid AMFX packet. Content must start with an <amfx> node",
            "AMFXTraitsNotFirst":"Invalid object. A single set of traits must be supplied as the first entry in an object.",
            "errorReadingIExternalizable":"Error encountered while reading IExternalizable. {0}",
            "notImplementingIExternalizable":"Class {0} must implement flash.util.IExternalizable.",
            "unknownReference":"Unknown reference {0}",
            "referenceMissingId":"A reference must have an id.",
            "unknownStringReference":"Unknown string reference {0}",
            "unknownTraitReference":"Unknown trait reference {0}",
            "invalidRequestMethod":"Invalid method specified.",
            "requestTimedOut":"Request timed out",
            "requestTimedOut.details":"The request timeout for the sent message was reached without receiving a response from the server.",
            "deliveryInDoubt":"Channel disconnected",
            "deliveryInDoubt.details":"Channel disconnected before an acknowledgement was received",
            "ackFailed":"Didn\'t receive an acknowledgement of message",
            "ackFailed.details":"Was expecting message \'{0}\' but received \'{1}\'.",
            "noAckMessage":"Didn\'t receive an acknowledge message",
            "noAckMessage.details":"Was expecting mx.messaging.messages.AcknowledgeMessage, but received {0}",
            "pollingNotSupportedHTTP":"StreamingHTTPChannel does not support polling. ",
            "noErrorForMessage":"Didn\'t receive an error for message",
            "noErrorForMessage.details":"Was expecting message \'{0}\' but received \'{1}\'.",
            "receivedNull":"Received null."
         };
      }
   }
}
