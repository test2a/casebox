
/* DisplayColumns.js */

/* 1   */ Ext.namespace('CB.plugin');
/* 2   */ 
/* 3   */ Ext.onReady(function(){
/* 4   */     var plugins = CB.browser.view.Grid.prototype.plugins || [];
/* 5   */     plugins.push({
/* 6   */         ptype: 'CBPluginDisplayColumns'
/* 7   */     });
/* 8   */     CB.browser.view.Grid.prototype.plugins = plugins;
/* 9   */ });
/* 10  */ 
/* 11  */ 
/* 12  */ Ext.define('CB.plugin.DisplayColumns', {
/* 13  */     extend: 'Ext.util.Observable'
/* 14  */     ,alias: 'plugin.CBPluginDisplayColumns'
/* 15  */     ,lastState: ''
/* 16  */ 
/* 17  */     ,init: function(owner) {
/* 18  */         this.owner = owner;
/* 19  */         this.grid = owner.grid;
/* 20  */         this.store = owner.grid.store;
/* 21  */ 
/* 22  */         this.defaultColumns = owner.grid.defaultColumns;
/* 23  */         this.reader = this.store.proxy.reader;
/* 24  */         this.model = this.store.getModel();
/* 25  */         this.defaultFieldNames = this.extractFieldNames(this.model.fields);
/* 26  */         this.proxy = this.store.proxy;
/* 27  */ 
/* 28  */         this.owner.on('activate', this.onActivateView, this);
/* 29  */         this.store.on('load', this.onStoreLoad, this);
/* 30  */         this.store.on('manualload', this.onStoreLoad, this);
/* 31  */         this.store.on('clear', this.onStoreClear, this);
/* 32  */         this.store.on('load', this.clearDisableStateSaveFlag, this, {defer: 1000});
/* 33  */     }
/* 34  */ 
/* 35  */     ,onActivateView: function(view) {
/* 36  */         this.lastState = '';
/* 37  */     }
/* 38  */ 
/* 39  */     ,onStoreClear: function(store) {
/* 40  */         this.grid.disableStateSave = true;
/* 41  */     }
/* 42  */ 
/* 43  */     ,onStoreLoad: function(store, records, successful, eOpts) {//proxy, obj, options
/* 44  */         //dont do anything if view not visible
/* 45  */         if(this.owner.getEl().isVisible(true) !== true) {
/* 46  */             return;
/* 47  */         }
/* 48  */ 
/* 49  */         var rez = store.proxy.reader.rawData
/* 50  */             ,view = Ext.valueFrom(rez.view, {});

/* DisplayColumns.js */

/* 51  */ 
/* 52  */         //set flag to avoid saving grid state while restoring remote config
/* 53  */         this.grid.disableStateSave = true;
/* 54  */ 
/* 55  */         if(!Ext.isEmpty(view.sort)) {// && Ext.isEmpty(this.store.sortInfo)
/* 56  */             var sorters = this.store.getSorters();
/* 57  */             sorters.suspendEvents();
/* 58  */             sorters.clear();
/* 59  */ 
/* 60  */             sorters.addSort(view.sort.property, view.sort.direction);
/* 61  */             sorters.resumeEvents(true);
/* 62  */         }
/* 63  */ 
/* 64  */         //add corresponding metadata to obj.result if DisplayColumns changed
/* 65  */         this.currentColumns = rez.DC || [];
/* 66  */ 
/* 67  */         var currentState = view.type +
/* 68  */             Ext.util.JSON.encode(this.currentColumns) +
/* 69  */             (view.sort ? Ext.util.JSON.encode(view.sort) : '');
/* 70  */ 
/* 71  */         if(this.lastState !== currentState) {
/* 72  */             var storeFields = this.getNewMetadata();
/* 73  */             store.setFields(storeFields);
/* 74  */ 
/* 75  */             this.lastState = currentState;
/* 76  */ 
/* 77  */             var nc = this.getNewColumns();
/* 78  */             this.grid.reconfigure(null, nc);
/* 79  */         }
/* 80  */ 
/* 81  */         //restore or disable grouping state
/* 82  */         var groupFeature = this.grid.view.features[0];
/* 83  */         if(!Ext.isEmpty(view.group) && !Ext.isEmpty(view.group.property)) {
/* 84  */             store.remoteSort = false;
/* 85  */ 
/* 86  */             if(groupFeature.disabled) {
/* 87  */                 var menuItem = groupFeature.getMenuItem('group');//rez.group.property
/* 88  */                 if(Ext.isEmpty(menuItem)) {
/* 89  */                     menuItem = {
/* 90  */                         parentMenu: this.grid.view.headerCt.getMenu()
/* 91  */                     };
/* 92  */                 }
/* 93  */ 
/* 94  */                 if(Ext.isEmpty(menuItem.parentMenu.activeHeader)) {
/* 95  */                     menuItem.parentMenu.activeHeader = this.grid.getVisibleColumnManager().getHeaderByDataIndex(view.group.property);
/* 96  */                 }
/* 97  */ 
/* 98  */                 if(!Ext.isEmpty(menuItem.parentMenu.activeHeader)) {
/* 99  */                     groupFeature.onGroupMenuItemClick(menuItem, eOpts);
/* 100 */                 }

/* DisplayColumns.js */

/* 101 */             }
/* 102 */ 
/* 103 */             var groupDir = Ext.valueFrom(view.group.direction, 'ASC');
/* 104 */             if(store.getGroupDir != groupDir) {
/* 105 */                 store.group('group', groupDir);//rez.group.property
/* 106 */             }
/* 107 */ 
/* 108 */         } else if(Ext.isEmpty(view.group) && !groupFeature.disabled) {
/* 109 */             store.remoteSort = false;
/* 110 */             groupFeature.disable();
/* 111 */         }
/* 112 */     }
/* 113 */ 
/* 114 */     /**
/* 115 *|      * disableStateSave flag is set during state restore received from server
/* 116 *|      * It should be removed at the end of the process
/* 117 *|      * @return void
/* 118 *|      */
/* 119 */     ,clearDisableStateSaveFlag: function() {
/* 120 */         delete this.grid.disableStateSave;
/* 121 */         this.store.remoteSort = true;
/* 122 */     }
/* 123 */ 
/* 124 */     /**
/* 125 *|      * get new fields metadata for the store by analyzing DC config received from server
/* 126 *|      * @return array
/* 127 *|      */
/* 128 */     ,getNewMetadata: function(){
/* 129 */         var i
/* 130 */             ,key
/* 131 */             ,fieldData
/* 132 */             ,rez = Ext.apply([], CB.DB.defaultItemFields)
/* 133 */             ,currentColumns = Ext.apply({}, this.currentColumns);
/* 134 */ 
/* 135 */         for (i = 0; i < rez.length; i++) {
/* 136 */             fieldData = rez[i];
/* 137 */ 
/* 138 */             if(Ext.isString(fieldData)) {
/* 139 */                 key = fieldData;
/* 140 */                 fieldData = {
/* 141 */                     name: key
/* 142 */                 };
/* 143 */             } else {
/* 144 */                 key = rez[i].name;
/* 145 */             }
/* 146 */ 
/* 147 */             if(Ext.isDefined(currentColumns[key])) {
/* 148 */                 rez[i] = Ext.copyTo(fieldData, currentColumns[key], ['type', 'sortType']);
/* 149 */                 rez[i].convert = null;
/* 150 */ 

/* DisplayColumns.js */

/* 151 */                 delete currentColumns[key];
/* 152 */             }
/* 153 */         }
/* 154 */ 
/* 155 */         Ext.iterate(
/* 156 */             currentColumns
/* 157 */             ,function(key, value, obj){
/* 158 */                 var field = {
/* 159 */                     name: key
/* 160 */                     ,title: Ext.valueFrom(value.title, 'No title')
/* 161 */                 };
/* 162 */                 rez.push(field);
/* 163 */             }
/* 164 */             ,this
/* 165 */         );
/* 166 */ 
/* 167 */         return rez;
/* 168 */     }
/* 169 */ 
/* 170 */     /**
/* 171 *|      * get new collumns config for the grid panel
/* 172 *|      * @return array
/* 173 *|      */
/* 174 */     ,getNewColumns: function(){
/* 175 */         var rez = [] //Ext.apply([], this.defaultColumns)
/* 176 */             ,currentColumns = Ext.apply({}, this.currentColumns)
/* 177 */             ,i
/* 178 */             ,refs = {}
/* 179 */             ,emptyCurrentColumns = (Ext.encode(currentColumns) === '{}');
/* 180 */ 
/* 181 */         //create column refs for convenient use
/* 182 */         for (i = 0; i < this.defaultColumns.length; i++) {
/* 183 */             refs[this.defaultColumns[i].dataIndex] = this.defaultColumns[i];
/* 184 */         }
/* 185 */ 
/* 186 */         /*for (i = 0; i < rez.length; i++) {
/* 187 *|             if(Ext.isDefined(currentColumns[rez[i].dataIndex])) {
/* 188 *|                 var nd = currentColumns[rez[i].dataIndex];
/* 189 *| 
/* 190 *|                 delete rez[i].hidden;
/* 191 *| 
/* 192 *|                 rez[i] = Ext.apply(rez[i], nd);
/* 193 *| 
/* 194 *|                 if(nd.width && rez[i].setWidth) {
/* 195 *|                     rez[i].setWidth(nd.width);
/* 196 *|                 }
/* 197 *| 
/* 198 *|                 delete currentColumns[rez[i].dataIndex];
/* 199 *| 
/* 200 *|             } else if(!emptyCurrentColumns) {

/* DisplayColumns.js *|

/* 201 *|                 rez[i].hidden = true;
/* 202 *|             }
/* 203 *|         }/**/
/* 204 */ 
/* 205 */         Ext.iterate(
/* 206 */             currentColumns
/* 207 */             ,function(key, value, obj){
/* 208 */                 var column = value;
/* 209 */                 if(key !== 'remove') {
/* 210 */                     // column.id = rez.length;
/* 211 */                     column.dataIndex = key;
/* 212 */                     // column.stateId = key;
/* 213 */                     column.header = Ext.valueFrom(column.header, column.title);
/* 214 */                     switch(column.type) {
/* 215 */                         case 'date':
/* 216 */                             column.renderer = App.customRenderers.datetime;
/* 217 */                             break;
/* 218 */ 
/* 219 */                         default:
/* 220 */                             // column.renderer = this.defaultColumnRenderer;
/* 221 */                     }
/* 222 */ 
/* 223 */                     if(this.owner.columnSortOverride) {
/* 224 */                         column.sort = this.owner.columnSortOverride;
/* 225 */                     }
/* 226 */ 
/* 227 */                     if(Ext.isDefined(refs[key])) {
/* 228 */                         Ext.applyIf(column, refs[key]);
/* 229 */                     }
/* 230 */ 
/* 231 */                     rez.push(column);
/* 232 */                 }
/* 233 */             }
/* 234 */             ,this
/* 235 */         );
/* 236 */ 
/* 237 */         //display name column if DC config is empty
/* 238 */         if(Ext.isEmpty(rez)) {
/* 239 */             rez = [refs.name];
/* 240 */         }
/* 241 */ 
/* 242 */         /* sort columns */
/* 243 */         var changed = rez.length > 1;
/* 244 */         var t;
/* 245 */ 
/* 246 */         i = 0;
/* 247 */         while(changed || (i < (rez.length - 1))) {
/* 248 */             changed = false;
/* 249 */ 
/* 250 */             if((!Ext.isDefined(rez[i].idx) && Ext.isDefined(rez[i+1].idx)) ||

/* DisplayColumns.js */

/* 251 */                 (rez[i].idx > rez[i+1].idx)
/* 252 */             ) {
/* 253 */                 changed = true;
/* 254 */                 t = rez[i];
/* 255 */                 rez[i] = rez[i+1];
/* 256 */                 rez[i+1] = t;
/* 257 */                 i = -1;
/* 258 */             }
/* 259 */             i++;
/* 260 */         }
/* 261 */ 
/* 262 */         return rez;
/* 263 */     }
/* 264 */ 
/* 265 */     /**
/* 266 *|      * extract field names array from a fields config array
/* 267 *|      * @param  array fieldsArray
/* 268 *|      * @return array
/* 269 *|      */
/* 270 */     ,extractFieldNames: function(fieldsArray){
/* 271 */         var rez = [];
/* 272 */         Ext.each(
/* 273 */             fieldsArray
/* 274 */             ,function(i){
/* 275 */                 if(Ext.isObject(i)){
/* 276 */                     rez.push(i.name);
/* 277 */                 } else {
/* 278 */                     rez.push(i);
/* 279 */                 }
/* 280 */             }
/* 281 */             ,this
/* 282 */         );
/* 283 */         return rez;
/* 284 */     }
/* 285 */     // ,defaultColumnRenderer: function (v, meta, record, row_idx, col_idx, store) {
/* 286 */     //     return record.json[this.dataIndex];
/* 287 */     // }
/* 288 */ });
/* 289 */ 

;
/* Init.js */

/* 1  */ Ext.namespace('CB.plugin.Export');
/* 2  */ 
/* 3  */ CB.plugin.Export.init = function(){
/* 4  */     App.on('browserinit', function(c){
/* 5  */         var p = Ext.apply([], Ext.valueFrom(c.plugins, []));
/* 6  */         p.push({ptype: 'CBPluginExportButton'});
/* 7  */         c.plugins = p;
/* 8  */     });
/* 9  */ };
/* 10 */ 
/* 11 */ Ext.onReady(CB.plugin.Export.init);
/* 12 */ 

;
/* Button.js */

/* 1  */ Ext.namespace('CB.plugin.Export');
/* 2  */ 
/* 3  */ Ext.define('CB.plugin.Export.Button', {
/* 4  */     extend: 'CB.plugin.CustomInterface'
/* 5  */     ,alias: 'plugin.CBPluginExportButton'
/* 6  */ 
/* 7  */     ,init: function(owner) {
/* 8  */         CB.plugin.Export.Button.superclass.init.call(this, arguments);
/* 9  */         this.owner = owner;
/* 10 */ 
/* 11 */         owner.on('exportrecords', this.onExportRecordsEvent, this);
/* 12 */     }
/* 13 */ 
/* 14 */     ,onExportClick: function(b, e) {
/* 15 */         var params = Ext.clone(this.owner.params);
/* 16 */ 
/* 17 */         delete params.lastQuery;
/* 18 */ 
/* 19 */         params.from = 'grid';
/* 20 */ 
/* 21 */         window.open('/' + App.config.coreName + '/get/?export=' + Ext.encode(params));
/* 22 */     }
/* 23 */ 
/* 24 */     ,onExportRecordsEvent: function(cmp, e) {
/* 25 */         e.stopPropagation();
/* 26 */         this.onExportClick();
/* 27 */     }
/* 28 */ });
/* 29 */ 

;
/* Init.js */

/* 1  */ Ext.namespace('CB.plugin.Search');
/* 2  */ 
/* 3  */ CB.plugin.Search.init = function(){
/* 4  */     // App.on('cbinit', function(c){
/* 5  */     //     clog('count', CB.DB.templates.query('type', 'search').getCount());
/* 6  */ 
/* 7  */     //     /* check if we have search templates */
/* 8  */     //     if(CB.DB.templates.query('type', 'search').getCount() > 0) {
/* 9  */     //         var p = Ext.apply([], Ext.valueFrom(c.plugins, []));
/* 10 */     //         p.push({ptype: 'CBPluginSearchButton'});
/* 11 */     //         c.plugins = p;
/* 12 */     //     }
/* 13 */     // });
/* 14 */ };
/* 15 */ 
/* 16 */ // Ext.onReady(CB.plugin.Search.init);
/* 17 */ 

;
/* Button.js */

/* 1  */ Ext.namespace('CB.plugin.Search');
/* 2  */ 
/* 3  */ Ext.define('CB.plugin.Search.Button', {
/* 4  */     extend: 'CB.plugin.CustomInterface'
/* 5  */ 
/* 6  */     ,alias: 'plugin.CBPluginSearchButton'
/* 7  */ 
/* 8  */     ,ptype: 'CBPluginSearchButton'
/* 9  */ 
/* 10 */     ,init: function(owner) {
/* 11 */ 
/* 12 */         this.historyData = {};
/* 13 */ 
/* 14 */         this.callParent(arguments);
/* 15 */ 
/* 16 */         this.owner = owner;
/* 17 */ 
/* 18 */         this.button = new Ext.Button({
/* 19 */             qtip: L.Search
/* 20 */             ,itemId: 'pluginsearchbutton'
/* 21 */             ,arrowVisible: false
/* 22 */             // ,arrowAlign: 'bottom'
/* 23 */             ,iconCls: 'ib-search-negative'
/* 24 */             ,scale: 'large'
/* 25 */             ,allowDepress: false
/* 26 */             ,hidden: true
/* 27 */             ,width: 20
/* 28 */             ,menuAlign: 'tl-tr'
/* 29 */             ,menu: []
/* 30 */             ,listeners: {
/* 31 */                 menushow: CB.ViewPort.prototype.onButtonMenuShow
/* 32 */             }
/* 33 */ 
/* 34 */         });
/* 35 */ 
/* 36 */         owner.insert(3, this.button);
/* 37 */ 
/* 38 */         if(App.initialized) {
/* 39 */             this.loadSearchTemplates();
/* 40 */         } else {
/* 41 */             App.on(
/* 42 */                 'cbinit'
/* 43 */                 ,this.loadSearchTemplates
/* 44 */                 ,this
/* 45 */             );
/* 46 */         }
/* 47 */     }
/* 48 */ 
/* 49 */     ,onButtonClick: function(b, e) {
/* 50 */         //load default search template if not already loaded

/* Button.js */

/* 51 */         var data = b.menu
/* 52 */             ? b.menu.items.getAt(0).config.data
/* 53 */             : b.config.data
/* 54 */ 
/* 55 */             ,config = {
/* 56 */                 xtype: 'CBSearchEditWindow'
/* 57 */                 ,id: 'sew' + data.template_id
/* 58 */             };
/* 59 */ 
/* 60 */         config.data = Ext.apply({}, data);
/* 61 */ 
/* 62 */         var w  = App.openWindow(config);
/* 63 */         if(!w.existing) {
/* 64 */             w.alignTo(App.mainViewPort.getEl(), 'bl-bl?');
/* 65 */         }
/* 66 */ 
/* 67 */         delete w.existing;
/* 68 */     }
/* 69 */ 
/* 70 */     ,loadSearchTemplates: function(){
/* 71 */         if(Ext.isEmpty(CB.DB.templates)) {
/* 72 */             return;
/* 73 */         }
/* 74 */ 
/* 75 */         var menu = this.button.menu;
/* 76 */             menu.removeAll(true);
/* 77 */         var templates = CB.DB.templates.query('type', 'search');
/* 78 */ 
/* 79 */         templates.each(
/* 80 */             function(t){
/* 81 */                 menu.add({
/* 82 */                     iconCls: t.data.iconCls
/* 83 */                     ,data: {template_id: t.data.id}
/* 84 */                     ,text: t.data.title
/* 85 */                     ,scope: this
/* 86 */                     ,handler: this.onButtonClick
/* 87 */                 });
/* 88 */             }
/* 89 */             ,this
/* 90 */         );
/* 91 */ 
/* 92 */         this.button.setVisible(menu.items.getCount() > 0);
/* 93 */     }
/* 94 */ });
/* 95 */ 

;
/* Form.js */

/* 1  */ Ext.namespace('CB.plugin.Search');
/* 2  */ 
/* 3  */ Ext.define('CB.plugin.Search.Form', {
/* 4  */     extend: 'Ext.Panel'
/* 5  */     ,title: L.Search
/* 6  */     ,id: 'SearchTab'
/* 7  */     ,iconCls: 'icon-search'
/* 8  */     ,closable: true
/* 9  */     ,scrollable: true
/* 10 */     ,tbarCssClass: 'x-panel-white'
/* 11 */     ,params: {}
/* 12 */ 
/* 13 */     ,initComponent: function(){
/* 14 */ 
/* 15 */         this.actions = {
/* 16 */             search: new Ext.Button({
/* 17 */                 text: L.Search
/* 18 */                 ,iconAlign:'top'
/* 19 */                 ,iconCls: 'ib-search'
/* 20 */                 ,scale: 'large'
/* 21 */                 ,scope: this
/* 22 */                 ,handler: this.onSearchButtonClick
/* 23 */             })
/* 24 */         };
/* 25 */ 
/* 26 */         /* objectsStore used to keep selected values from the grid for rendering after edit*/
/* 27 */         this.objectsStore = new CB.DB.ObjectsStore();
/* 28 */ 
/* 29 */         // Properties grid
/* 30 */         this.grid = Ext.create(
/* 31 */             'CBVerticalEditGrid'
/* 32 */             ,{
/* 33 */                 refOwner: this
/* 34 */                 ,autoHeight: true
/* 35 */             }
/* 36 */         );
/* 37 */ 
/* 38 */         // Init
/* 39 */         Ext.apply(this,{
/* 40 */             data: { template_id: this.data.template_id}
/* 41 */             ,tbar: [ this.actions.search]
/* 42 */             ,items:[this.grid]
/* 43 */             ,listeners: {
/* 44 */                 scope: this
/* 45 */                 ,beforerender: this.onAfterRender
/* 46 */             }
/* 47 */         });
/* 48 */ 
/* 49 */         CB.plugin.Search.Form.superclass.initComponent.apply(this, arguments);
/* 50 */     },

/* Form.js */

/* 51 */ 
/* 52 */     onSearchButtonClick: function(){
/* 53 */         this.grid.readValues();
/* 54 */         var t = App.openUniqueTabbedWidget(
/* 55 */             'CBPluginSearchResultForm'
/* 56 */             ,null
/* 57 */             ,{data: this.data}
/* 58 */         );
/* 59 */         if(t) {
/* 60 */             t.setParams(this.data);
/* 61 */         }
/* 62 */     },
/* 63 */ 
/* 64 */     onAfterRender: function(){
/* 65 */         for(var i in this.grid.colModel.config){
/* 66 */             var el = this.grid.colModel.config[i];
/* 67 */             if(el.dataIndex === 'info'){
/* 68 */                 el.editor = new Ext.form.ComboBox({
/* 69 */                     typeAhead: true
/* 70 */                     ,triggerAction: 'all'
/* 71 */                     ,editable: true
/* 72 */                     ,selectOnTab: true
/* 73 */                     ,store: ['', 'AND', 'OR', 'NOT']
/* 74 */                     ,lazyRender: true
/* 75 */                     ,listClass: 'x-combo-list-small'
/* 76 */                 });
/* 77 */                 el.header = L.SearchLogic;
/* 78 */             }
/* 79 */         }
/* 80 */         this.grid.reload();
/* 81 */     }
/* 82 */ });
/* 83 */ 

;
/* ResultForm.js */

/* 1  */ Ext.namespace('CB.plugin.Search');
/* 2  */ 
/* 3  */ Ext.define('CB.plugin.Search.ResultForm', {
/* 4  */     extend: 'CB.browser.ViewContainer'
/* 5  */     ,title: L.SearchResults
/* 6  */     ,iconCls: 'icon-search'
/* 7  */     ,closable: true
/* 8  */ 
/* 9  */     ,initComponent: function(){
/* 10 */         var config = {};
/* 11 */         if(CB.plugin.config && CB.plugin.config.Search) {
/* 12 */             config = CB.plugin.config.Search;
/* 13 */         }
/* 14 */         Ext.apply(this, config);
/* 15 */         CB.plugin.Search.ResultForm.superclass.initComponent.apply(this, arguments);
/* 16 */         if(!Ext.isEmpty(this.handler)) {
/* 17 */             var a = this.handler.split('.');
/* 18 */             this.store.proxy.setApi(
/* 19 */                 Ext.data.Api.actions.read
/* 20 */                 ,window[a[0]][a[1]]
/* 21 */             );
/* 22 */         }
/* 23 */     }
/* 24 */ });
/* 25 */ 
