Ext.namespace('CB.plugin.Export');

Ext.define('CB.plugin.Export.Button', {
    extend: 'CB.plugin.CustomInterface'
    ,alias: 'plugin.CBPluginExportButton'

    ,init: function(owner) {
        CB.plugin.Export.Button.superclass.init.call(this, arguments);
        this.owner = owner;

        owner.on('exportrecords', this.onExportRecordsEvent, this);
		owner.on('exportpdf', this.onExportPdfEvent, this);
    }

    ,onExportClick: function(b, e) {
        var params = Ext.clone(this.owner.params);

        delete params.lastQuery;

        params.from = 'grid';

        window.open('/c/' + App.config.coreName + '/get/?export=' + Ext.encode(params));
    }
	
    ,onExportPdfClick: function(b, e) {
		var nid = b[0].nid;
		
        window.open('/c/' + App.config.coreName + '/get/?pdf=' + parseInt(nid));
    }	

    ,onExportRecordsEvent: function(cmp, e) {
        e.stopPropagation();
        this.onExportClick();
    }
    ,onExportPdfEvent: function(cmp, e) {
        e.stopPropagation();
		var selection = cmp.getSelection();
		if(Ext.isEmpty(selection)) {
            return;
        }		
        this.onExportPdfClick(selection);
    }	
});
