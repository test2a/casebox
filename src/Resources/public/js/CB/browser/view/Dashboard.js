Ext.namespace('CB.browser.view');

Ext.define('CB.browser.view.Dashboard',{
    extend: 'CB.browser.view.Interface'

    ,xtype: 'CBBrowserViewDashboard'

    ,border: false
    ,tbarCssClass: 'x-panel-white'
    ,data: {}
    ,scrollable: true

    ,initComponent: function(){
	
        Ext.apply(this, {
            title: L.Dashboard
            ,viewName: 'dashboard'
            ,header: false
            ,items: [
            ]
            ,listeners: {
                scope: this
                ,activate: this.onActivate
            }
        });

        this.store.on(
            'load'
            ,this.onStoreLoad
            ,this
            ,{
                defer: 300
            }
        );

        this.callParent(arguments);
    }

    ,updateToolbarButtons: function() {
		
        this.refOwner.fireEvent(
            'settoolbaritems'
            ,[
				'edit',
				'upload',
				,'->'
                ,'reload'
                ,'apps'
            ]
        );
    }

    ,onStoreLoad: function(store, records, successful, eOpts) {
        var visible = this.getEl().isVisible(true);

        if (!visible) {
            return;
        }
        var rd = store.proxy.reader.rawData
            ,vc = rd.view;

        this.rawData = rd;

        this.removeAll(true);

        this.getLayout().columns = Ext.valueFrom(vc.columns, 1);

        // this.suspendEvents(false);

        this.addItems();

        // this.resumeEvents(true);

        this.updateLayout();
    }

    ,addItems: function() {
        var vc = this.rawData.view;

		this.objectViewView = new CB.object.view.View({
             border: false
             ,scrollable: true
             ,bodyStyle: 'padding: 5px'
         });

		this.add(this.objectViewView);
		this.objectViewView.load(this.rawData.folderProperties);
    }
	
    ,onActivate: function() {
        this.fireEvent(
            'settoolbaritems'
            ,[
				'edit',
				'upload',
                ,'->'
                ,'reload'
                ,'apps'
            ]
        );
    }
});
