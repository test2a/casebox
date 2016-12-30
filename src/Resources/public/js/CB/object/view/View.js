	Ext.namespace('CB.object.view');
 
	Ext.define('CB.object.view.View', {
    extend: 'Ext.Panel'
	,alias: 'widget.CBObjectViewView'
	,api: 'CB_Objects.getPluginsData'
    ,border: false
    ,layout: 'card'
    ,activeItem: 0

    ,constructor: function() {

        Ext.apply(this, {
            loadedData: {}
        });

        this.callParent(arguments);
    }

    ,initComponent: function() {

	 Ext.apply(this, {
            layout: {
                type: 'vbox'
                ,align: 'stretch'
            }
        });

        this.callParent(arguments);

        App.on('filesuploaded', this.onFilesUploaded, this);
        App.on('objectsaction', this.onObjectsAction, this);

        this.delayLoadTask = new Ext.util.DelayedTask(this.doLoad, this);
		//CB_Objects.getPluginsData
	
        this.enableBubble(['changeparams', 'filedownload', 'createobject']);

        App.mainViewPort.on('objectsdeleted', this.onObjectsDeleted, this);
        App.on('objectchanged', this.onObjectChanged, this);
        App.on('objectsaction', this.onObjectsAction, this);

        App.Favorites.on('change', this.onFavoritesChange, this);
    }

    /**
     * on show
     * @param  component
     * @return void
     */
    ,onShowEvent: function(c) {
        if(this.lastLoadData) {
            this.load(this.lastLoadData);
        }
    }

    /**
     * remove listeners on destroy
     * @param  component
     * @return void
     */
    ,onBeforeDestroy: function(c) {
        App.mainViewPort.un('objectsdeleted', this.onObjectsDeleted, this);
        App.un('objectchanged', this.onObjectChanged, this);
        App.un('objectsaction', this.onObjectsAction, this);
    }

    /**
     * change active view (properties/preview)
     * @param int index
     * @param bool autoLoad
     */
    ,setActiveView: function(index, autoLoad){
        var currentItemIndex = this.items.indexOf(this.getLayout().activeItem);

        if(currentItemIndex == index) {
            return;
        }

        this.clear();

        this.getLayout().setActiveItem(index);

        this.onViewChange();

        if(autoLoad !== false) {
            this.load(this.requestedLoadData);
        }
    }

    /**
     * adjustments on view change
     * @return void
     */
    ,onViewChange: function() {
        var d = this.loadedData;
        //this.actions.edit.setDisabled(isNaN(d.id) || Ext.isEmpty(d.id));
        //this.BC.get('preview').toggle(this.loadedData.viewIndex == 1, false);
    }

    /**
     * clear function
     * @return {[type]} [description]
     */
    ,clear: function() {
        this.delayedLoadTask.cancel();
        delete this.locked;
        delete this.requestedLoadData;
        this.previousLoadedData = Ext.clone(this.loadedData);
        this.loadedData = {};
        this.getLayout().activeItem.clear();
        this.updateToolbarAndMenuItems();
    }

    /**
     * loading an object into the panel in a specific view
     * @param  {[type]} objectData
     * @return {[type]}
     */
    ,load: function (params) {
        if(!isNaN(params)) {
            params = {id: params};
        }

        this.delayLoadTask.cancel();

        /* check if not the same as current params */
        if(Ext.encode(params) == Ext.encode(this.loadedParams)) {
            return;
        }

        /* delay task */
        this.delayLoadTask.delay(60, this.doLoad, this, arguments);

    }

    /**
     * direct loading method of the this.requestedLoadData
     * @return void
     */
    ,doLoad: function(params) {
		this.api = CB_Objects.getPluginsData;
        if(Ext.isEmpty(this.api)) {
            return;
        }

        if(!isNaN(params)) {
            params = {id: params};
        }

        this.clear();

        if(Ext.isEmpty(params) || (Ext.isEmpty(params.id) && Ext.isEmpty(params.template_id))) {
            this.fireEvent('loaded', this);
            return;
        }

        this.loadedParams = params; //Ext.apply({}, params);
        this.api(params, this.onLoadData, this);
    }


    ,onLoadData: function(r, e) {
        var items = []
            ,params = Ext.valueFrom(this.loadedParams, {});

        //check if object was found (success = true)
        if(!r || (r.success !== true)) {
            this.update('<div class="x-preview-mask">' + L.RecordIdNotFound.replace('{id}', '#' + params.id) + '</div>');

        } else {
            var commonInfo = r.common
                ? r.common.data
                : Ext.valueFrom(r.data.systemProperties, {}).data;

            Ext.apply(params, commonInfo);

            this.removeAll(true);

            this.createMenu = r.menu;
			var tabPanel = Ext.create('Ext.tab.Panel', {
				width: 400,
				height: 400,
				items: []
			});
			//527,289,311,607,61,510,533,553,482,1120,455,505,559,489,440,656,1175,651,172
			var clientIntakeMenu = '289,311,527';
			var assessmentMenu = '510,533,553,482,1120,455,505,559,489,440,656,1175,651,172';
			var recoveryMenu = '527'
			var referralMenu = '607';
			var clientIntakeData=[];
			clientIntakeData.data = [];
			var assessmentData=[];		
			assessmentData.data = [];	
			var referralData=[];		
			referralData.data = [];
			var recoveryData=[];		
			recoveryData.data = [];			
			if (Ext.isDefined(r.data.contentItems))
			{
				Ext.iterate(
					r.data.contentItems.data
					,function(k, v, o) {
					   if (clientIntakeMenu.indexOf(k.template_id) >=  0)
					   {
						   clientIntakeData.data.push(k);
					   }
					   if (assessmentMenu.indexOf(k.template_id) >=  0)
					   {
						   assessmentData.data.push(k);
					   }
					   if (referralMenu.indexOf(k.template_id) >=  0)
					   {
						   referralData.data.push(k);
					   }
					   if (recoveryMenu.indexOf(k.template_id) >=  0)
					   {
						   recoveryData.data.push(k);
					   }					   
				}
					,this
				);
			}			
			var c  = Ext.create('CBObjectPluginContentItems',{params: params})		
			c.createMenu = clientIntakeMenu;	
			c.title = 'Intake' + ' [' +clientIntakeData.data.length+']';
			c.updateTitle('Client Intake');
			c.onLoadData(clientIntakeData);
			items.push(c);
			
			c  = Ext.create('CBObjectPluginContentItems',{params: params})		
			c.createMenu = assessmentMenu;	
			c.title = 'Assessments' + ' [' +assessmentData.data.length+']';
			c.updateTitle('Client Assessment');
			c.onLoadData(assessmentData);
			items.push(c);

			c  = Ext.create('CBObjectPluginContentItems',{params: params})		
			c.createMenu = referralMenu;	
			c.title = 'Referrals' + ' [' +referralData.data.length+']';
			c.updateTitle('Client Referrals');
			c.onLoadData(referralData);
			items.push(c);
			
			c  = Ext.create('CBObjectPluginContentItems',{params: params})		
			c.createMenu = recoveryMenu;	
			c.title = 'Recovery' + ' [' +recoveryData.data.length+']';
			c.updateTitle('Client Recovery Plan');
			c.onLoadData(recoveryData);
			items.push(c);

			c  = Ext.create('CBObjectPluginFiles',{params: params})		
			c.createMenu = r.menu;	
			if (Ext.isDefined(r.data.files))
			{			
			c.title = 'Files' + ' [' +r.data.files.data.length+']';
			c.onLoadData(r.data.files);
			}
			items.push(c);
			
			c  = Ext.create('CBObjectPluginComments',{params: params})		
			c.createMenu = r.menu;	
			if (Ext.isDefined(r.data.comments))
			{			
			c.title = 'Comments' + ' [' +r.data.comments.data.length+']';
			c.onLoadData(r.data.comments);
			}
			items.push(c);
			
			
            if(!Ext.isEmpty(items)) {
                tabPanel.add(items);
            }
			
			tabPanel.setActiveItem(0);
			
			 //tabPanel.tabBar.items.each(function(card){
             //           card.setDisabled(true);
             //       });
			
			this.add(tabPanel);

			
            /**
             * we make this check for title after all plugins have been added
             * because objectProperties plugin applies loaded data (including object name)
             * to the params
             */
            if(params &&
                // (CB.DB.templates.getType(params.template_id) !== 'task') &&
                (params.from !== 'window') &&
                !Ext.isEmpty(params.name)
            ){
			
				if (r.data.objectProperties.data.preview[1] != null) {
					Ext.apply(params, r.data.objectProperties.data);
					var previewHtml = r.data.objectProperties.data.preview[1];
					params.preview = previewHtml.replace("display:none","");
				}
				else
				{
					params.preview = "None";
				}
				
				var data = Ext.copyTo(
                    {}
                    ,params
                    ,'id,pids,path,name,template_id,status,statusCls,cid,cdate_ago_text,uid,udate_ago_text,preview'
                );
				
					var titleView =  new Ext.panel.Panel({
					width: 300,
					margin: 0,
					bodyPadding: 0,
					border: false,
					header: false,				
					tpl: [
						,'<div class="obj-header" style="text-align:left"><b class="{titleCls}">{[ Ext.String.htmlEncode(Ext.valueFrom(values.name, \'\')) ]}</b> &nbsp;'
							,'{[ this.getStatusInfo(values) ]}'
							,'{preview}'
								,'{[ this.getTitleInfo(values) ]}'
							,'</div>'
						,'</div>'
						 ,{
                getStatusInfo: function (values) {
						if(Ext.isEmpty(values.status)) {
							return '';
						}

						var rez = '<div class="dIB fs12 ' + Ext.valueFrom(values.statusCls, '') + '"">' +
							values.status + '</div>';

						return rez;
					}

                ,getTitleInfo: function (values) {
						var rez = [];

						// #Id
						if(values.id) {
							rez.push('#' + values.id);
						}

						// Creator
						if (values.cid) {
							rez.push(
								L.CreatedBy + ' ' +
								CB.DB.usersStore.getName(values.cid) + ' ' +
								Ext.valueFrom(values.cdate_ago_text, '')
							);
						}

						// Updater
						if (values.uid) {
							rez.push(
								L.UpdatedBy + ' ' +
								CB.DB.usersStore.getName(values.uid) + ' ' +
								Ext.valueFrom(values.udate_ago_text, '')
							);
						}

						return rez.join(' - ');
					}
            }
					],
					html: ''
				});
				
				titleView.update(Ext.valueFrom(data, {}));
                this.insert(0, titleView);
            }

            this.doLayout(true, true);
        }

        this.fireEvent('loaded', this, params);
    }

    ,clear: function() {
        this.removeAll(true);
        delete this.loadedParams;
    }

    ,onFilesUploaded: function(pids) {
        if(!Ext.isEmpty(this.loadedParams)) {
            if(pids.indexOf(String(this.loadedParams.id)) >=0 ) {
                this.reload();
            }
        }
    }

    ,onObjectsAction: function(action, data, e) {
        if(this.loadedParams && (data.targetId == this.loadedParams.id)) {
            this.reload();
        }
    }

    ,reload: function() {
        this.doLoad(this.loadedParams);
    }

    /**
     * method to be overriden for returning needed buttons for container toolbar
     * @return object
     *         Example: rez = {
     *              tbar: {}
     *              ,menu: {
     *                   reload: {}
     *              }
     *          }
     */
    ,getContainerToolbarItems: function() {

    }	
	
	
    ,onPluginsContainerLoaded: function(cmp, params) {
        this.loadedData.subscription = params.subscription;
        this.onCardItemLoaded(cmp);
    }
    /**
     * adjustments on view loaded
     * @param  object item
     * @return void
     */
    ,onCardItemLoaded: function(item) {
        this.locked = false;

        this.updateToolbarAndMenuItems();

        this.fireEvent('loaded', this, item);

        if(Ext.isEmpty(this.loadedData) || Ext.isEmpty(this.loadedData.scroll)) {
            return;
        }
        if(item.body) {
            item.body.scrollTo('left', this.loadedData.scroll.left);
            item.body.scrollTo('top', this.loadedData.scroll.top);
        }
    }

    /**
     * update toolbar and menu item corresponding to active view
     * @return void
     */
    ,updateToolbarAndMenuItems: function() {
        var ai = this.getLayout().activeItem;

        if(this.menu) {
            this.menu.removeAll(true);
            this.menu.destroy();
        }

        this.menu = new Ext.menu.Menu({items:[]});

        //this.BC.get('more').setMenu(this.menu, true);

        //hide all by default

    }

    /**
     * update create menu under the points button
     * @return {[type]} [description]
     */
    ,updateCreateMenu: function() {
        if(!this.menu) {
            return;
        }

        var nmb = this.menu.child('[name="newmenu"]');

        if(nmb) {
            updateMenu(
                nmb
                ,this.getLayout().activeItem.createMenu
                ,this.onCreateObjectClick
                ,this
            );

            nmb.setDisabled(nmb.menu.items.getCount() < 1);
        }
    }

    /**
     * edit an item
     * Shold be reviewed and merge with next method
     * or even moved/merged to mainViewPort component
     * @param  object objectData
     * @param  event e
     * @return void
     */
    ,edit: function (objectData, e) {
        objectData.view = 'edit';

        this.openObjectWindow(objectData);
    }

    /**
     * open an object edit window with given data
     * @param  object objectData
     * @return void
     */
    ,openObjectWindow: function(objectData) {
        var data = Ext.apply({}, objectData);
        //edit object in popup window
        delete data.html;

        App.windowManager.openObjectWindow(data);
    }

    /**
     * handler for edit button click
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onEditClick: function(b, e) {
        var p = Ext.apply({}, this.loadedData);

        switch(detectFileEditor(p.name)) {
            case 'webdav':
                App.openWebdavDocument(p);
                break;

            default:
               // p.comment = this.getCommentValue();

               // this.setCommentValue('');

                this.edit(p, e);
                break;
        }
    }

    /**
     * handler for reload button
     * Reloads active view (properties or preview)
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onReloadClick: function(b, e) {
       // this.getLayout().activeItem.reload(); //don't think we need this
    }

    /**
     * handler for rename button
     * Open permissions window for loaded item by calling viewport method
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onRenameClick: function(b, e) {
        var data = {
            path: this.loadedData.id
            ,name: Ext.util.Format.htmlDecode(this.loadedData.name)
            ,scope: this
            ,callback: function(r, e) {
                this.loadedData.name = r.data.newName;
            }
        };

        App.promptRename(data);
    }

    /**
     * handler for permissions button
     * Open permissions window for loaded item by calling viewport method
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onPermissionsClick: function(b, e) {
        App.mainViewPort.openPermissions(this.loadedData.id);
    }

    /**
     * event handler for objects deletion
     *
     * There is no need to reload this view because the grid will reload and change the selection,
     * but need to cancel the edit
     *
     * @param  array ids
     * @param  object e
     * @return void
     */
    ,onObjectsDeleted: function(ids, e) {
        if(!Ext.isEmpty(this.loadedData) && setsHaveIntersection(ids, this.loadedData.id)) {
            // delete this.locked;
            this.setActiveView(0, false);
            this.clear();
            // this.loadedData = {};
            // this.items.getAt(0).clear();
            // this.updateToolbarAndMenuItems();
        }
    }

    /**
     * handler for fit image toolbar button
     * toggle fit image preview
     * This method actually should be managed by preview component
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onFitImageClick: function(b, e) {
        var ai = this.getLayout().activeItem;
        if(ai.onFitImageClick) {
            ai.onFitImageClick(b, e);
        }
    }

    /**
     * handler for preview toolbar button
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onPreviewClick: function(b, e) {
        var p = Ext.clone(this.loadedData);

        p.viewIndex = b.pressed
            ? 1
            : 0;

        this.delayedLoadTask.cancel();
        this.requestedLoadData = p;

        this.doLoad();
    }

    /**
     * handler for open external toolbar button
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onOpenExternalClick: function(b, e) {
        var d = Ext.apply({}, this.loadedData);

        d.comment = this.getCommentValue();

        this.setCommentValue('');

        d.popOut = true;
        d.view = 'edit';

        this.openObjectWindow(d);
    }

    /**
     * handler for open preview from components below
     *
     * It was opening preview in current component,
     * when editing on the right side was available.
     * Now it opens popup window in preview mode.
     *
     * @param  object data
     * @param  event e
     * @return void
     */
    ,onOpenPreviewEvent: function(data, e) {
        if(Ext.isEmpty(data)) {
            data = this.loadedData;
        }

        if(this.loadedData && (data.id == this.loadedData.id)) {
            Ext.applyIf(data, this.loadedData);
        }

        App.windowManager.openObjectWindow(Ext.clone(data), e);
    }

    /**
     * handler for open edit object event from components below
     *
     * It was opening edit in current component,
     * when editing on the right side was available.
     * Now it opens popup window in edit mode.
     *
     * @param  object data
     * @param  event e
     * @return void
     */
    ,onEditObjectEvent: function(data, e) {
        if(e) {
            e.stopEvent();
        }

        if(Ext.isEmpty(data)) {
            data = this.loadedData;
        }

        var p = Ext.clone(data);

        this.edit(p, e);
    }

    /**
     * handler for download toolbar button
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onDownloadClick: function(b, e) {
        this.fireEvent('filedownload', [this.loadedData.id], false, e);
    }

    /**
     * handler for creating new items from dropdown menu
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onCreateObjectClick: function(b, e) {
        this.goBackOnSave = true;

        var d = b.config.data;
        d.pid = this.loadedData.id;
        d.path = this.loadedData.path;
        this.fireEvent('createobject', d, e);
    }

    /**
     * handler for close task toolbar button
     * It is available when an active task is loaded.
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onCloseTaskClick: function(b, e) {
        this.getEl().mask(L.CompletingTask + ' ...', 'x-mask-loading');
        CB_Tasks.close(this.loadedData.id, this.onTaskChanged, this);
    }

    /**
     * handler for reopen a closed task toolbar button
     * It is available when a closed task is loaded.
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onReopenTaskClick: function(b, e) {
        this.getEl().mask(L.ReopeningTask + ' ...', 'x-mask-loading');
        CB_Tasks.reopen(this.loadedData.id, this.onTaskChanged, this);
    }

    /**
     * handler for completing task toolbar button
     * It is available when a task is loaded.
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onCompleteTaskClick: function(b, e) {
        CB_Tasks.complete(
            {
                id: this.loadedData.id
                ,message: ''
            }
            ,this.onTaskChanged
            ,this
        );
    }

    /**
     * common handler for task actions responce
     *
     * @param  responce r
     * @param  event e
     * @return void
     */
    ,onTaskChanged: function(r, e){
        this.getEl().unmask();
        App.fireEvent('objectchanged', this.loadedData, this);
    }

    ,onSubscriptionButtonClick: function(b, e) {
        var type = (b.itemId === 'notifyOn')
            ? 'watch'
            : 'ignore';

        CB_Objects.setSubscription(
            {
                objectId: this.loadedData.id
                ,type: type
            }
            ,function(r, e) {
                if(!r || (r.success !== true)) {
                    return;
                }

                this.actions.notifyOn.setHidden(type === 'watch');
                this.actions.notifyOff.setHidden(type === 'ignore');
            }
            ,this
        );
    }

    /**
     * handler for WebDav Link menu button click
     * Shows a window with link for WebDav editing
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onWebDAVLinkClick: function(b, e) {
        App.openWebdavDocument(
            this.loadedData
            ,false
        );
    }

    /**
     * handler for Permalink menu button click
     * Shows a prompt window with permalink
     *
     * @param  button b
     * @param  event e
     * @return void
     */
    ,onPermalinkClick: function(b, e) {
        window.prompt(
            'Copy to clipboard: Ctrl+C, Enter'
            , window.location.origin + '/c/' + App.config.coreName + '/view/' + this.loadedData.id + '/');
    }

    /**
     * handler for lockpanel event
     * Current component wouldnt accept any load requests when locked
     *
     * @param  boolean status
     * @return void
     */
    ,onLockPanelEvent: function(status) {
        this.locked = status;
    }

    /**
     * method for setting selected file version on contained versions plugin
     * This method was used by files editing window
     * Now it would be changed/removed
     *
     * @param object params
     */
    ,setSelectedVersion: function(params) {
        var ai = this.getLayout().activeItem;
        if(ai.isXType('CBObjectProperties')) {
            ai.setSelectedVersion(params);
        }
    }

    /**
     * handler for objects action event (move/copy)
     *
     * @param  object r responce
     * @param  event e
     * @return void
     */
    ,onObjectsAction: function(action, r, e){
        if(this.loadedData.id == r.targetId) {
            this.onReloadClick();
        }
    }

    /**
     * handler for global object change event
     * Here we react and reload the view if necessary
     * @param  object data
     * @param  component component
     * @return void
     */
    ,onObjectChanged: function(data, component) {
        if(!isNaN(data)) {
            data = {id: data};
        }

        if(!Ext.isEmpty(data.isNew) && (data.type !== 'time_tracking')) {
            this.requestedLoadData = data;
            this.doLoad();
            return;
        }

        if(!Ext.isEmpty(this.loadedData)) {
            if((data.pid == this.loadedData.id) || (data.id == this.loadedData.id)) {
                this.onReloadClick();
            }
        }
    }

    /**
     * close this view container (hides it)
     * @return void
     */
    ,onCloseClick: function() {
        this.collapse();
    }

    ,onSetOwnershipClick: function(b, e) {
        if(!Ext.isEmpty(this.loadedData.id)) {
            CB_Objects.setOwnership(
                {
                    ids: this.loadedData.id
                    ,userId: b.userId
                }
                ,this.processSetOwnership
                ,this
            );
        }
    }

    ,processSetOwnership: function(r, e) {
        if(r && r.success) {
            App.fireEvent('objectchanged', this.loadedData, this);
        }
    }

    ,onStarClick: function(b, e) {
        var ld = this.loadedData
            ,d = {
                id: ld.id
                ,name: ld.name
                ,iconCls: ld.iconCls
                ,path: '/' + ld.pids + '/' + ld.id
                ,pathText: ld.path
            };

        App.Favorites.setStarred(d);
    }

    ,onUnstarClick: function(b, e) {
        App.Favorites.setUnstarred(this.loadedData.id);
    }

    ,onFavoritesChange: function() {
        if(this.loadedData) {
            var isStarred = App.Favorites.isStarred(this.loadedData.id);

            this.actions.star.setHidden(isStarred);
            this.actions.unstar.setHidden(!isStarred);
        }
    }
}
);