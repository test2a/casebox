Ext.namespace('CB.plugin');

Ext.define('CB.plugin.PlacesProxy', {
    extend: 'Ext.data.proxy.Server',
    alias: 'proxy.google-places',

    constructor: function() {
        this.callSuper();
        this.autocompletePlaceService = new google.maps.places.AutocompleteService();
    },

   buildUrl: function() {
        return 'dummyUrl';
   },

    doRequest: function(operation) {
        var me = this,
            request = me.buildRequest(operation),
            params;

        request.setConfig({
            scope               : me,
            callback            : me.createRequestCallback(request, operation),
            disableCaching      : false // explicitly set it to false, ServerProxy handles caching 
        });

        return me.sendRequest(request);
    },

    sendRequest: function(request) {
        var input = request.getOperation().getParams().query;

        if(input) {
            this.autocompletePlaceService.getPlacePredictions({
                input: input
            }, request.getCallback());
        } else {
            // don't query Google with null/empty input
            request.getCallback().apply(this, [new Array()]);
        }

        this.lastRequest = request;

        return request;
    },

    abort: function(request) {
        // not supported by Google API 
    },

    createRequestCallback: function(request, operation) {
        var me = this;

        return function(places) {
            // handle result from google API
            if (request === me.lastRequest) {
                me.lastRequest = null;
            }
            // turn into a "response" ExtJs understands
            var response = {
                status: 200,
                responseText: places ? Ext.encode(places) : []
            };
            me.processResponse(true, operation, request, response);
         };
    },

    destroy: function() {
        this.lastRequest = null;        
        this.callParent();
    }
});