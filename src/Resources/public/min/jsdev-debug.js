
/* app.js */

/* 1    */ Ext.namespace('App');
/* 2    */ Ext.BLANK_IMAGE_URL = '/css/i/s.gif';
/* 3    */ 
/* 4    */ var clog = function(){
/* 5    */     if(typeof(console) !== 'undefined') {
/* 6    */         console.log(arguments);
/* 7    */     }
/* 8    */ }
/* 9    */ ,plog = clog
/* 10   */ ,App;
/* 11   */ 
/* 12   */ // application main entry point
/* 13   */ Ext.onReady(function(){
/* 14   */ 
/* 15   */     App = new Ext.util.Observable();
/* 16   */ 
/* 17   */     App.controller = Ext.create({
/* 18   */         xtype: 'browsingcontroller'
/* 19   */     });
/* 20   */ 
/* 21   */     //set shortcuts to methods that were moved to controller
/* 22   */     //for backward compatibility. To be removed later
/* 23   */     App.locateObject = Ext.Function.bind(App.controller.locateObject, App.controller);
/* 24   */     App.openPath = Ext.Function.bind(App.controller.openPath, App.controller);
/* 25   */ 
/* 26   */     // used for charts
/* 27   */     App.colors = ["#3A84CB", "#94ae0a", "#115fa6","#a61120", "#ff8809", "#ffd13e", "#a61187", "#24ad9a", "#7c7474", "#a66111"];
/* 28   */ 
/* 29   */     App.historyController = Ext.create({
/* 30   */         xtype: 'historycontroller'
/* 31   */     });
/* 32   */ 
/* 33   */     initApp();
/* 34   */ 
/* 35   */     Ext.Date.use24HourTime = true;
/* 36   */ 
/* 37   */     Ext.direct.Manager.addProvider(Ext.app.REMOTING_API);
/* 38   */ 
/* 39   */     Ext.state.Manager.setProvider(
/* 40   */         new CB.state.DBProvider()
/* 41   */     );
/* 42   */ 
/* 43   */     Ext.Direct.on('login', function(r, e){
/* 44   */         Ext.Msg.alert(L.Error, L.SessionExpired);
/* 45   */     });
/* 46   */     Ext.Direct.on('exception', App.showException);
/* 47   */     Ext.QuickTips.init();
/* 48   */     Ext.apply(Ext.QuickTips.getQuickTip(), {showDelay: 1500});
/* 49   */ 
/* 50   */     setTimeout(function(){

/* app.js */

/* 51   */         Ext.get('loading').remove();
/* 52   */     }, 10);
/* 53   */ 
/* 54   */     CB_User.getLoginInfo( function(r, e){
/* 55   */         if(!r || (r.success !== true)) {
/* 56   */             return;
/* 57   */         }
/* 58   */ 
/* 59   */         /* use this session id as appended query string for images that reload form session to session
/* 60   *|             Such kind of images are user photos that could be updated.
/* 61   *|         */
/* 62   */         App.sid = '&qq=' + Date.parse(new Date());
/* 63   */         App.config = r.config;
/* 64   */         App.loginData = r.user;
/* 65   */ 
/* 66   */         // App.loginData.iconCls = 'icon-user-' + Ext.valueFrom(r.user.sex, '');
/* 67   */         App.loginData.iconCls = 'icon-user-account';
/* 68   */ 
/* 69   */         if(App.loginData.cfg.short_date_format) {
/* 70   */             App.dateFormat = App.loginData.cfg.short_date_format;
/* 71   */         }
/* 72   */ 
/* 73   */         if(App.loginData.cfg.long_date_format) {
/* 74   */             App.longDateFormat = App.loginData.cfg.long_date_format;
/* 75   */         }
/* 76   */ 
/* 77   */         if(App.loginData.cfg.time_format) {
/* 78   */             App.timeFormat = App.loginData.cfg.time_format;
/* 79   */         }
/* 80   */ 
/* 81   */         App.mainViewPort = new CB.ViewPort({
/* 82   */             rtl: (App.config.rtl === true)
/* 83   */         });
/* 84   */ 
/* 85   */         App.mainViewPort.doLayout();
/* 86   */         App.mainViewPort.initCB(r, e);
/* 87   */     });
/* 88   */ 
/* 89   */ 
/* 90   */     //Monitor mouse down/up for grid view to avoid selection change when dragging
/* 91   */     App.mouseDown = 0;
/* 92   */     document.body.onmousedown = function(ev) {
/* 93   */         App.lastMouseButton = ev.button;
/* 94   */         ++App.mouseDown;
/* 95   */     };
/* 96   */ 
/* 97   */     document.body.onmouseup = function() {
/* 98   */         --App.mouseDown;
/* 99   */     };
/* 100  */ 

/* app.js */

/* 101  */ });
/* 102  */ 
/* 103  */ //-------------------------------------------- application initialization function
/* 104  */ function initApp() {
/* 105  */     App.dateFormat = 'd.m.Y';
/* 106  */     App.longDateFormat = 'j F Y';
/* 107  */     App.timeFormat = 'H:i';
/* 108  */ 
/* 109  */     App.shortenString = function (st, maxLen) {
/* 110  */         if(Ext.isEmpty(st)) {
/* 111  */             return '';
/* 112  */         }
/* 113  */         st = Ext.util.Format.stripTags(st);
/* 114  */         return Ext.util.Format.ellipsis(st, maxLen);
/* 115  */     };
/* 116  */ 
/* 117  */     App.shortenStringLeft = function (st, maxLen) {
/* 118  */         if(Ext.isEmpty(st)) {
/* 119  */             return '';
/* 120  */         }
/* 121  */         st = Ext.util.Format.stripTags(st);
/* 122  */         st = st.split('').reverse().join('');
/* 123  */         st = Ext.util.Format.ellipsis(st, maxLen);
/* 124  */         return st.split('').reverse().join('');
/* 125  */     };
/* 126  */ 
/* 127  */     App.PromtLogin = function (e){
/* 128  */         if (!this.loginWindow || this.loginWindow.isDestroyed) {
/* 129  */             this.loginWindow = new CB.Login({});
/* 130  */         }
/* 131  */ 
/* 132  */         this.loginWindow.show();
/* 133  */     };
/* 134  */ 
/* 135  */     App.formSubmitFailure = function(form, action){
/* 136  */         var msg;
/* 137  */         if(App.hideFailureAlerts) {
/* 138  */             return;
/* 139  */         }
/* 140  */ 
/* 141  */         switch (action.failureType) {
/* 142  */             case Ext.form.Action.CLIENT_INVALID:
/* 143  */                 msg = 'Form fields may not be submitted with invalid values';
/* 144  */                 break;
/* 145  */ 
/* 146  */             case Ext.form.Action.CONNECT_FAILURE:
/* 147  */                 msg = 'Ajax communication failed';
/* 148  */                 break;
/* 149  */ 
/* 150  */             case Ext.form.Action.SERVER_INVALID:

/* app.js */

/* 151  */                msg = Ext.valueFrom(action.msg, action.result.msg);
/* 152  */                msg = Ext.valueFrom(msg, L.ErrorOccured);
/* 153  */         }
/* 154  */         Ext.Msg.alert(L.Error, msg);
/* 155  */     };
/* 156  */ 
/* 157  */     App.includeJS = function(file){
/* 158  */         if (document.createElement && document.getElementsByTagName) {
/* 159  */             var head = document.getElementsByTagName('head')[0];
/* 160  */ 
/* 161  */             var script = document.createElement('script');
/* 162  */             script.setAttribute('type', 'text/javascript');
/* 163  */             script.setAttribute('src', file);
/* 164  */ 
/* 165  */             head.appendChild(script);
/* 166  */         } else {
/* 167  */             alert('Your browser can\'t deal with the DOM standard. That means it\'s old. Go fix it!');
/* 168  */         }
/* 169  */     };
/* 170  */ 
/* 171  */     App.xtemplates = {
/* 172  */         cell: new Ext.XTemplate( '<ul class="thesauri_set"><tpl for="."><li>{.}</li></tpl></ul>' )
/* 173  */         ,object: new Ext.XTemplate( '<ul class="clean"><tpl for="."><li class="case_object" object_id="{id}">{[Ext.isEmpty(values.name) ? \'&lt;'+L.noName+'&gt; (id: \'+values.id+\')\' : values.name]}</li></tpl></ul>' )
/* 174  */     };
/* 175  */     App.xtemplates.cell.compile();
/* 176  */     App.xtemplates.object.compile();
/* 177  */ 
/* 178  */     App.customRenderers = {
/* 179  */         thesauriCell: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 180  */             if(Ext.isEmpty(v)) {
/* 181  */                 return '';
/* 182  */             }
/* 183  */             var va = v.split(',');
/* 184  */             var vt = []
/* 185  */                 ,thesauriId = grid.helperTree.getNode(record.get('id')).data.templateRecord.get('cfg').thesauriId;
/* 186  */ 
/* 187  */             if(Ext.isEmpty(thesauriId) && store.thesauriIds) {
/* 188  */                 thesauriId = store.thesauriIds[record.id];
/* 189  */             }
/* 190  */ 
/* 191  */             if(!Ext.isEmpty(thesauriId)){
/* 192  */                 var ts = getThesauriStore(thesauriId)
/* 193  */                     ,idx;
/* 194  */                 for (var i = 0; i < va.length; i++) {
/* 195  */                     idx = ts.findExact('id', parseInt(va[i], 10));
/* 196  */                     if(idx >=0) {
/* 197  */                         vt.push(ts.getAt(idx).get('name'));
/* 198  */                     }
/* 199  */                 }
/* 200  */             }

/* app.js */

/* 201  */ 
/* 202  */             return App.xtemplates.cell.apply(vt);
/* 203  */         }
/* 204  */ 
/* 205  */         ,relatedCell: function(v, metaData, record, rowIndex, colIndex, store) { }
/* 206  */ 
/* 207  */         ,combo: function(v, metaData, record, rowIndex, colIndex, store) {
/* 208  */             if(Ext.isEmpty(v)) {
/* 209  */                 return '';
/* 210  */             }
/* 211  */ 
/* 212  */             var ed = this.editor
/* 213  */                 ,r = ed.store.findRecord(ed.valueField, v, 0, false, false, true);
/* 214  */ 
/* 215  */             if(!r) {
/* 216  */                 return '';
/* 217  */             }
/* 218  */ 
/* 219  */             return r.get(ed.displayField);
/* 220  */         }
/* 221  */ 
/* 222  */         ,objectsField: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 223  */             if(Ext.isEmpty(v)) {
/* 224  */                 return '';
/* 225  */             }
/* 226  */ 
/* 227  */             store = null;
/* 228  */ 
/* 229  */             var rec
/* 230  */                 ,row
/* 231  */                 ,ri
/* 232  */                 ,r = []
/* 233  */                 ,va = toNumericArray(v)
/* 234  */                 ,cfg = grid.helperTree.getNode(record.get('id')).data.templateRecord.get('cfg')
/* 235  */                 ,source = (Ext.isEmpty(cfg.source))
/* 236  */                     ? 'tree'
/* 237  */                     : cfg.source;
/* 238  */             if(Ext.isEmpty(va) && Ext.isPrimitive(v)) {
/* 239  */                 va = [v];
/* 240  */             }
/* 241  */ 
/* 242  */             switch(source){
/* 243  */                 case 'thesauri':
/* 244  */                     store = isNaN(cfg.thesauriId) ? CB.DB.thesauri : getThesauriStore(cfg.thesauriId);
/* 245  */                     break;
/* 246  */                 case 'users':
/* 247  */                     store = CB.DB.usersStore;
/* 248  */                     break;
/* 249  */                 case 'groups':
/* 250  */                     store = CB.DB.groupsStore;

/* app.js */

/* 251  */                     break;
/* 252  */                 default:
/* 253  */                     var cw = null;
/* 254  */                     if(grid && grid.findParentByType) {
/* 255  */                         cw = grid.refOwner || grid.findParentByType(CB.Objects);
/* 256  */                     }
/* 257  */                     if(!cw || !cw.objectsStore) {
/* 258  */                         return '';
/* 259  */                     }
/* 260  */                     store = cw.objectsStore;
/* 261  */             }
/* 262  */ 
/* 263  */             switch(cfg.renderer){
/* 264  */                 case 'listGreenIcons':
/* 265  */                     for(i=0; i < va.length; i++){
/* 266  */                         row = store.findRecord('id', va[i], 0, false, false, true);
/* 267  */                         if(row) {
/* 268  */                             r.push('<li class="lh16 icon-padding icon-element">'+row.get('name')+'</li>');
/* 269  */                         }
/* 270  */                     }
/* 271  */                     return '<ul class="clean">'+r.join('')+'</ul>';
/* 272  */                 case 'listObjIcons':
/* 273  */                     for(i=0; i < va.length; i++){
/* 274  */                         row = store.findRecord('id', va[i], 0, false, false, true);
/* 275  */                         if(row) {
/* 276  */                             var icon = row.get('cfg');
/* 277  */                             if(!Ext.isEmpty(icon)) {
/* 278  */                                 icon = icon.iconCls;
/* 279  */                             }
/* 280  */                             if(Ext.isEmpty(icon)) {
/* 281  */                                 icon = row.get('iconCls');
/* 282  */                             }
/* 283  */                             r.push('<li class="lh16 icon-padding '+icon+'">'+row.get('name')+'</li>');
/* 284  */                         }
/* 285  */                     }
/* 286  */                     return '<ul class="clean">'+r.join('')+'</ul>';
/* 287  */ 
/* 288  */                 default:
/* 289  */                     for(i=0; i < va.length; i++){
/* 290  */                         rec = store.findRecord('id', va[i], 0, false, false, true);
/* 291  */ 
/* 292  */                         if(rec) {
/* 293  */                             r.push(rec.get('name'));
/* 294  */                         } else {
/* 295  */                             r.push(va[i]); //display id if nothing found (useful for custom sources)
/* 296  */                         }
/* 297  */                     }
/* 298  */                     return r.join(', ');
/* 299  */             }
/* 300  */ 

/* app.js */

/* 301  */         }
/* 302  */ 
/* 303  */         ,languageCombo: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 304  */             if(Ext.isEmpty(v)) {
/* 305  */                 return '';
/* 306  */             }
/* 307  */ 
/* 308  */             var ri = CB.DB.languages.findExact('id', parseInt(v, 10));
/* 309  */ 
/* 310  */             if(ri < 0) {
/* 311  */                 return '';
/* 312  */             }
/* 313  */ 
/* 314  */             return CB.DB.languages.getAt(ri).get('name');
/* 315  */         }
/* 316  */ 
/* 317  */         ,sexCombo: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 318  */             if(Ext.isEmpty(v)) {
/* 319  */                 return '';
/* 320  */             }
/* 321  */             var ri = CB.DB.sex.findExact('id', v);
/* 322  */ 
/* 323  */             if(ri < 0) {
/* 324  */                 return '';
/* 325  */             }
/* 326  */ 
/* 327  */             return CB.DB.sex.getAt(ri).get('name');
/* 328  */         }
/* 329  */ 
/* 330  */         ,shortDateFormatCombo: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 331  */             if(Ext.isEmpty(v)) {
/* 332  */                 return '';
/* 333  */             }
/* 334  */ 
/* 335  */             var ri = CB.DB.shortDateFormats.findExact('id', v);
/* 336  */ 
/* 337  */             if(ri < 0) {
/* 338  */                 return '';
/* 339  */             }
/* 340  */ 
/* 341  */             return CB.DB.shortDateFormats.getAt(ri).get('name');
/* 342  */         }
/* 343  */ 
/* 344  */         ,thesauriCombo: function(v, metaData, record, rowIndex, colIndex, store, grid) {
/* 345  */             if(Ext.isEmpty(v)) {
/* 346  */                 return '';
/* 347  */             }
/* 348  */             var node = grid.helperTree.getNode(record.get('id'))
/* 349  */                 ,tr = node.data.templateRecord
/* 350  */                 ,th = tr.get('cfg').thesauriId;

/* app.js */

/* 351  */ 
/* 352  */             if(th === 'dependent'){
/* 353  */                 th = grid.helperTree.getParentValue(node, tr.get('pid'));
/* 354  */             }
/* 355  */             var ts = getThesauriStore(th)
/* 356  */                 ,ri = ts.findExact('id', parseInt(v, 10));
/* 357  */ 
/* 358  */             if(ri < 0) {
/* 359  */                 return '';
/* 360  */             }
/* 361  */ 
/* 362  */             return ts.getAt(ri).get('name');
/* 363  */         }
/* 364  */ 
/* 365  */         ,checkbox: function(v){
/* 366  */             if(v == 1) {
/* 367  */                 return L.yes;
/* 368  */             }
/* 369  */ 
/* 370  */             if(v == -1) {
/* 371  */                 return L.no;
/* 372  */             }
/* 373  */ 
/* 374  */             return '';
/* 375  */         }
/* 376  */ 
/* 377  */         ,date: function(v){
/* 378  */             var rez = '';
/* 379  */             if(Ext.isEmpty(v)) {
/* 380  */                 return rez;
/* 381  */             }
/* 382  */ 
/* 383  */             rez = Ext.Date.format(
/* 384  */                 Ext.isPrimitive(v)
/* 385  */                     ? Ext.Date.parse(v.substr(0,10), 'Y-m-d')
/* 386  */                     : v
/* 387  */                 ,App.dateFormat
/* 388  */             );
/* 389  */ 
/* 390  */             return rez;
/* 391  */         }
/* 392  */         /**
/* 393  *|          * [datetime description]
/* 394  *|          * @param  varchar v
/* 395  *|          * @param  {[type]} showZeroTime [description]
/* 396  *|          * @return {[type]}              [description]
/* 397  *|          */
/* 398  */         ,datetime: function(v, showZeroTime){
/* 399  */             var rez = '';
/* 400  */             if(Ext.isEmpty(v)) {

/* app.js */

/* 401  */                 return rez;
/* 402  */             }
/* 403  */ 
/* 404  */             rez = Ext.isPrimitive(v)
/* 405  */                 ? date_ISO_to_local_date(v)
/* 406  */                 : v;
/* 407  */ 
/* 408  */             var s = rez.toISOString();
/* 409  */             if(s.substr(-14) === 'T00:00:00.000Z') {
/* 410  */                 rez = Ext.Date.clearTime(rez, true);
/* 411  */             }
/* 412  */ 
/* 413  */             rez = Ext.Date.format(rez, App.dateFormat + ' ' + App.timeFormat);
/* 414  */             if(Ext.isEmpty(rez)) {
/* 415  */                 return '';
/* 416  */             }
/* 417  */ 
/* 418  */             if(showZeroTime === false) {
/* 419  */                 if(rez.substr(-5, 5) === '00:00') {
/* 420  */                     rez = rez.substr(0, rez.length - 6);
/* 421  */                 }
/* 422  */             }
/* 423  */ 
/* 424  */             return rez;
/* 425  */         }
/* 426  */ 
/* 427  */         ,time: function(v, meta){
/* 428  */             if(Ext.isEmpty(v)) {
/* 429  */                 return '';
/* 430  */             }
/* 431  */ 
/* 432  */             if(Ext.isPrimitive(v)) {
/* 433  */                 v = Ext.Date.parse(v, 'H:i:s');
/* 434  */             }
/* 435  */ 
/* 436  */             var format = (meta.fieldConfig && meta.fieldConfig.format)
/* 437  */                 ? meta.fieldConfig.format
/* 438  */                 : App.timeFormat;
/* 439  */ 
/* 440  */             return Ext.Date.format(v, format);
/* 441  */         }
/* 442  */ 
/* 443  */         ,filesize: function(v){
/* 444  */             if(isNaN(v) || Ext.isEmpty(v) || (v === '0') || (v <= 0)) {
/* 445  */                 return '';
/* 446  */             }
/* 447  */ 
/* 448  */             if(v <= 0) {
/* 449  */                 return  '0 KB';
/* 450  */             } else if(v < 1024) {

/* app.js */

/* 451  */                 return '1 KB';
/* 452  */             } else if(v < 1024 * 1024) {
/* 453  */                 return (Math.round(v / 1024) + ' KB');
/* 454  */             } else {
/* 455  */                 var n = v / (1024 * 1024);
/* 456  */                 return (n.toFixed(2) + ' MB');
/* 457  */             }
/* 458  */         }
/* 459  */ 
/* 460  */         ,tags: function(v, m, r, ri, ci, s){
/* 461  */             if(Ext.isEmpty(v)) {
/* 462  */                 return '';
/* 463  */             }
/* 464  */ 
/* 465  */             var rez = [];
/* 466  */ 
/* 467  */             Ext.each(
/* 468  */                 v
/* 469  */                 ,function(i){
/* 470  */                     rez.push(i.name);
/* 471  */                 }
/* 472  */                 ,this
/* 473  */             );
/* 474  */ 
/* 475  */             rez = rez.join(', ');
/* 476  */ 
/* 477  */             m.attr = 'name="' + rez.replace(/"/g, '&quot;') + '"';
/* 478  */ 
/* 479  */             return rez;
/* 480  */         }
/* 481  */ 
/* 482  */         ,tagIds: function(v){
/* 483  */             if(Ext.isEmpty(v)) {
/* 484  */                 return '';
/* 485  */             }
/* 486  */ 
/* 487  */             var rez = [];
/* 488  */ 
/* 489  */             v = String(v).split(',');
/* 490  */ 
/* 491  */             Ext.each(
/* 492  */                 v
/* 493  */                 ,function(i){
/* 494  */                     rez.push(CB.DB.thesauri.getName(i));
/* 495  */                 }
/* 496  */                 ,this
/* 497  */             );
/* 498  */ 
/* 499  */             rez = rez.join(', ');
/* 500  */ 

/* app.js */

/* 501  */             return rez;
/* 502  */         }
/* 503  */ 
/* 504  */         ,importance: function(v){
/* 505  */             if(Ext.isEmpty(v)) {
/* 506  */                 return '';
/* 507  */             }
/* 508  */ 
/* 509  */             return CB.DB.importance.getName(v);
/* 510  */         }
/* 511  */ 
/* 512  */         ,timeUnits: function(v){
/* 513  */             if(Ext.isEmpty(v)) {
/* 514  */                 return '';
/* 515  */             }
/* 516  */ 
/* 517  */             return CB.DB.timeUnits.getName(v);
/* 518  */         }
/* 519  */ 
/* 520  */         ,taskStatus: function(v, m, r, ri, ci, s){
/* 521  */             if(Ext.isEmpty(v)) {
/* 522  */                 return '';
/* 523  */             }
/* 524  */             return '<span class="taskStatus'+v+'">'+L['taskStatus'+parseInt(v, 10)]+'</span>';
/* 525  */         }
/* 526  */ 
/* 527  */         ,text: function(v, m, r, ri, ci, s){
/* 528  */             if(Ext.isEmpty(v)) {
/* 529  */                 return '';
/* 530  */             }
/* 531  */             return '<pre style="white-space: pre-wrap">' + v + '</pre>';
/* 532  */         }
/* 533  */         ,titleAttribute: function(v, m, r, ri, ci, s){
/* 534  */             m.tdAttr = Ext.isEmpty(v) ? '' : 'title="'+Ext.util.Format.stripTags(v).replace(/"/g,"&quot;")+'"';
/* 535  */             return v;
/* 536  */         }
/* 537  */         ,userName: function(v){ return CB.DB.usersStore.getName(v);}
/* 538  */         ,iconcombo: function(v){
/* 539  */             if(Ext.isEmpty(v)) {
/* 540  */                 return '';
/* 541  */             }
/* 542  */             return '<img src="/css/i/s.gif" class="icon '+v+'" /> '+v;
/* 543  */         }
/* 544  */     };
/* 545  */ 
/* 546  */     App.getCustomRenderer = function(fieldType){
/* 547  */         switch(fieldType){
/* 548  */             case 'checkbox':
/* 549  */                 return App.customRenderers.checkbox;
/* 550  */             case 'date':

/* app.js */

/* 551  */                 return App.customRenderers.date;
/* 552  */             case 'datetime':
/* 553  */                 return App.customRenderers.datetime;
/* 554  */             case 'time':
/* 555  */                 return App.customRenderers.time;
/* 556  */             case '_objects':
/* 557  */                 return App.customRenderers.objectsField;
/* 558  */             case 'combo':
/* 559  */             case '_language':
/* 560  */                 return App.customRenderers.languageCombo;
/* 561  */             case '_sex':
/* 562  */                 return App.customRenderers.sexCombo;
/* 563  */             case 'importance':
/* 564  */                 return App.customRenderers.importance;
/* 565  */             case 'timeunits':
/* 566  */                 return App.customRenderers.timeUnits;
/* 567  */             case '_templateTypesCombo':
/* 568  */                 return Ext.Function.bind(CB.DB.templateTypes.getName, CB.DB.templateTypes);
/* 569  */             case '_fieldTypesCombo':
/* 570  */                 return Ext.Function.bind(CB.DB.fieldTypes.getName, CB.DB.fieldTypes);
/* 571  */             case '_short_date_format':
/* 572  */                 return App.customRenderers.shortDateFormatCombo;
/* 573  */             case 'memo':
/* 574  */             case 'text':
/* 575  */                 return App.customRenderers.text;
/* 576  */             default: return null;
/* 577  */         }
/* 578  */     };
/* 579  */ 
/* 580  */     App.getTemplatesXTemplate = function(template_id){
/* 581  */ 
/* 582  */         template_id = String(template_id);
/* 583  */ 
/* 584  */         if(!Ext.isDefined(App.templatesXTemplate)) {
/* 585  */             App.templatesXTemplate = {};
/* 586  */         }
/* 587  */ 
/* 588  */         if(App.templatesXTemplate[template_id]) {
/* 589  */             return App.templatesXTemplate[template_id];
/* 590  */         }
/* 591  */ 
/* 592  */         var idx = CB.DB.templates.findExact('id', template_id);
/* 593  */ 
/* 594  */         if(idx >= 0){
/* 595  */             var r = CB.DB.templates.getAt(idx)
/* 596  */                 ,it = r.get('info_template');
/* 597  */ 
/* 598  */             if(!Ext.isEmpty(it)){
/* 599  */                 App.templatesXTemplate[template_id] = new Ext.XTemplate(it);
/* 600  */                 App.templatesXTemplate[template_id].compile();

/* app.js */

/* 601  */                 return App.templatesXTemplate[template_id];
/* 602  */             }
/* 603  */         }
/* 604  */ 
/* 605  */         return App.xtemplates.object;
/* 606  */     };
/* 607  */ 
/* 608  */     App.findTab = function(tabPanel, id, xtype){
/* 609  */         var tabIdx = -1
/* 610  */             ,i = 0;
/* 611  */ 
/* 612  */         if(!Ext.isEmpty(id)) {
/* 613  */             while((tabIdx == -1) && (i < tabPanel.items.getCount())){
/* 614  */                 var o = tabPanel.items.get(i);
/* 615  */                 if(Ext.isEmpty(xtype) || ( o.isXType && o.isXType(xtype) ) ){
/* 616  */                     if(Ext.isDefined(o.params) && Ext.isDefined(o.params.id) && (o.params.id == id)) {
/* 617  */                         tabIdx = i;
/* 618  */                     } else {
/* 619  */                         if(!Ext.isEmpty(o.data) && !Ext.isEmpty(o.data.id) && (o.data.id == id)) {
/* 620  */                             tabIdx = i;
/* 621  */                         }
/* 622  */                     }
/* 623  */                 }
/* 624  */                 i++;
/* 625  */             }
/* 626  */         }
/* 627  */ 
/* 628  */         return tabIdx;
/* 629  */     };
/* 630  */ 
/* 631  */     App.findTabByType = function(tabPanel, type){
/* 632  */         var tabIdx = -1
/* 633  */             ,i= 0;
/* 634  */ 
/* 635  */         if(!Ext.isEmpty(type)) {
/* 636  */             while((tabIdx == -1) && (i < tabPanel.items.getCount())){
/* 637  */                 var o = tabPanel.items.get(i);
/* 638  */                 if(Ext.isDefined(o.isXType) && o.isXType(type)) {
/* 639  */                     tabIdx = i;
/* 640  */                 }
/* 641  */                 i++;
/* 642  */             }
/* 643  */         }
/* 644  */ 
/* 645  */         return tabIdx;
/* 646  */     };
/* 647  */ 
/* 648  */     App.activateTab = function(tabPanel, id, xtype){
/* 649  */         if(Ext.isEmpty(tabPanel)) {
/* 650  */             tabPanel = App.mainTabPanel;

/* app.js */

/* 651  */         }
/* 652  */ 
/* 653  */         var tabIdx = App.findTab(tabPanel, id, xtype);
/* 654  */ 
/* 655  */         if(tabIdx < 0) {
/* 656  */             return false;
/* 657  */         }
/* 658  */         tabPanel.setActiveTab(tabIdx);
/* 659  */ 
/* 660  */         return tabPanel.items.getAt(tabIdx);
/* 661  */     };
/* 662  */ 
/* 663  */     App.addTab = function(tabPanel, o){
/* 664  */         if(Ext.isEmpty(tabPanel)) {
/* 665  */             tabPanel = App.mainTabPanel;
/* 666  */         }
/* 667  */ 
/* 668  */         var c = tabPanel.add(o);
/* 669  */         o.show();
/* 670  */         tabPanel.setActiveTab(c);
/* 671  */ 
/* 672  */         return c;
/* 673  */     };
/* 674  */ 
/* 675  */     App.getHtmlEditWindow = function(config){
/* 676  */         if(!App.htmlEditWindow) {
/* 677  */             App.htmlEditWindow = new CB.HtmlEditWindow();
/* 678  */         }
/* 679  */ 
/* 680  */         App.htmlEditWindow = Ext.apply(App.htmlEditWindow, config);
/* 681  */ 
/* 682  */         return App.htmlEditWindow;
/* 683  */     };
/* 684  */ 
/* 685  */     App.openObjectWindow = function(config) {
/* 686  */         //at least template should be defined in config
/* 687  */         if(Ext.isEmpty(config)) {
/* 688  */             return;
/* 689  */         }
/* 690  */ 
/* 691  */         if(Ext.isEmpty(config.template_id)) {
/* 692  */             return Ext.Msg.alert(
/* 693  */                 'Error opening object'
/* 694  */                 ,'Template should be specified for object window to load.'
/* 695  */             );
/* 696  */         }
/* 697  */ 
/* 698  */         config.id = Ext.valueFrom(config.target_id, config.id);
/* 699  */ 
/* 700  */         var templateType = CB.DB.templates.getType(config.template_id)

/* app.js */

/* 701  */             ,wndCfg = {
/* 702  */                 xtype: (templateType === 'file'
/* 703  */                     ? 'CBFileEditWindow'
/* 704  */                     : 'CBObjectEditWindow'
/* 705  */                 )
/* 706  */                 ,data: config
/* 707  */             };
/* 708  */ 
/* 709  */         wndCfg.id = 'oew-' +
/* 710  */             (Ext.isEmpty(config.id)
/* 711  */                 ? Ext.id()
/* 712  */                 : config.id
/* 713  */             );
/* 714  */ 
/* 715  */         var w = App.openWindow(wndCfg)
/* 716  */             ,winHeight = window.innerHeight;
/* 717  */ 
/* 718  */         if(w) {
/* 719  */             if((winHeight > 0) && (w.getHeight() > winHeight)) {
/* 720  */                 w.setHeight(winHeight - 20);
/* 721  */             }
/* 722  */ 
/* 723  */             if(templateType === 'file') {
/* 724  */                 w.center();
/* 725  */ 
/* 726  */                 if(config.name && (detectFileEditor(config.name) !== false)) {
/* 727  */                     w.maximize();
/* 728  */                 }
/* 729  */             } else if(!w.existing) {
/* 730  */                 App.alignWindowNext(w);
/* 731  */             }
/* 732  */ 
/* 733  */             delete w.existing;
/* 734  */         }
/* 735  */     };
/* 736  */ 
/* 737  */     App.openWindow = function(wndCfg) {
/* 738  */         var w = Ext.getCmp(wndCfg.id);
/* 739  */ 
/* 740  */         if(w) {
/* 741  */             App.mainStatusBar.setActiveButton(w.taskButton);
/* 742  */             App.mainStatusBar.restoreWindow(w);
/* 743  */             //set a flag that this was an existing window
/* 744  */             w.existing = true;
/* 745  */ 
/* 746  */         } else {
/* 747  */             w = Ext.create(wndCfg);
/* 748  */             w.show();
/* 749  */ 
/* 750  */             w.taskButton = App.mainStatusBar.addTaskButton(w);

/* app.js */

/* 751  */         }
/* 752  */ 
/* 753  */         return w;
/* 754  */     };
/* 755  */ 
/* 756  */ 
/* 757  */     App.alignWindowNext = function (w) {
/* 758  */         w.alignTo(App.mainViewPort.getEl(), 'br-br?');
/* 759  */ 
/* 760  */         //get anchored position
/* 761  */         var pos = w.getXY();
/* 762  */         //move above status bar and a bit from right side
/* 763  */         pos[0] -= 15;
/* 764  */         pos[1] -= 5;
/* 765  */ 
/* 766  */         //position to the left of an active window if any
/* 767  */         var x = pos[0];
/* 768  */         App.mainStatusBar.windowBar.items.each(
/* 769  */             function(btn) {
/* 770  */                 if(btn.win && (btn.win != w) && btn.win.isVisible() && !btn.win.maximized && (btn.win.xtype !== 'CBSearchEditWindow')) {
/* 771  */                     var wx = btn.win.getX() - btn.win.el.getWidth() - 15;
/* 772  */                     if(x > wx) {
/* 773  */                         x = wx;
/* 774  */                     }
/* 775  */                 }
/* 776  */             }
/* 777  */             ,this
/* 778  */         );
/* 779  */         if(x < 15) {
/* 780  */             x = 15;
/* 781  */         }
/* 782  */         pos[0] = x;
/* 783  */ 
/* 784  */         w.setXY(pos);
/* 785  */     };
/* 786  */ 
/* 787  */     App.isFolder = function(template_id){
/* 788  */         return (App.config.folder_templates.indexOf( String(template_id) ) >= 0);
/* 789  */     };
/* 790  */ 
/* 791  */     App.isWebDavDocument = function(name){
/* 792  */         if(!Ext.isPrimitive(name) || Ext.isEmpty(name) || Ext.isEmpty(App.config['files.edit'].webdav)) {
/* 793  */             return false;
/* 794  */         }
/* 795  */         var ext = name.split('.').pop();
/* 796  */         return (App.config['files.edit'].webdav.indexOf(ext) >= 0);
/* 797  */     };
/* 798  */ 
/* 799  */     App.openWebdavDocument = function(data, checkCookie){
/* 800  */         var url = window.location.origin + '/dav/' + App.config.coreName + '/';

/* app.js */

/* 801  */ 
/* 802  */         url += 'edit-' + Ext.valueFrom(data.id, data.nid);
/* 803  */         url += '/' + data.name;
/* 804  */         App.confirmLeave = false;
/* 805  */ 
/* 806  */         if((checkCookie !== false) &&
/* 807  */             (Ext.util.Cookies.get('webdavHideDlg') == 1)
/* 808  */         ) {
/* 809  */             window.open('cbdav:' + url, '_self');
/* 810  */         } else {
/* 811  */             var w = new CB.WebdavWindow({
/* 812  */                 data: {link: url}
/* 813  */             });
/* 814  */             w.show();
/* 815  */             w.center();
/* 816  */         }
/* 817  */     };
/* 818  */ 
/* 819  */     App.activateBrowserTab = function(){
/* 820  */         var tab = App.mainTabPanel.getActiveTab();
/* 821  */ 
/* 822  */         if(tab.isXType('CBBrowserViewContainer')) {
/* 823  */             return tab;
/* 824  */         }
/* 825  */         App.mainTabPanel.setActiveTab(App.explorer);
/* 826  */         return App.explorer;
/* 827  */     };
/* 828  */ 
/* 829  */ 
/* 830  */     App.downloadFile = function(fileId, zipped, versionId){
/* 831  */         if(Ext.isElement(fileId)){
/* 832  */             //retreive id from html element
/* 833  */             fileId = fileId.id;
/* 834  */             zipped = false;
/* 835  */         }
/* 836  */ 
/* 837  */         var url = '/c/' + App.config.coreName + '/download/' + fileId;
/* 838  */ 
/* 839  */         if(!Ext.isEmpty(versionId)) {
/* 840  */             url += '&v='+versionId;
/* 841  */         }
/* 842  */ 
/* 843  */         if(zipped) {
/* 844  */             url += '&z=1';
/* 845  */         }
/* 846  */ 
/* 847  */         window.open(url, 'cbfd' + fileId);
/* 848  */     };
/* 849  */ 
/* 850  */     App.getTypeEditor = function(type, e){

/* app.js */

/* 851  */         var editorCfg = {
/* 852  */             //enable key events by default
/* 853  */             enableKeyEvents: true
/* 854  */         };
/* 855  */         var objData = {
/* 856  */             ownerCt: e.ownerCt
/* 857  */             ,record: e.record
/* 858  */             ,fieldRecord: e.fieldRecord
/* 859  */             ,objFields: e.objFields
/* 860  */             ,grid: e.grid
/* 861  */             ,pidValue: e.pidValue
/* 862  */             ,objectId: e.objectId
/* 863  */             ,path: e.path
/* 864  */         };
/* 865  */         var w, th, ed, rez = null;
/* 866  */         var tr = e.fieldRecord;
/* 867  */         var cfg = tr.get('cfg');
/* 868  */         var objectWindow = e.ownerCt
/* 869  */             ? e.ownerCt
/* 870  */             : (e.grid
/* 871  */                 ? (
/* 872  */                     e.grid.refOwner
/* 873  */                         ? e.grid.refOwner
/* 874  */                         : e.grid.findParentByType(CB.Objects)
/* 875  */                 )
/* 876  */                 : null
/* 877  */             );
/* 878  */         switch(type){
/* 879  */             case '_objects':
/* 880  */                 //e should contain all necessary info
/* 881  */                 switch(cfg.editor){
/* 882  */                     case 'form':
/* 883  */                         if(e && e.grid){
/* 884  */                             e.cancel = true;
/* 885  */                             e.value = e.record.get('value');
/* 886  */ 
/* 887  */                             var formEditor = new CB.object.field.editor.Form({
/* 888  */                                 data: objData
/* 889  */                                 ,value: e.record
/* 890  */                                     ? e.value
/* 891  */                                     : Ext.valueFrom(e.value, null)
/* 892  */                                 ,listeners: {
/* 893  */                                     scope: e
/* 894  */                                     ,setvalue: function(value, editor) {
/* 895  */                                         var objStore = (this.grid)
/* 896  */                                             ? this.grid.refOwner.objectsStore
/* 897  */                                             : null;
/* 898  */ 
/* 899  */                                         if(objStore && editor.selectedRecordsData) {
/* 900  */                                             objStore.checkRecordsExistance(editor.selectedRecordsData);

/* app.js */

/* 901  */                                         }
/* 902  */ 
/* 903  */                                         this.originalValue = this.value;
/* 904  */                                         this.value = editor.getValue().join(',');
/* 905  */ 
/* 906  */                                         this.record.set('value', this.value);
/* 907  */ 
/* 908  */                                         if(this.grid.onAfterEditProperty) {
/* 909  */                                             this.grid.onAfterEditProperty(editor, this);
/* 910  */                                         } else {
/* 911  */                                             this.grid.fireEvent('change', this);
/* 912  */                                         }
/* 913  */                                     }
/* 914  */ 
/* 915  */                                     ,destroy: function(ed) {
/* 916  */                                         if(this.grid) {
/* 917  */                                             this.grid.focus(false, 100);
/* 918  */                                         }
/* 919  */                                     }
/* 920  */                                 }
/* 921  */                             });
/* 922  */ 
/* 923  */                             formEditor.show();
/* 924  */ 
/* 925  */                         } else {
/* 926  */                             rez = new CB.ObjectsTriggerField({
/* 927  */                                 enableKeyEvents: true
/* 928  */                                 ,data: objData
/* 929  */                             });
/* 930  */                         }
/* 931  */                         break;
/* 932  */ 
/* 933  */                     case 'text':
/* 934  */                         ed = new Ext.form.Text({
/* 935  */                             data: objData
/* 936  */ 
/* 937  */                             ,plugins: [{
/* 938  */                                 ptype: 'CBPluginFieldDropDownList'
/* 939  */                                 ,commands: [
/* 940  */                                     {
/* 941  */                                         prefix: ' '
/* 942  */                                         ,regex: /^([\w\d_\.]+)/i
/* 943  */ 
/* 944  */                                         ,insertField: 'info'
/* 945  */ 
/* 946  */                                         ,handler: CB.plugin.field.DropDownList.prototype.onAtCommand
/* 947  */                                     }
/* 948  */                                 ]
/* 949  */                             }]
/* 950  */                         });

/* app.js */

/* 951  */ 
/* 952  */                         //overwrite setValue and getValue function to transform ids to user names and back
/* 953  */                         ed._setValue = ed.setValue;
/* 954  */                         ed._getValue = ed.getValue;
/* 955  */ 
/* 956  */                         ed.setValue = function(value) {
/* 957  */                             var v = toNumericArray(value);
/* 958  */                             for (var i = 0; i < v.length; i++) {
/* 959  */                                 v[i] = CB.DB.usersStore.getUserById(v[i]);
/* 960  */                             }
/* 961  */ 
/* 962  */                             this._setValue(v.join(', '));
/* 963  */                         };
/* 964  */ 
/* 965  */                         ed.getValue = function() {
/* 966  */                             var value = this._getValue();
/* 967  */                             value = Ext.util.Format.trim(String(value).replace(/[\n\r,]/g, ' '));
/* 968  */ 
/* 969  */                             if(Ext.isEmpty(value)) {
/* 970  */                                 return '';
/* 971  */                             }
/* 972  */ 
/* 973  */                             var rez = [];
/* 974  */                             var v = value.split(' ');
/* 975  */                             for (var i = 0; i < v.length; i++) {
/* 976  */                                 if(!Ext.isEmpty(v[i])) {
/* 977  */                                     var id = CB.DB.usersStore.getIdByUser(v[i]);
/* 978  */                                     if(!Ext.isEmpty(id) && (rez.indexOf(id) < 0)) {
/* 979  */                                         rez.push(id);
/* 980  */                                     }
/* 981  */                                 }
/* 982  */                             }
/* 983  */ 
/* 984  */                             return rez.join(',');
/* 985  */                         };
/* 986  */ 
/* 987  */                         return ed;
/* 988  */ 
/* 989  */                     case 'tagField':
/* 990  */                         ed = new CB.object.field.editor.Tag({
/* 991  */                             objData: objData
/* 992  */                             ,valueField: 'id'
/* 993  */                             ,displayField: 'name'
/* 994  */                             ,forceSelection: true
/* 995  */                             ,typeAhead: true
/* 996  */                             ,queryMode: 'remote'
/* 997  */                             ,autoLoadOnValue: true
/* 998  */                             ,autoSelect: false
/* 999  */                             ,multiSelect: true
/* 1000 */                             ,minChars: 2

/* app.js */

/* 1001 */                             // ,stacked: true
/* 1002 */                             ,pinList: false
/* 1003 */                             ,filterPickList: true
/* 1004 */                         });
/* 1005 */ 
/* 1006 */                         return ed;
/* 1007 */                     default:
/* 1008 */                         return new CB.ObjectsComboField({
/* 1009 */                             enableKeyEvents: true
/* 1010 */                             ,data: objData
/* 1011 */                         });
/* 1012 */                 }
/* 1013 */ 
/* 1014 */                 break;
/* 1015 */             case 'checkbox':
/* 1016 */                 rez = new Ext.form.ComboBox({
/* 1017 */                     enableKeyEvents: true
/* 1018 */                     ,triggerAction: 'all'
/* 1019 */                     ,queryMode: 'local'
/* 1020 */                     ,editable: false
/* 1021 */                     ,store: CB.DB.yesno
/* 1022 */                     ,displayField: 'name'
/* 1023 */                     ,valueField: 'id'
/* 1024 */                 });
/* 1025 */                 break;
/* 1026 */ 
/* 1027 */             case 'timeunits':
/* 1028 */                 rez = new Ext.form.ComboBox({
/* 1029 */                     enableKeyEvents: true
/* 1030 */                     ,forceSelection: true
/* 1031 */                     ,triggerAction: 'all'
/* 1032 */                     ,lazyRender: true
/* 1033 */                     ,queryMode: 'local'
/* 1034 */                     ,editable: false
/* 1035 */                     ,store: CB.DB.timeUnits
/* 1036 */                     ,displayField: 'name'
/* 1037 */                     ,valueField: 'id'
/* 1038 */                 });
/* 1039 */                 break;
/* 1040 */ 
/* 1041 */             case 'importance':
/* 1042 */                 rez = new Ext.form.ComboBox({
/* 1043 */                     enableKeyEvents: true
/* 1044 */                     ,forceSelection: true
/* 1045 */                     ,triggerAction: 'all'
/* 1046 */                     ,lazyRender: true
/* 1047 */                     ,queryMode: 'local'
/* 1048 */                     ,editable: false
/* 1049 */                     ,store: CB.DB.importance
/* 1050 */                     ,displayField: 'name'

/* app.js */

/* 1051 */                     ,valueField: 'id'
/* 1052 */                 });
/* 1053 */                 break;
/* 1054 */ 
/* 1055 */             case 'date':
/* 1056 */                 rez = new Ext.form.DateField({
/* 1057 */                     enableKeyEvents: true
/* 1058 */                     ,format: App.dateFormat
/* 1059 */                     ,width: 100
/* 1060 */                 });
/* 1061 */                 break;
/* 1062 */ 
/* 1063 */             case 'datetime':
/* 1064 */                 rez = new Ext.form.DateField({
/* 1065 */                     enableKeyEvents: true
/* 1066 */                     ,format: App.dateFormat+' ' + App.timeFormat
/* 1067 */                     ,width: 130
/* 1068 */                 });
/* 1069 */                 break;
/* 1070 */ 
/* 1071 */             case 'time':
/* 1072 */                 rez = new Ext.form.field.Time({
/* 1073 */                     enableKeyEvents: true
/* 1074 */                     ,format: App.timeFormat
/* 1075 */                 });
/* 1076 */                 break;
/* 1077 */ 
/* 1078 */             case 'int':
/* 1079 */                 rez = new Ext.form.NumberField({
/* 1080 */                     enableKeyEvents: true
/* 1081 */                     ,allowDecimals: false
/* 1082 */                     ,width: 90
/* 1083 */                 });
/* 1084 */                 break;
/* 1085 */ 
/* 1086 */             case 'float':
/* 1087 */                 var fieldCfg = {
/* 1088 */                     enableKeyEvents: true
/* 1089 */                     ,allowDecimals: true
/* 1090 */                     ,width: 90
/* 1091 */                 };
/* 1092 */ 
/* 1093 */                 Ext.copyTo(fieldCfg, cfg, 'decimalPrecision');
/* 1094 */ 
/* 1095 */                 rez = new Ext.form.NumberField(fieldCfg);
/* 1096 */                 break;
/* 1097 */ 
/* 1098 */             case 'combo':
/* 1099 */                 th = cfg.thesauriId;
/* 1100 */                 if(th === 'dependent'){

/* app.js */

/* 1101 */                     th = e.pidValue;
/* 1102 */                 }
/* 1103 */                 rez = new Ext.form.ComboBox({
/* 1104 */                     enableKeyEvents: true
/* 1105 */                     ,forceSelection: true
/* 1106 */                     ,typeAhead: true
/* 1107 */                     ,triggerAction: 'all'
/* 1108 */                     ,lazyRender: true
/* 1109 */                     ,queryMode: 'local'
/* 1110 */                     ,store: getThesauriStore(th)
/* 1111 */                     ,displayField: 'name'
/* 1112 */                     ,valueField: 'id'
/* 1113 */                 });
/* 1114 */                 break;
/* 1115 */ 
/* 1116 */             case 'iconcombo':
/* 1117 */                 th = cfg.thesauriId;
/* 1118 */                 if(th === 'dependent'){
/* 1119 */                     th = e.pidValue;
/* 1120 */                 }
/* 1121 */                 rez = new Ext.form.ComboBox({
/* 1122 */                     enableKeyEvents: true
/* 1123 */                     ,forceSelection: false
/* 1124 */                     ,typeAhead: true
/* 1125 */                     ,triggerAction: 'all'
/* 1126 */                     ,lazyRender: true
/* 1127 */                     ,queryMode: 'local'
/* 1128 */                     ,store: getThesauriStore(th)
/* 1129 */                     ,displayField: 'name'
/* 1130 */                     ,valueField: 'id'
/* 1131 */                     ,iconClsField: 'name'
/* 1132 */                 });
/* 1133 */                 break;
/* 1134 */ 
/* 1135 */             case '_language':
/* 1136 */                 rez = new Ext.form.ComboBox({
/* 1137 */                     enableKeyEvents: true
/* 1138 */                     ,forceSelection: true
/* 1139 */                     ,typeAhead: true
/* 1140 */                     ,triggerAction: 'all'
/* 1141 */                     ,lazyRender: true
/* 1142 */                     ,queryMode: 'local'
/* 1143 */                     ,store: CB.DB.languages
/* 1144 */                     ,displayField: 'name'
/* 1145 */                     ,valueField: 'id'
/* 1146 */                 });
/* 1147 */                 break;
/* 1148 */ 
/* 1149 */             case '_sex':
/* 1150 */                 rez = new Ext.form.ComboBox({

/* app.js */

/* 1151 */                     enableKeyEvents: true
/* 1152 */                     ,forceSelection: true
/* 1153 */                     ,typeAhead: true
/* 1154 */                     ,triggerAction: 'all'
/* 1155 */                     ,lazyRender: true
/* 1156 */                     ,queryMode: 'local'
/* 1157 */                     ,store: CB.DB.sex
/* 1158 */                     ,displayField: 'name'
/* 1159 */                     ,valueField: 'id'
/* 1160 */                 });
/* 1161 */                 break;
/* 1162 */ 
/* 1163 */             case '_templateTypesCombo':
/* 1164 */                 rez = new Ext.form.ComboBox({
/* 1165 */                     enableKeyEvents: true
/* 1166 */                     ,forceSelection: true
/* 1167 */                     ,typeAhead: true
/* 1168 */                     ,triggerAction: 'all'
/* 1169 */                     ,lazyRender: true
/* 1170 */                     ,queryMode: 'local'
/* 1171 */                     ,store: CB.DB.templateTypes
/* 1172 */                     ,displayField: 'name'
/* 1173 */                     ,valueField: 'id'
/* 1174 */                 });
/* 1175 */                 break;
/* 1176 */ 
/* 1177 */             case '_fieldTypesCombo':
/* 1178 */                 rez = new Ext.form.ComboBox({
/* 1179 */                     enableKeyEvents: true
/* 1180 */                     ,autoSelect: true
/* 1181 */                     ,forceSelection: true
/* 1182 */                     ,typeAhead: true
/* 1183 */                     ,triggerAction: 'all'
/* 1184 */                     ,lazyRender: true
/* 1185 */                     ,queryMode: 'local'
/* 1186 */                     ,store: CB.DB.fieldTypes
/* 1187 */                     ,displayField: 'name'
/* 1188 */                     ,valueField: 'id'
/* 1189 */                 });
/* 1190 */                 break;
/* 1191 */ 
/* 1192 */             case '_short_date_format':
/* 1193 */                 rez = new Ext.form.ComboBox({
/* 1194 */                     enableKeyEvents: true
/* 1195 */                     ,forceSelection: true
/* 1196 */                     ,typeAhead: true
/* 1197 */                     ,triggerAction: 'all'
/* 1198 */                     ,lazyRender: true
/* 1199 */                     ,queryMode: 'local'
/* 1200 */                     ,store: CB.DB.shortDateFormats

/* app.js */

/* 1201 */                     ,displayField: 'name'
/* 1202 */                     ,valueField: 'id'
/* 1203 */                 });
/* 1204 */                 break;
/* 1205 */ 
/* 1206 */             case 'memo':
/* 1207 */                 var height = Ext.valueFrom(cfg.height, 50);
/* 1208 */                 height = parseInt(height, 10);
/* 1209 */                 if(e.grid) {
/* 1210 */                     var rowEl = e.grid.getView().getRow(e.row);
/* 1211 */                     if(rowEl) {
/* 1212 */                         var rowHeight = Ext.get(rowEl).getHeight() - 12;
/* 1213 */                         if(height < rowHeight) {
/* 1214 */                             height = rowHeight;
/* 1215 */                         }
/* 1216 */                     }
/* 1217 */                 }
/* 1218 */ 
/* 1219 */                 var edConfig = {
/* 1220 */                     enableKeyEvents: true
/* 1221 */                     ,height: height
/* 1222 */                 };
/* 1223 */                 if(cfg.mentionUsers) {
/* 1224 */                     edConfig.plugins = [{
/* 1225 */                         ptype: 'CBPluginFieldDropDownList'
/* 1226 */                     }];
/* 1227 */ 
/* 1228 */                 }
/* 1229 */ 
/* 1230 */                 rez = new Ext.form.TextArea(edConfig);
/* 1231 */                 break;
/* 1232 */ 
/* 1233 */             case 'text':
/* 1234 */                 e.cancel = true;
/* 1235 */                 rez = new CB.TextEditWindow({
/* 1236 */                     title: tr.get('title')
/* 1237 */                     ,editor: tr.get('cfg').editor
/* 1238 */                     ,mode: tr.get('cfg').mode
/* 1239 */                     ,data: {
/* 1240 */                         value: e.record.get('value')
/* 1241 */                         ,scope: e
/* 1242 */                         ,callback: function(w, v){
/* 1243 */                             this.originalValue = this.record.get('value');
/* 1244 */                             this.value = v;
/* 1245 */                             this.record.set('value', v);
/* 1246 */                             if(this.grid.onAfterEditProperty) {
/* 1247 */                                 this.grid.onAfterEditProperty(this, this);
/* 1248 */                             }
/* 1249 */                         }
/* 1250 */                     }

/* app.js */

/* 1251 */                 });
/* 1252 */                 rez.on('destory', e.grid.gainFocus, e.grid);
/* 1253 */                 rez.show();
/* 1254 */ 
/* 1255 */                 break;
/* 1256 */ 
/* 1257 */             case 'html':
/* 1258 */                 e.cancel = true;
/* 1259 */                 rez = App.getHtmlEditWindow({
/* 1260 */                     title: tr.get('title')
/* 1261 */                     ,data: {
/* 1262 */                         value: e.record.get('value')
/* 1263 */                         ,scope: e
/* 1264 */                         ,callback: function(w, v){
/* 1265 */                             this.originalValue = this.record.get('value');
/* 1266 */                             this.value = v;
/* 1267 */                             this.record.set('value', v);
/* 1268 */ 
/* 1269 */                             if (this.grid.onAfterEditProperty) {
/* 1270 */                                 this.grid.onAfterEditProperty(this);
/* 1271 */                             }
/* 1272 */ 
/* 1273 */                             this.grid.fireEvent('change');
/* 1274 */                         }
/* 1275 */                     }
/* 1276 */                 });
/* 1277 */ 
/* 1278 */                 if(!Ext.isEmpty(e.grid)) {
/* 1279 */                     w.on('hide', e.grid.gainFocus, e.grid);
/* 1280 */                 }
/* 1281 */                 rez.show();
/* 1282 */                 break;
/* 1283 */ 
/* 1284 */             case 'geoPoint':
/* 1285 */                 if(tr && (tr.get('cfg').editor === 'form')) {
/* 1286 */                     e.cancel = true;
/* 1287 */ 
/* 1288 */                     rez = Ext.create('CB.LeafletWindow', {
/* 1289 */                         title: L.Map
/* 1290 */                         ,data: {
/* 1291 */                             value: e.record.get('value')
/* 1292 */                             ,cfg: tr.get('cfg')
/* 1293 */                             ,scope: e
/* 1294 */                             ,callback: function(w, v){
/* 1295 */                                 this.originalValue = this.record.get('value');
/* 1296 */                                 this.value = v;
/* 1297 */                                 this.record.set('value', v);
/* 1298 */                                 if(this.grid.onAfterEditProperty) {
/* 1299 */                                     this.grid.onAfterEditProperty(this, this);
/* 1300 */                                 }

/* app.js */

/* 1301 */                             }
/* 1302 */                         }
/* 1303 */                     });
/* 1304 */                     rez.on('destory', e.grid.gainFocus, e.grid);
/* 1305 */                     rez.show();
/* 1306 */ 
/* 1307 */                 } else {
/* 1308 */                     rez = new Ext.form.TextField({
/* 1309 */                         enableKeyEvents: true
/* 1310 */                         ,maskRe: /[\-\d\.,]/
/* 1311 */                     });
/* 1312 */ 
/* 1313 */                 }
/* 1314 */                 break;
/* 1315 */ 
/* 1316 */             default:
/* 1317 */                 rez = new Ext.form.TextField({
/* 1318 */                     enableKeyEvents: true
/* 1319 */                 });
/* 1320 */         }
/* 1321 */ 
/* 1322 */         return rez;
/* 1323 */     };
/* 1324 */ 
/* 1325 */     App.successResponse = function(r){
/* 1326 */         if(r && (r.success === true)) {
/* 1327 */             return true;
/* 1328 */         }
/* 1329 */         Ext.Msg.alert(L.Error, Ext.valueFrom(r.msg, L.ErrorOccured));
/* 1330 */         return false;
/* 1331 */     };
/* 1332 */ 
/* 1333 */     App.showTestingWindow = function(){
/* 1334 */         if(!App.testWindow) {
/* 1335 */             App.testWindow = new CB.TestingWindow({ closeAction: 'hide' });
/* 1336 */         }
/* 1337 */ 
/* 1338 */         App.testWindow.show();
/* 1339 */     };
/* 1340 */ 
/* 1341 */     App.openUniqueTabbedWidget = function(type, tabPanel, options){
/* 1342 */         if(Ext.isEmpty(tabPanel)) {
/* 1343 */             tabPanel = App.mainTabPanel;
/* 1344 */         }
/* 1345 */         var tabIdx = App.findTabByType(tabPanel, type)
/* 1346 */         ;
/* 1347 */         if(Ext.isEmpty(options)) {
/* 1348 */             options = {};
/* 1349 */         }
/* 1350 */         var rez = null;

/* app.js */

/* 1351 */         if(tabIdx < 0) {
/* 1352 */             rez = Ext.create(type, options);
/* 1353 */             App.addTab(tabPanel, rez);
/* 1354 */         } else {
/* 1355 */             rez = tabPanel.get(tabIdx);
/* 1356 */         }
/* 1357 */         tabPanel.setActiveTab(rez);
/* 1358 */         return rez;
/* 1359 */     };
/* 1360 */ 
/* 1361 */     App.showException = function(e){
/* 1362 */         App.hideFailureAlerts = true;
/* 1363 */         var msg = '';
/* 1364 */ 
/* 1365 */         if(e) {
/* 1366 */             msg = e.msg;
/* 1367 */         }
/* 1368 */ 
/* 1369 */         if(Ext.isEmpty(msg) && e.message) {
/* 1370 */             msg = e.message;
/* 1371 */         }
/* 1372 */ 
/* 1373 */         if(Ext.isEmpty(msg) && e.result) {
/* 1374 */             msg = e.result.msg;
/* 1375 */         }
/* 1376 */ 
/* 1377 */         if(Ext.isEmpty(msg) && e.result) {
/* 1378 */             msg = L.ErrorOccured;
/* 1379 */         }
/* 1380 */ 
/* 1381 */         if(!App.errorMsgDiv) {
/* 1382 */             App.errorMsgDiv = App.getNotificationDiv();
/* 1383 */         }
/* 1384 */ 
/* 1385 */         App.errorMsgDiv.update('<div class="content">' +  msg + '</div>');
/* 1386 */         App.errorMsgDiv.show();
/* 1387 */         App.errorMsgDiv.getEl().fadeIn();
/* 1388 */ 
/* 1389 */         App.errorMsgDiv.task.delay(5000);
/* 1390 */ 
/* 1391 */         var dhf = function(){
/* 1392 */             delete App.hideFailureAlerts;
/* 1393 */         };
/* 1394 */         Ext.Function.defer(dhf, 1500);
/* 1395 */     };
/* 1396 */ 
/* 1397 */     App.hideException = function() {
/* 1398 */         App.errorMsgDiv.fadeOut();
/* 1399 */     };
/* 1400 */ 

/* app.js */

/* 1401 */     App.getNotificationDiv = function() {
/* 1402 */         var rez = Ext.create('Ext.Component', {
/* 1403 */             html: ''
/* 1404 */             ,padding: 5
/* 1405 */             ,floating: true
/* 1406 */             ,y: 1
/* 1407 */             ,hideMode: 'offsets'
/* 1408 */             ,width: '100%'
/* 1409 */             ,shadow: false
/* 1410 */             ,cls: 'error-msg-div'
/* 1411 */             ,style: {
/* 1412 */                 textAlign: 'center'
/* 1413 */             }
/* 1414 */             ,renderTo: Ext.getBody()
/* 1415 */         });
/* 1416 */ 
/* 1417 */         rez.task = new Ext.util.DelayedTask(
/* 1418 */             rez.getEl().fadeOut
/* 1419 */             ,rez.getEl()
/* 1420 */         );
/* 1421 */ 
/* 1422 */         return rez;
/* 1423 */     };
/* 1424 */ 
/* 1425 */     App.clipboard = new CB.Clipboard();
/* 1426 */ 
/* 1427 */     /* disable back button */
/* 1428 */     var o = Ext.isIE ? document : window;
/* 1429 */     o.onkeydown = function(e, t) {
/* 1430 */         if(Ext.isEmpty(t)) {
/* 1431 */             t = e.target;
/* 1432 */         }
/* 1433 */         if ((e.keyCode == Ext.event.Event.BACKSPACE) &&
/* 1434 */              e.stopEvent &&
/* 1435 */                 (
/* 1436 */                     (!/^input$/i.test(t.tagName) &&
/* 1437 */                     !/^textarea$/i.test(t.tagName)
/* 1438 */                 ) || t.disabled || t.readOnly)) {
/* 1439 */             e.stopEvent();
/* 1440 */         }
/* 1441 */     };
/* 1442 */ 
/* 1443 */     /* disable back button */
/* 1444 */ 
/* 1445 */     /* upload files methods*/
/* 1446 */     App.getFileUploader = function(){
/* 1447 */         if(this.Uploader) return this.Uploader;
/* 1448 */         this.Uploader = new CB.Uploader({
/* 1449 */             listeners: {
/* 1450 */             }

/* app.js */

/* 1451 */         });
/* 1452 */         if(this.Uploader.init() === false){
/* 1453 */             delete this.Uploader;
/* 1454 */             return null;
/* 1455 */         }
/* 1456 */         return this.Uploader;
/* 1457 */     };
/* 1458 */ 
/* 1459 */     App.addFilesToUploadQueue = function(FileList, options){
/* 1460 */         var fu = App.getFileUploader();
/* 1461 */         if(fu) {
/* 1462 */             fu.addFiles(FileList, options);
/* 1463 */         } else {
/* 1464 */             Ext.Msg.alert(L.Info, L.BrowserNoDDUpload);
/* 1465 */         }
/* 1466 */     };
/* 1467 */ 
/* 1468 */     App.onComponentActivated = function(component){
/* 1469 */         plog('component activated', arguments, this);
/* 1470 */     };
/* 1471 */ 
/* 1472 */     /**
/* 1473 *|      * generic method to rename an object
/* 1474 *|      * @param  object p containing path, name, callback, scope
/* 1475 *|      * @return void
/* 1476 *|      */
/* 1477 */     App.promptRename = function(p) {
/* 1478 */         App.promptRenameData  = p;
/* 1479 */ 
/* 1480 */         Ext.Msg.prompt(
/* 1481 */             L.Rename
/* 1482 */             ,L.Name
/* 1483 */             ,function(btn, text, opt) {
/* 1484 */                 if(btn !== 'ok') {
/* 1485 */                     return;
/* 1486 */                 }
/* 1487 */ 
/* 1488 */                 CB_BrowserView.rename(
/* 1489 */                     {
/* 1490 */                         path: App.promptRenameData.path
/* 1491 */                         ,name: text
/* 1492 */                     }
/* 1493 */                     ,function(r, e){
/* 1494 */                         if(!r || (r.success !== true)) {
/* 1495 */                             return;
/* 1496 */                         }
/* 1497 */ 
/* 1498 */                         App.fireEvent(
/* 1499 */                             'objectchanged'
/* 1500 */                             ,{

/* app.js */

/* 1501 */                                 id: parseInt(r.data.id, 10)
/* 1502 */                                 ,pid: r.data.pid
/* 1503 */                             }
/* 1504 */                             ,e
/* 1505 */                         );
/* 1506 */ 
/* 1507 */                         var rd = App.promptRenameData;
/* 1508 */                         if(rd.callback) {
/* 1509 */                             if(rd.scope) {
/* 1510 */                                 rd.callback = Ext.Function.bind(rd.callback, rd.scope);
/* 1511 */                             }
/* 1512 */                             rd.callback(r, e);
/* 1513 */                         }
/* 1514 */                     }
/* 1515 */                     ,this
/* 1516 */                 );
/* 1517 */             }
/* 1518 */             ,this
/* 1519 */             ,false
/* 1520 */             ,App.promptRenameData.name
/* 1521 */         ).setWidth(400).center();
/* 1522 */ 
/* 1523 */     };
/* 1524 */ }
/* 1525 */ 
/* 1526 */ window.onbeforeunload = function() {
/* 1527 */     if (App.confirmLeave === false) {
/* 1528 */         delete App.confirmLeave;
/* 1529 */     } else {
/* 1530 */         return "You work will be lost.";
/* 1531 */     }
/* 1532 */ };
/* 1533 */ 
/* 1534 */ window.ondragstart = function(e){
/* 1535 */     window.dragFromWindow = true;
/* 1536 */     return true;
/* 1537 */ };
/* 1538 */ 
/* 1539 */ window.ondragenter = function(e){
/* 1540 */     e.dataTransfer.dropEffect = 'copy';
/* 1541 */     e.preventDefault();
/* 1542 */     if(!window.dragFromWindow){
/* 1543 */         App.fireEvent('dragfilesenter', e);
/* 1544 */     }
/* 1545 */     return false;
/* 1546 */ };
/* 1547 */ 
/* 1548 */ window.ondragover = function(e){
/* 1549 */     e.dataTransfer.dropEffect = 'copy';
/* 1550 */     e.preventDefault();

/* app.js */

/* 1551 */     return false;
/* 1552 */ };
/* 1553 */ 
/* 1554 */ window.ondrop = function(e){
/* 1555 */     e.stopPropagation();
/* 1556 */     e.preventDefault();
/* 1557 */     if(!window.dragFromWindow){
/* 1558 */         App.fireEvent('filesdrop', e);
/* 1559 */     }
/* 1560 */     return false;
/* 1561 */ };
/* 1562 */ 
/* 1563 */ window.ondragleave = function(e){
/* 1564 */     if(!window.dragFromWindow && ( (e.pageX === '0') && (e.pageY === '0') ) ){
/* 1565 */         App.fireEvent('dragfilesleave', e);
/* 1566 */     }
/* 1567 */     return false;
/* 1568 */ };
/* 1569 */ window.ondragend = function(e){
/* 1570 */     delete window.dragFromWindow;
/* 1571 */ };
/* 1572 */ 
/* 1573 */ // window.onerror = function(message, url, linenumber)
/* 1574 */ // {
/* 1575 */ //    var errors = {};
/* 1576 */ //    errors.message    = message;
/* 1577 */ //    errors.url        = url;
/* 1578 */ //    errors.linenumber = linenumber;
/* 1579 */ //    clog('ERROR:', errors);
/* 1580 */ //   // jQuery.ajax({
/* 1581 */ //   //     type: "POST",
/* 1582 */ //   //     url: "/scripts/error_report.php",
/* 1583 */ //   //     dataType: "json",
/* 1584 */ //   //     data: errors
/* 1585 */ //   //  });
/* 1586 */ 
/* 1587 */ //   return true;
/* 1588 */ // };
/* 1589 */ 

;
/* Browsing.js */

/* 1   */ Ext.namespace('CB');
/* 2   */ 
/* 3   */ Ext.define('CB.controller.Browsing', {
/* 4   */     extend: 'Ext.util.Observable'
/* 5   */ 
/* 6   */     ,xtype: 'browsingcontroller'
/* 7   */ 
/* 8   */     ,constructor: function() {
/* 9   */         this.callParent(arguments);
/* 10  */ 
/* 11  */         App.on('cbinit', this.onAppInit, this);
/* 12  */     }
/* 13  */ 
/* 14  */     /**
/* 15  *|      * set main manipulated components and needed event listeners
/* 16  *|      * on application initialization
/* 17  *|      * @return void
/* 18  *|      */
/* 19  */     ,onAppInit: function() {
/* 20  */         var vp = App.mainViewPort
/* 21  */             ,bc = vp.breadcrumb
/* 22  */             ,sf = vp.searchField
/* 23  */             ,tree = App.mainTree
/* 24  */             ,vc = App.explorer
/* 25  */             ,op = vc.objectPanel
/* 26  */             ,fp = App.mainFilterPanel;
/* 27  */ 
/* 28  */         this.tree = tree;
/* 29  */ 
/* 30  */         //viewport (VP)
/* 31  */         this.VP = vp;
/* 32  */ 
/* 33  */         //search field (SF)
/* 34  */         this.SF = sf;
/* 35  */ 
/* 36  */         //breadcumb
/* 37  */         this.breadcrumb = bc;
/* 38  */ 
/* 39  */         //view container (VC)
/* 40  */         this.VC = vc;
/* 41  */ 
/* 42  */         //object panel (OP), used for preview of selected items
/* 43  */         this.OP = op;
/* 44  */ 
/* 45  */         //filter panel
/* 46  */         this.FP = fp;
/* 47  */ 
/* 48  */ 
/* 49  */         //add tree listeners
/* 50  */         tree.getSelectionModel().on(

/* Browsing.js */

/* 51  */             'selectionchange'
/* 52  */             ,this.onTreeSelectionChange
/* 53  */             ,this
/* 54  */         );
/* 55  */ 
/* 56  */         tree.on('itemclick', this.onTreeItemClick, this);
/* 57  */         tree.on('afterrename', this.onTreeRenameItem, this);
/* 58  */ 
/* 59  */         //search field listeners
/* 60  */         sf.on('search', this.onSFSearch, this);
/* 61  */ 
/* 62  */         //breadcumb listeners
/* 63  */         bc.on('itemclick', this.onBreadcrumbItemClick, this);
/* 64  */ 
/* 65  */ 
/* 66  */         //add view container listeners
/* 67  */         vc.on('viewloaded', this.onVCViewLoaded, this);
/* 68  */         vc.on('selectionchange', this.onVCSelectionChange, this);
/* 69  */ 
/* 70  */         //add listeners for notifications view
/* 71  */         var nv = vc.notificationsView;
/* 72  */ 
/* 73  */         nv.on('selectionchange', this.onNVSelectionChange, this);
/* 74  */ 
/* 75  */ 
/* 76  */         //add filter panel listeners
/* 77  */         fp.on('change', this.onFiltersChange, this);
/* 78  */         fp.on('dateselect', this.onFilterPanelDateSelect, this);
/* 79  */ 
/* 80  */         //add object panel listeners
/* 81  */         op.on('expand', this.onOPExpand, this);
/* 82  */     }
/* 83  */ 
/* 84  */     // TREE methods
/* 85  */ 
/* 86  */     /**
/* 87  *|      * tree selection change listener
/* 88  *|      * @param  object sm        [description]
/* 89  *|      * @param  array selection [description]
/* 90  *|      * @return void
/* 91  *|      */
/* 92  */     ,onTreeSelectionChange: function(sm, selection){
/* 93  */         if(this.syncingTreePathWithViewContainer ||
/* 94  */             Ext.isEmpty(selection) ||
/* 95  */             Ext.isEmpty(selection[0].getPath)
/* 96  */         ) {
/* 97  */             return;
/* 98  */         }
/* 99  */ 
/* 100 */         if(!this.isCommentInputEmpty()) {

/* Browsing.js */

/* 101 */             this.confirmDiscardComent(this.onTreeSelectionChange, arguments);
/* 102 */             return;
/* 103 */         }
/* 104 */ 
/* 105 */         var node = selection[0];
/* 106 */         var params = {
/* 107 */             id: node.get('nid')
/* 108 */             ,from: 'tree'
/* 109 */             // ,view: Ext.valueFrom(node.get('view'), 'grid')
/* 110 */         };
/* 111 */ 
/* 112 */         App.openPath(node.getPath('nid'), params);
/* 113 */ 
/* 114 */         this.updatePreview(node.data);
/* 115 */     }
/* 116 */ 
/* 117 */     /**
/* 118 *|      * tree item click listener
/* 119 *|      * @param  component tree   [description]
/* 120 *|      * @param  Model record [description]
/* 121 *|      * @param  Node item   [description]
/* 122 *|      * @param  int index  [description]
/* 123 *|      * @param  object e      [description]
/* 124 *|      * @param  object eOpts  [description]
/* 125 *|      * @return void
/* 126 *|      */
/* 127 */     ,onTreeItemClick: function(tree, record, item, index, e, eOpts){
/* 128 */         if(Ext.isEmpty(item) || Ext.isEmpty(record.getPath)) {
/* 129 */             return;
/* 130 */         }
/* 131 */ 
/* 132 */         if(!this.isCommentInputEmpty()) {
/* 133 */             this.confirmDiscardComent(this.onTreeItemClick, arguments);
/* 134 */             return;
/* 135 */         }
/* 136 */ 
/* 137 */         if(tree.getSelectionModel().isSelected(record)) {
/* 138 */             this.onTreeSelectionChange(null, [record]);
/* 139 */         }
/* 140 */ 
/* 141 */         this.updatePreview(record.data);
/* 142 */     }
/* 143 */ 
/* 144 */     /**
/* 145 *|      * reload the viewcontainer when a tree node is renamed
/* 146 *|      * @return void
/* 147 *|      */
/* 148 */     ,onTreeRenameItem: function(tree, r, e){
/* 149 */         var node = tree.getSelectionModel().getSelection()[0];
/* 150 */ 

/* Browsing.js */

/* 151 */         if(Ext.isEmpty(node) || Ext.isEmpty(node.getPath)) {
/* 152 */             return;
/* 153 */         }
/* 154 */ 
/* 155 */         if(!this.isCommentInputEmpty()) {
/* 156 */             this.confirmDiscardComent(this.onTreeRenameItem, arguments);
/* 157 */             return;
/* 158 */         }
/* 159 */ 
/* 160 */         this.VC.onReloadClick();
/* 161 */ 
/* 162 */         this.updatePreview(node.data);
/* 163 */     }
/* 164 */ 
/* 165 */     //View container methods
/* 166 */ 
/* 167 */     /**
/* 168 *|      * view loaded listener
/* 169 *|      * @param  object proxy
/* 170 *|      * @param  object action
/* 171 *|      * @param  object options
/* 172 *|      * @return void
/* 173 *|      */
/* 174 */     ,onVCViewLoaded: function(proxy, action, options) {
/* 175 */         //change breadcrumb value for search template restults
/* 176 */         var bvalue = Ext.valueFrom(action.pathtext, '')
/* 177 */             ,fp = Ext.valueFrom(action.folderProperties, {})
/* 178 */             ,path = fp.path
/* 179 */             ,total = Ext.valueFrom(action.total, 0);
/* 180 */ 
/* 181 */         if(options.search && !isNaN(options.search.template_id)) {
/* 182 */             bvalue = L.SearchResultsTitleTemplate;
/* 183 */             bvalue = bvalue.replace('{name}', CB.DB.templates.getName(options.search.template_id));
/* 184 */             bvalue = bvalue.replace('{count}', total);
/* 185 */             path = '/' + App.config.rootNode.nid;
/* 186 */         } else if(!Ext.isEmpty(options.query)) {
/* 187 */             bvalue = L.SearchResultsTitleTemplate;
/* 188 */             bvalue = bvalue.replace('{name}', options.query);
/* 189 */             bvalue = bvalue.replace('{count}', total);
/* 190 */         }
/* 191 */ 
/* 192 */         this.updateBreadcrumbData(path, bvalue);
/* 193 */ 
/* 194 */         this.VC.updateCreateMenuItems(this.VP.buttons.create);
/* 195 */ 
/* 196 */ 
/* 197 */         if(fp.path &&
/* 198 */             Ext.isEmpty(this.VC.params.query) // dont sync on search query
/* 199 */         ) {
/* 200 */             this.tree.updateCreateMenu(fp.menu);

/* Browsing.js */

/* 201 */ 
/* 202 */             //check if rootnode id is set at the beginning of the path
/* 203 */             //its id could be missing if it's a virtual root node
/* 204 */             var p = String(fp.path).split('/');
/* 205 */ 
/* 206 */             if (!Ext.isEmpty(fp.path) && (['/', '/0', '/' + App.config.rootNode.nid].indexOf(fp.path) < 0)) {
/* 207 */                 // add flag to avoid reloading viewport on tree node selection change
/* 208 */                 this.syncingTreePathWithViewContainer = true;
/* 209 */ 
/* 210 */                 App.mainTree.selectPath(
/* 211 */                     p.join('/')
/* 212 */                     ,'nid'
/* 213 */                     ,'/'
/* 214 */                     ,function(){
/* 215 */                         delete this.syncingTreePathWithViewContainer;
/* 216 */                     }
/* 217 */                     ,this
/* 218 */                 );
/* 219 */             }
/* 220 */         }
/* 221 */     }
/* 222 */ 
/* 223 */     ,onVCSelectionChange: function(objectsDataArray) {
/* 224 */         if(!this.isCommentInputEmpty()) {
/* 225 */             this.confirmDiscardComent(this.onVCSelectionChange, arguments);
/* 226 */ 
/* 227 */             return;
/* 228 */         }
/* 229 */ 
/* 230 */         if(!Ext.isEmpty(this.VC.params.query) && Ext.isEmpty(objectsDataArray)) {
/* 231 */             this.updatePreview({});
/* 232 */             return;
/* 233 */         }
/* 234 */ 
/* 235 */         if(!this.VC.params.locatingObject) {
/* 236 */             this.updatePreview();
/* 237 */         }
/* 238 */     }
/* 239 */ 
/* 240 */     //Notifications view methods
/* 241 */     ,onNVSelectionChange: function(object) {
/* 242 */         var data = {
/* 243 */             id: object.id
/* 244 */             ,force: !object.read
/* 245 */         };
/* 246 */ 
/* 247 */         this.updatePreview(data);
/* 248 */     }
/* 249 */ 
/* 250 */     //Filter panel methods

/* Browsing.js */

/* 251 */     /**
/* 252 *|      * filter panel change listener
/* 253 *|      * @param  array filters
/* 254 *|      * @return void
/* 255 *|      */
/* 256 */     ,onFiltersChange: function(filters){
/* 257 */         this.VC.changeSomeParams({filters: filters});
/* 258 */     }
/* 259 */ 
/* 260 */     ,onFilterPanelDateSelect: function(date){
/* 261 */         var c = this.VC.getActiveView().calendar
/* 262 */             ,av = c.getActiveView()
/* 263 */             ,dt = date.toISOString()
/* 264 */             ,sameDate = (c.lastClickedDate == dt);
/* 265 */ 
/* 266 */         if(!sameDate || (av.xtype !== 'dayview')) {
/* 267 */             c.onDayClick();
/* 268 */             c.setStartDate(date);
/* 269 */         } else {
/* 270 */             c.onWeekClick();
/* 271 */             c.setStartDate(date);
/* 272 */         }
/* 273 */ 
/* 274 */         c.lastClickedDate = dt;
/* 275 */     }
/* 276 */ 
/* 277 */ 
/* 278 */     //Search field methods
/* 279 */     ,onSFSearch: function(query, editor, event){
/* 280 */         if(!this.isCommentInputEmpty()) {
/* 281 */             this.confirmDiscardComent(this.onSFSearch, arguments);
/* 282 */             return;
/* 283 */         }
/* 284 */ 
/* 285 */         editor.clear();
/* 286 */         query = String(query).trim();
/* 287 */ 
/* 288 */         if(Ext.isEmpty(query)) {
/* 289 */             return;
/* 290 */         }
/* 291 */ 
/* 292 */         if(query.substr(0,1) === '#') {
/* 293 */             query = query.substr(1).trim();
/* 294 */             if(!isNaN(query)) {
/* 295 */                 // this.locateObject(query);
/* 296 */                 this.openObjectWindowById(query);
/* 297 */                 return;
/* 298 */             }
/* 299 */         }
/* 300 */ 

/* Browsing.js */

/* 301 */         this.VC.setParams({
/* 302 */             query: query
/* 303 */             ,descendants: !Ext.isEmpty(query)
/* 304 */         });
/* 305 */ 
/* 306 */         this.updatePreview({});
/* 307 */     }
/* 308 */ 
/* 309 */ 
/* 310 */     //Breadcrumb methods
/* 311 */ 
/* 312 */     /**
/* 313 *|      * dreadcrumb item click listemer
/* 314 *|      * @param  button b
/* 315 *|      * @param  event e
/* 316 *|      * @return void
/* 317 *|      */
/* 318 */     ,onBreadcrumbItemClick: function(view, record, item, index, e, eOpts) {
/* 319 */         var store = this.breadcrumb.store
/* 320 */             ,path = []
/* 321 */             ,id;
/* 322 */ 
/* 323 */         for (var i = 0; i <= index; i++) {
/* 324 */             id = store.getAt(i).data.id;
/* 325 */ 
/* 326 */             if(!Ext.isEmpty(id) && (id != -1)) {
/* 327 */                 path.push(id);
/* 328 */             }
/* 329 */         }
/* 330 */ 
/* 331 */         if(!Ext.isEmpty(path)) {
/* 332 */             this.VC.changeSomeParams({'path': '/' + path.join('/')});
/* 333 */         }
/* 334 */     }
/* 335 */ 
/* 336 */     ,updateBreadcrumbData: function(pathIds, pathText) {
/* 337 */         var ids
/* 338 */             ,texts
/* 339 */             ,data = []
/* 340 */             ,item;
/* 341 */ 
/* 342 */         ids = Ext.isArray(pathIds)
/* 343 */             ? pathIds
/* 344 */             : String(pathIds).split('/');
/* 345 */ 
/* 346 */         //trim empty items from begining and end of pathIds string
/* 347 */         while((ids.length > 0) && Ext.isEmpty(ids[0])) {
/* 348 */             ids.shift();
/* 349 */         }
/* 350 */         //trim empty items from begining and end of pathIds string

/* Browsing.js */

/* 351 */         while((ids.length > 0) && Ext.isEmpty(ids[ids.length -1])) {
/* 352 */             ids.pop();
/* 353 */         }
/* 354 */ 
/* 355 */         //trim slashes from begining and end of pathText string
/* 356 */         while(Ext.String.startsWith(pathText, '/')) {
/* 357 */             pathText = pathText.substr(1);
/* 358 */         }
/* 359 */         while(Ext.String.endsWith(pathText, '/')) {
/* 360 */             pathText = pathText.substr(0, pathText.length - 1);
/* 361 */         }
/* 362 */         texts = pathText.split('/');
/* 363 */ 
/* 364 */         for (var i = 0; i < ids.length; i++) {
/* 365 */             item = {
/* 366 */                 id: ids[i]
/* 367 */                 ,name: texts[i]
/* 368 */             };
/* 369 */ 
/* 370 */             data.push(item);
/* 371 */         }
/* 372 */ 
/* 373 */         this.breadcrumb.setValue(data);
/* 374 */     }
/* 375 */ 
/* 376 */     //Object preview component methods
/* 377 */ 
/* 378 */     ,onOPExpand: function() {
/* 379 */         this.updatePreview();
/* 380 */     }
/* 381 */     /**
/* 382 *|      * update preview
/* 383 *|      * @param  object customParams
/* 384 *|      * @return void
/* 385 *|      */
/* 386 */     ,updatePreview: function(customParams) {
/* 387 */         var vc = this.VC
/* 388 */             ,fp = vc.folderProperties;
/* 389 */ 
/* 390 */         var data = customParams;
/* 391 */ 
/* 392 */         //if custom params are empty then try to load current view selection
/* 393 */         //or the currently opened object
/* 394 */         if(Ext.isEmpty(data)) {
/* 395 */             var s = vc.cardContainer.getLayout().activeItem.currentSelection;
/* 396 */             data = Ext.isEmpty(s)
/* 397 */                 ? {
/* 398 */                     id: fp.id
/* 399 */                     ,name: fp.name
/* 400 */                     ,template_id: fp.template_id

/* Browsing.js */

/* 401 */                 }
/* 402 */                 : {
/* 403 */                     id: Ext.valueFrom(Ext.valueFrom(s[0].target_id, s[0].nid), s[0].id)
/* 404 */                     ,name: s[0].name
/* 405 */                     ,template_id: s[0].template_id
/* 406 */                     ,can: s[0].can
/* 407 */                 };
/* 408 */         } else {
/* 409 */             data = {
/* 410 */                 id: Ext.valueFrom(Ext.valueFrom(data.target_id, data.nid), data.id)
/* 411 */                 ,name: data.name
/* 412 */                 ,template_id: data.template_id
/* 413 */                 ,can: data.can
/* 414 */                 ,force: data.force
/* 415 */             };
/* 416 */         }
/* 417 */ 
/* 418 */         this.OP.load(data);
/* 419 */     }
/* 420 */ 
/* 421 */     //Genertal methods
/* 422 */ 
/* 423 */     /**
/* 424 *|      * locate object method that will retreive object path if not given in params
/* 425 *|      * For backward compatibility params could also be specified as (id, path)
/* 426 *|      *
/* 427 *|      * This method became outdated while we are opening located objects in its own window
/* 428 *|      * @param  object params
/* 429 *|      * @return
/* 430 *|      */
/* 431 */     ,locateObject: function(params){ //object_id, path
/* 432 */         if(!Ext.isObject(params)) {
/* 433 */             params = {id: params};
/* 434 */         }
/* 435 */ 
/* 436 */         if(Ext.isEmpty(params.path) && !Ext.isEmpty(arguments[1])) {
/* 437 */             params.path = arguments[1];
/* 438 */         }
/* 439 */ 
/* 440 */         if(Ext.isEmpty(params.path)){
/* 441 */             CB_Path.getPidPath(
/* 442 */                 params.id
/* 443 */                 ,function(r, e){
/* 444 */                     if(!r || (r.success !== true)) {
/* 445 */                         return ;
/* 446 */                     }
/* 447 */                     this.locateObject(r);
/* 448 */                 }
/* 449 */                 ,this
/* 450 */             );

/* Browsing.js */

/* 451 */             return;
/* 452 */         }
/* 453 */ 
/* 454 */         this.updatePreview(params);
/* 455 */ 
/* 456 */         //check and remove object id from path property if present
/* 457 */         var path = params.path.split('/');
/* 458 */         path = Ext.Array.difference(path, [String(params.id)]);
/* 459 */         params.path = path.join('/');
/* 460 */ 
/* 461 */         Ext.apply(
/* 462 */             params
/* 463 */             ,{
/* 464 */                 locatingObject: params.id
/* 465 */                 ,descendants: false
/* 466 */                 ,query: ''
/* 467 */                 ,filters: {}
/* 468 */             }
/* 469 */         );
/* 470 */ 
/* 471 */         this.openPath(params);
/* 472 */     }
/* 473 */ 
/* 474 */     /**
/* 475 *|      * loads basic data for given object id and try to open its window if found
/* 476 *|      * @param  int id
/* 477 *|      * @return void
/* 478 *|      */
/* 479 */     ,openObjectWindowById: function (id) {
/* 480 */         if(!Ext.isNumeric(id)) {
/* 481 */             return;
/* 482 */         }
/* 483 */ 
/* 484 */         CB_Objects.getBasicInfoForId(
/* 485 */             id
/* 486 */             ,function(r, e) {
/* 487 */                 if(!r || (r.success !== true)) {
/* 488 */                     Ext.Msg.alert(
/* 489 */                         L.Error
/* 490 */                         ,L.RecordIdNotFound.replace('{id}', '#' + r.id)
/* 491 */                     );
/* 492 */                     return;
/* 493 */                 }
/* 494 */                 App.openObjectWindow(r.data);
/* 495 */             }
/* 496 */             ,this
/* 497 */         );
/* 498 */     }
/* 499 */ 
/* 500 */     /**

/* Browsing.js *|

/* 501 *|     * open path on active explorer tabsheet or in default eplorer tabsheet
/* 502 *|     *
/* 503 *|     * this function will not reset explorer navigation params (filters, search query, descendants)
/* 504 *|     *
/* 505 *|     * for backward compatibility params could be specified as (path, params)
/* 506 *|     */
/* 507 */     ,openPath: function(params){
/* 508 */ 
/* 509 */         if(!Ext.isObject(params)) {
/* 510 */             var path = Ext.valueFrom(Ext.clone(arguments[0]), '/');
/* 511 */             params = Ext.valueFrom(Ext.clone(arguments[1]), {});
/* 512 */             params.path = path;
/* 513 */         } else {
/* 514 */             params = Ext.valueFrom(params, {});
/* 515 */ 
/* 516 */         }
/* 517 */ 
/* 518 */         params.locatingObject = Ext.valueFrom(params.locatingObject, false);
/* 519 */         params.query = null;
/* 520 */         params.start = 0;
/* 521 */         params.page = 1;
/* 522 */ 
/* 523 */         this.updatePreview(params);
/* 524 */         this.VC.setParams(params);
/* 525 */     }
/* 526 */ 
/* 527 */     /**
/* 528 *|      * check if comment input from objects panel is empty
/* 529 *|      * @return Boolean
/* 530 *|      */
/* 531 */     ,isCommentInputEmpty: function(){
/* 532 */         var cv = this.OP.getCommentValue();
/* 533 */ 
/* 534 */         return Ext.isEmpty(cv);
/* 535 */     }
/* 536 */ 
/* 537 */     /**
/* 538 *|      * method to confirm comment discard and call callback function if yes
/* 539 *|      * @param  {Function} callback
/* 540 *|      * @param  array   arguments
/* 541 *|      * @return void
/* 542 *|      */
/* 543 */     ,confirmDiscardComent: function(callback, args) {
/* 544 */         Ext.Msg.show({
/* 545 */             title: L.Confirm
/* 546 */             ,message: L.DiscardCommentConfirmation
/* 547 */             ,buttons: Ext.Msg.YESNO
/* 548 */             ,icon: Ext.window.MessageBox.INFO
/* 549 */             ,scope: this
/* 550 */             ,fn: function(b, e){

/* Browsing.js */

/* 551 */                 if(b === 'yes'){
/* 552 */                     this.OP.down('textarea[cls=comment-input]').reset();
/* 553 */                     callback.apply(this, args);
/* 554 */                 }
/* 555 */             }
/* 556 */         });
/* 557 */ 
/* 558 */     }
/* 559 */ 
/* 560 */ });
/* 561 */ 

;
/* History.js */

/* 1   */ Ext.namespace('CB');
/* 2   */ 
/* 3   */ Ext.define('CB.controller.History', {
/* 4   */     extend: 'Ext.util.Observable'
/* 5   */ 
/* 6   */     ,xtype: 'historycontroller'
/* 7   */ 
/* 8   */     ,constructor: function() {
/* 9   */         this.callParent(arguments);
/* 10  */ 
/* 11  */         App.on('cbinit', this.onAppInit, this);
/* 12  */     }
/* 13  */ 
/* 14  */     /**
/* 15  *|      * on application initialization handler
/* 16  *|      * @return void
/* 17  *|      */
/* 18  */     ,onAppInit: function() {
/* 19  */         this.VC = App.explorer;
/* 20  */ 
/* 21  */         Ext.History.init();
/* 22  */ 
/* 23  */         window.addEventListener(
/* 24  */             'hashchange'
/* 25  */             ,Ext.Function.bind(this.onHashChange, this)
/* 26  */         );
/* 27  */ 
/* 28  */         this.VC.store.on(
/* 29  */             'beforeload'
/* 30  */             ,this.onStoreBeforeLoad
/* 31  */             ,this
/* 32  */         );
/* 33  */ 
/* 34  */     }
/* 35  */ 
/* 36  */     /**
/* 37  *|      * handler for history hash change event
/* 38  *|      * @param  historyEvent event [description]
/* 39  *|      * @return void
/* 40  *|      */
/* 41  */     ,onHashChange: function(event) {
/* 42  */ 
/* 43  */         //if in process o setting hash then dont react
/* 44  */         if(this.settingHash) {
/* 45  */             delete this.settingHash;
/* 46  */ 
/* 47  */             return;
/* 48  */         }
/* 49  */ 
/* 50  */         //this flag is set when a window is closed and we have to restore

/* History.js */

/* 51  */         //the hash to the last one
/* 52  */         if(this.closingWindow) {
/* 53  */             delete this.closingWindow;
/* 54  */ 
/* 55  */             return;
/* 56  */         }
/* 57  */ 
/* 58  */         var activeWindow = this.getActiveWindow();
/* 59  */ 
/* 60  */         //if we have an active window - try to close it
/* 61  */         if(!Ext.isEmpty(activeWindow)) {
/* 62  */             this.closingWindow = true;
/* 63  */ 
/* 64  */             window.location = event.oldURL;
/* 65  */ 
/* 66  */             activeWindow.close();
/* 67  */ 
/* 68  */         } else {//react to the changed hash
/* 69  */             var hash = event.newURL.split('#')[1]
/* 70  */                 ,p;
/* 71  */ 
/* 72  */             //if we are already on an empty hash then go back
/* 73  */             if(Ext.isEmpty(hash)) {
/* 74  */                 this.settingHash = true;
/* 75  */ 
/* 76  */                 window.location = event.oldURL;
/* 77  */                 return;
/* 78  */             }
/* 79  */ 
/* 80  */             //update view container params
/* 81  */             p = Ext.Object.fromQueryString(hash);
/* 82  */             this.restoreParams = true;
/* 83  */             this.VC.setParams(p);
/* 84  */         }
/* 85  */     }
/* 86  */ 
/* 87  */ 
/* 88  */     /**
/* 89  *|      * method for getting active window component
/* 90  *|      * @return null | window component
/* 91  *|      */
/* 92  */     ,getActiveWindow: function() {
/* 93  */         var rez = null
/* 94  */             ,el = Ext.Element.getActiveElement();
/* 95  */ 
/* 96  */         if(el) {
/* 97  */             el = Ext.get(el);
/* 98  */             if(el) {
/* 99  */                 var parent = el.findParent('.x-window', true);
/* 100 */                 if(parent) {

/* History.js */

/* 101 */                     rez = Ext.getCmp(parent.id);
/* 102 */                 }
/* 103 */             }
/* 104 */         }
/* 105 */ 
/* 106 */         return rez;
/* 107 */     }
/* 108 */ 
/* 109 */     /**
/* 110 *|      * listener for view contaner store to add loaded params
/* 111 *|      * to history by changing current hash into new loading params
/* 112 *|      * @param  object store
/* 113 *|      * @param  object operation
/* 114 *|      * @param  object eOpts
/* 115 *|      * @return void
/* 116 *|      */
/* 117 */     ,onStoreBeforeLoad: function(store, operation, eOpts) {
/* 118 */         if(this.restoreParams) {
/* 119 */             delete this.restoreParams;
/* 120 */             return;
/* 121 */         }
/* 122 */ 
/* 123 */         var ep = store.proxy.extraParams
/* 124 */             ,p = {
/* 125 */                 'path': Ext.valueFrom(ep.path, ep.id)
/* 126 */                 ,'page': Ext.valueFrom(ep.page, 1)
/* 127 */                 ,'query': ep.query
/* 128 */                 ,'lastQuery': ep.lastQuery
/* 129 */                 ,'descendants': ep.descendants
/* 130 */             };
/* 131 */ 
/* 132 */             if(Ext.isEmpty(p.query)) {
/* 133 */                 delete p.query;
/* 134 */             }
/* 135 */             if(Ext.isEmpty(p.lastQuery)) {
/* 136 */                 delete p.lastQuery;
/* 137 */             }
/* 138 */             if(p.descendants !== true) {
/* 139 */                 delete p.descendants;
/* 140 */             }
/* 141 */ 
/* 142 */             this.settingHash = true;
/* 143 */             Ext.History.add(Ext.Object.toQueryString(p));
/* 144 */     }
/* 145 */ });
/* 146 */ 

;
/* Form.js */

/* 1   */ Ext.namespace('CB.object.field.editor');
/* 2   */ 
/* 3   */ Ext.define('CB.object.field.editor.Form', {
/* 4   */     extend: 'Ext.Window'
/* 5   */ 
/* 6   */     ,xtype: 'CBObjectFieldEditorForm'
/* 7   */ 
/* 8   */     ,height: 500
/* 9   */     ,width: 600
/* 10  */     ,minHeight: 400
/* 11  */     ,minWidth: 600
/* 12  */     ,modal: true
/* 13  */     ,layout: 'border'
/* 14  */     ,title: L.Associate
/* 15  */     ,closeAction: 'destroy'
/* 16  */     ,selectedRecordsData: []
/* 17  */ 
/* 18  */     ,constructor: function(config) {
/* 19  */         this.data = config.data;
/* 20  */ 
/* 21  */         //make shortcut, because grid view tries to acces folderProperties of refOwner
/* 22  */         //shold be refactored
/* 23  */         this.folderProperties = this.data;
/* 24  */ 
/* 25  */         this.cfg = this.data.fieldRecord
/* 26  */             ? Ext.apply({}, Ext.valueFrom(this.data.fieldRecord.data.cfg, {}))
/* 27  */             : Ext.applyIf(
/* 28  */                 Ext.valueFrom(config.config, {})
/* 29  */                 ,{multiValued: false}
/* 30  */             );
/* 31  */ 
/* 32  */         this.callParent(arguments);
/* 33  */ 
/* 34  */         this.setValue(config.value);
/* 35  */     }
/* 36  */ 
/* 37  */     ,initComponent: function(){
/* 38  */         this.detectStore();
/* 39  */ 
/* 40  */         this.actions = {
/* 41  */             showSelection: new Ext.Action({
/* 42  */                 text: L.ShowSelection
/* 43  */                 ,enableToggle: true
/* 44  */                 ,disabled: true
/* 45  */                 ,scope: this
/* 46  */                 ,handler: this.onShowSelectionClick
/* 47  */             })
/* 48  */             ,sortValue: new Ext.Action({
/* 49  */                 text: L.SortValue
/* 50  */                 ,disabled: true

/* Form.js */

/* 51  */                 ,hidden: true
/* 52  */                 ,scope: this
/* 53  */                 ,handler: this.onSortValueClick
/* 54  */             })
/* 55  */         };
/* 56  */ 
/* 57  */         //set title from fieldRecord if set
/* 58  */         if(this.data.fieldRecord) {
/* 59  */             this.title = Ext.valueFrom(
/* 60  */                 this.data.fieldRecord.get('title')
/* 61  */                 ,this.title
/* 62  */             );
/* 63  */         }
/* 64  */ 
/* 65  */         this.gridView = new CB.browser.view.Grid({
/* 66  */             border: false
/* 67  */             ,region: 'center'
/* 68  */             ,refOwner: this
/* 69  */             ,store: this.store
/* 70  */             ,getProperty: this.getProperty.bind(this)
/* 71  */             ,saveGridState: Ext.emptyFn
/* 72  */ 
/* 73  */             ,selModel: {
/* 74  */                 selType: 'checkboxmodel'
/* 75  */                 ,injectCheckbox: 'first'
/* 76  */                 ,allowDeselect: true
/* 77  */                 ,toggleOnClick: true
/* 78  */                 ,mode: (this.cfg.multiValued ? 'SIMPLE': 'SINGLE')
/* 79  */                 ,listeners: {
/* 80  */                     scope: this
/* 81  */                     ,select: this.onRowSelect
/* 82  */                     ,deselect: this.onRowDeselect
/* 83  */                 }
/* 84  */             }
/* 85  */         });
/* 86  */ 
/* 87  */         Ext.apply(this, {
/* 88  */             defaults: {
/* 89  */                 border: false
/* 90  */             }
/* 91  */             ,border: false
/* 92  */             ,buttonAlign: 'left'
/* 93  */             ,layout: 'fit'
/* 94  */             ,items:[
/* 95  */                 {
/* 96  */                     xtype: 'panel'
/* 97  */                     ,region: 'center'
/* 98  */                     ,layout: 'border'
/* 99  */                     ,cls: 'x-panel-white'
/* 100 */                     ,items: [

/* Form.js */

/* 101 */                         {
/* 102 */                             xtype: 'panel'
/* 103 */                             ,region: 'north'
/* 104 */                             ,autoHeight: true
/* 105 */                             ,layout: 'hbox'
/* 106 */                             ,border: false
/* 107 */                             ,items: [
/* 108 */                                 {
/* 109 */                                     xtype: 'textfield'
/* 110 */                                     ,anchor: '100%'
/* 111 */                                     ,flex: 1
/* 112 */                                     ,emptyText: L.Search
/* 113 */                                     ,triggers: {
/* 114 */                                         search: {
/* 115 */                                             cls: 'x-form-search-trigger'
/* 116 */                                             ,scope: this
/* 117 */                                             ,handler: this.onGridReloadTask
/* 118 */                                         }
/* 119 */                                     }
/* 120 */                                     ,enableKeyEvents: true
/* 121 */ 
/* 122 */                                     ,listeners: {
/* 123 */                                         scope: this
/* 124 */                                         ,specialkey: function(ed, ev){
/* 125 */                                             if(ev.getKey() == ev.ENTER) {
/* 126 */                                                 this.onGridReloadTask();
/* 127 */                                             }
/* 128 */                                         }
/* 129 */                                     }
/* 130 */                                 }
/* 131 */                             ]
/* 132 */                         }
/* 133 */                         ,this.gridView
/* 134 */                     ]
/* 135 */                 }
/* 136 */             ]
/* 137 */             ,listeners: {
/* 138 */                 scope: this
/* 139 */                 ,show: function(){
/* 140 */                     this.store.removeAll();
/* 141 */                     this.resetPage = true;
/* 142 */                     if((!Ext.isDefined(this.cfg.autoLoad)) || (this.cfg.autoLoad === true)) {
/* 143 */                         this.onGridReloadTask();
/* 144 */                     }
/* 145 */                     this.triggerField.focus(false, 400);
/* 146 */                 }
/* 147 */                 ,change: this.onChange
/* 148 */             }
/* 149 */             ,buttons:[
/* 150 */                 ,this.actions.showSelection

/* Form.js */

/* 151 */                 ,this.actions.sortValue
/* 152 */                 ,'->'
/* 153 */                 ,{
/* 154 */                     text: Ext.MessageBox.buttonText.ok
/* 155 */                     ,scope: this
/* 156 */                     ,handler: this.onOkClick
/* 157 */                 },{
/* 158 */                     text: L.Cancel
/* 159 */                     ,scope: this
/* 160 */                     ,handler: this.destroy
/* 161 */                 }
/* 162 */             ]
/* 163 */         });
/* 164 */         this.callParent(arguments);
/* 165 */ 
/* 166 */         this.gridView.addCls('view-loading');
/* 167 */ 
/* 168 */         this.store.on('load', this.onLoad, this);
/* 169 */ 
/* 170 */         this.triggerField = this.query('textfield')[0];
/* 171 */ 
/* 172 */         this.actions.sortValue.setHidden(this.cfg.allowValueSort !== true);
/* 173 */     }
/* 174 */ 
/* 175 */     /**
/* 176 *|      * detect store used, based on configuration
/* 177 *|      * @return store
/* 178 *|      */
/* 179 */     ,detectStore: function(){
/* 180 */         var source = Ext.valueFrom(this.cfg.source, 'tree');
/* 181 */ 
/* 182 */         switch(source){
/* 183 */             case 'users':
/* 184 */             case 'groups':
/* 185 */             case 'usersgroups':
/* 186 */                 this.store = CB.DB.usersGroupsSearchStore;
/* 187 */                 break;
/* 188 */             default:
/* 189 */                 this.store = new Ext.data.DirectStore({
/* 190 */                     autoLoad: false //true
/* 191 */                     ,autoDestroy: true
/* 192 */                     ,restful: false
/* 193 */                     ,remoteSort: true
/* 194 */                     ,model: 'FieldObjects'
/* 195 */                     ,proxy: {
/* 196 */                         type: 'direct'
/* 197 */                         ,paramsAsHash: true
/* 198 */                         ,limitParam: 'rows'
/* 199 */                         ,api: {
/* 200 */                             read: CB_Browser.getObjectsForField

/* Form.js */

/* 201 */                         }
/* 202 */                         ,reader: {
/* 203 */                             type: 'json'
/* 204 */                             ,successProperty: 'success'
/* 205 */                             ,rootProperty: 'data'
/* 206 */                             ,messageProperty: 'msg'
/* 207 */                         }
/* 208 */                         ,listeners:{
/* 209 */                             load: function(proxy, obj, opt){
/* 210 */                                 for (var i = 0; i < obj.result.data.length; i++) {
/* 211 */                                     obj.result.data[i].date = date_ISO_to_local_date(obj.result.data[i].date);
/* 212 */                                 }
/* 213 */                             }
/* 214 */                         }
/* 215 */                     }
/* 216 */ 
/* 217 */                     ,sortInfo: {
/* 218 */                         field: 'name'
/* 219 */                         ,direction: 'ASC'
/* 220 */                     }
/* 221 */ 
/* 222 */                     ,listeners: {
/* 223 */                         scope: this
/* 224 */                         ,beforeload: function(store, o ){
/* 225 */                             if(this.data){
/* 226 */                                 if(!Ext.isEmpty(this.data.fieldRecord)) {
/* 227 */                                     store.proxy.extraParams.fieldId = this.data.fieldRecord.get('id');
/* 228 */                                 }
/* 229 */                                 if(!Ext.isEmpty(this.data.objectId)) {
/* 230 */                                     store.proxy.extraParams.objectId = this.data.objectId;
/* 231 */                                 }
/* 232 */                                 if(!Ext.isEmpty(this.data.pidValue)) {
/* 233 */                                     store.proxy.extraParams.pidValue = this.data.pidValue;
/* 234 */                                 }
/* 235 */                                 if(!Ext.isEmpty(this.data.path)) {
/* 236 */                                     store.proxy.extraParams.path = this.data.path;
/* 237 */                                 }
/* 238 */                                 store.proxy.extraParams.objFields = this.data.objFields;
/* 239 */                             }
/* 240 */                         }
/* 241 */                         ,load:  function(store, recs, options) {
/* 242 */                             Ext.each(
/* 243 */                                 recs
/* 244 */                                 ,function(r){
/* 245 */                                     r.set('iconCls', getItemIcon(r.data));
/* 246 */                                 }
/* 247 */                                 ,this
/* 248 */                             );
/* 249 */                         }
/* 250 */                     }

/* Form.js */

/* 251 */                 });
/* 252 */         }
/* 253 */ 
/* 254 */         //set an empty store if none detected
/* 255 */         if(Ext.isEmpty(this.store)) {
/* 256 */             this.store = new Ext.data.ArrayStore({
/* 257 */                 idIndex: 0
/* 258 */                 ,model: 'Generic'
/* 259 */                 ,data:  []
/* 260 */             });
/* 261 */         }
/* 262 */         if(Ext.isEmpty(this.store.getTexts)) {
/* 263 */             this.store.getTexts = getStoreNames;
/* 264 */         }
/* 265 */ 
/* 266 */         //set default sorting
/* 267 */         if(this.cfg.sort){
/* 268 */             var field = 'order'
/* 269 */                 ,dir = 'asc';
/* 270 */ 
/* 271 */             switch(this.cfg.sort){
/* 272 */                 case 'asc':
/* 273 */                     field = 'name';
/* 274 */                     break;
/* 275 */                 case 'desc':
/* 276 */                     field = 'name';
/* 277 */                     dir = 'desc';
/* 278 */                     break;
/* 279 */             }
/* 280 */             this.store.sort(field, dir);
/* 281 */         }
/* 282 */ 
/* 283 */         return this.store;
/* 284 */     }
/* 285 */ 
/* 286 */     /**
/* 287 *|      * get a property from current class
/* 288 *|      * used by grid when needed
/* 289 *|      * @param  varchar propertyName
/* 290 *|      * @return variant
/* 291 *|      */
/* 292 */     ,getProperty: function(propertyName){
/* 293 */         if(propertyName === 'nid') {
/* 294 */             propertyName = 'id';
/* 295 */         }
/* 296 */         if(this.data && this.data[propertyName]) {
/* 297 */             return this.data[propertyName];
/* 298 */         }
/* 299 */ 
/* 300 */         return null;

/* Form.js */

/* 301 */     }
/* 302 */ 
/* 303 */     ,setValue: function(value) {
/* 304 */         this.value = toNumericArray(value);
/* 305 */         //remove zero values
/* 306 */         this.value = Ext.Array.difference(this.value, [0, '0']);
/* 307 */ 
/* 308 */         this.fireEvent('change', this, this.value);
/* 309 */     }
/* 310 */ 
/* 311 */     ,getValue: function() {
/* 312 */         return this.value;
/* 313 */     }
/* 314 */ 
/* 315 */     /**
/* 316 *|      * handler for selectiong a new row
/* 317 *|      * update value with id of new row
/* 318 *|      * @param  selModel
/* 319 *|      * @param  record
/* 320 *|      * @param  index
/* 321 *|      * @param  eOpts
/* 322 *|      * @return void
/* 323 *|      */
/* 324 */     ,onRowSelect: function(selModel, record, index, eOpts) {
/* 325 */         var id = record.get('id');
/* 326 */ 
/* 327 */         if(this.cfg.multiValued !== true) {
/* 328 */             this.value = [];
/* 329 */             this.selectedRecordsData = [];
/* 330 */         }
/* 331 */ 
/* 332 */         if(this.value.indexOf(id) < 0) {
/* 333 */             this.value.push(id);
/* 334 */             this.fireEvent('change', this, this.value);
/* 335 */             //keep selected records data for later usage (add to objectsStore of object edit window)
/* 336 */             this.selectedRecordsData[id] = Ext.apply({}, record.data);
/* 337 */         }
/* 338 */     }
/* 339 */ 
/* 340 */     /**
/* 341 *|      * handler for deselectiong a row
/* 342 *|      * update value by removing id of new row
/* 343 *|      * @param  selModel
/* 344 *|      * @param  record
/* 345 *|      * @param  index
/* 346 *|      * @param  eOpts
/* 347 *|      * @return void
/* 348 *|      */
/* 349 */     ,onRowDeselect: function(selModel, record, index, eOpts) {
/* 350 */         var id = record.get('id')

/* Form.js */

/* 351 */             ,idx = this.value.indexOf(id);
/* 352 */ 
/* 353 */         if(idx > -1) {
/* 354 */             this.value.splice(idx, 1);
/* 355 */             this.fireEvent('change', this, this.value);
/* 356 */         }
/* 357 */     }
/* 358 */ 
/* 359 */     ,onChange: function(ed, value) {
/* 360 */         this.actions.showSelection.setDisabled(Ext.isEmpty(value));
/* 361 */         this.actions.sortValue.setDisabled(Ext.isEmpty(value));
/* 362 */     }
/* 363 */ 
/* 364 */     ,onGridReloadTask: function(){
/* 365 */         if(!this.gridReloadTask) {
/* 366 */             this.gridReloadTask = new Ext.util.DelayedTask(this.doReloadGrid, this);
/* 367 */         }
/* 368 */         this.gridReloadTask.delay(500);
/* 369 */     }
/* 370 */ 
/* 371 */     ,doReloadGrid: function(params){
/* 372 */         if(Ext.isEmpty(params)) {
/* 373 */             params = this.getSearchParams();
/* 374 */         }
/* 375 */ 
/* 376 */         params.from = 'formEditor';
/* 377 */ 
/* 378 */         var resetPage = this.resetPage || (this.store.proxy.extraParams.query !== params.query);
/* 379 */         delete this.resetPage;
/* 380 */ 
/* 381 */         this.store.setPageSize(Ext.valueFrom(params.limit, 25));
/* 382 */ 
/* 383 */         this.store.proxy.extraParams = params;
/* 384 */         if(resetPage) {
/* 385 */             this.store.loadPage(1, params);
/* 386 */         } else {
/* 387 */             this.store.reload(params);
/* 388 */         }
/* 389 */     }
/* 390 */ 
/* 391 */     ,getSearchParams: function(){
/* 392 */         var rez = Ext.apply({}, this.cfg);
/* 393 */         rez.query = this.triggerField.getValue();
/* 394 */         rez.value = this.getValue();
/* 395 */ 
/* 396 */         if(!Ext.isEmpty(this.data.objectId)) {
/* 397 */             rez.objectId = this.data.objectId;
/* 398 */         }
/* 399 */         if(!Ext.isEmpty(this.data.path)) {
/* 400 */             rez.path = this.data.path;

/* Form.js */

/* 401 */         }
/* 402 */ 
/* 403 */         return rez;
/* 404 */     }
/* 405 */ 
/* 406 */     /**
/* 407 *|      * handler for load store event
/* 408 *|      * used to :
/* 409 *|      *     - mask/unmask gridview on no data
/* 410 *|      *     - set icons for new records
/* 411 *|      *     - select rows according to current value
/* 412 *|      * @param  object store
/* 413 *|      * @param  array records
/* 414 *|      * @param  object options
/* 415 *|      * @return void
/* 416 *|      */
/* 417 */     ,onLoad: function(store, records, options){
/* 418 */         if(Ext.isEmpty(records)) {
/* 419 */             this.gridView.getEl().mask(L.noData);
/* 420 */         } else {
/* 421 */             var el = this.gridView.getEl();
/* 422 */             if(el) {
/* 423 */                 this.gridView.getEl().unmask();
/* 424 */             }
/* 425 */ 
/* 426 */             var selectedRecords = [];
/* 427 */             Ext.each(
/* 428 */                 records
/* 429 */                 ,function(r){
/* 430 */                     //set icon
/* 431 */                     r.set('iconCls', getItemIcon(r.data));
/* 432 */ 
/* 433 */                     //collect records that should be selected
/* 434 */                     if(this.value.indexOf(r.get('id')) >= 0) {
/* 435 */                         selectedRecords.push(r);
/* 436 */                     }
/* 437 */                 }
/* 438 */                 ,this
/* 439 */             );
/* 440 */ 
/* 441 */             //select collected records
/* 442 */             if(!Ext.isEmpty(selectedRecords)) {
/* 443 */                 this.gridView.grid.getSelectionModel().select(selectedRecords);
/* 444 */             }
/* 445 */         }
/* 446 */         // this.triggerField.setValue(options.params.query);
/* 447 */ 
/* 448 */         this.gridView.removeCls('view-loading');
/* 449 */     }
/* 450 */ 

/* Form.js */

/* 451 */     ,onShowSelectionClick: function(b, e) {
/* 452 */         var params = this.getSearchParams();
/* 453 */ 
/* 454 */         if(b.pressed) {
/* 455 */             delete params.query;
/* 456 */             params.ids = this.value;
/* 457 */         }
/* 458 */ 
/* 459 */         this.doReloadGrid(params);
/* 460 */     }
/* 461 */ 
/* 462 */     ,onSortValueClick: function(b, e) {
/* 463 */         if(this.data.grid) {
/* 464 */             var value = this.getValue()
/* 465 */                 ,store = this.data.grid.refOwner.objectsStore
/* 466 */                 ,data = []
/* 467 */                 ,i
/* 468 */                 ,r
/* 469 */                 ,sorter = new CB.widget.DataSorter({
/* 470 */                     listeners: {
/* 471 */                         scope: this
/* 472 */                         ,change: this.onSortChanged
/* 473 */                     }
/* 474 */                 });
/* 475 */ 
/* 476 */             if(store && !Ext.isEmpty(this.selectedRecordsData)) {
/* 477 */                 store.checkRecordsExistance(this.selectedRecordsData);
/* 478 */             }
/* 479 */ 
/* 480 */             for (i = 0; i < value.length; i++) {
/* 481 */                 r = store.findRecord('id', value[i], 0, false, false, true);
/* 482 */                 if(r) {
/* 483 */                     data.push({
/* 484 */                         'id': value[i]
/* 485 */                         ,'name': r.get('name')
/* 486 */                         ,'iconCls': r.get('iconCls')
/* 487 */                     });
/* 488 */                 }
/* 489 */             }
/* 490 */ 
/* 491 */             sorter.store.loadData(data);
/* 492 */ 
/* 493 */             sorter.show();
/* 494 */         }
/* 495 */     }
/* 496 */ 
/* 497 */     ,onSortChanged: function(sorter, value) {
/* 498 */         this.value = value;
/* 499 */ 
/* 500 */         sorter.destroy();

/* Form.js */

/* 501 */     }
/* 502 */ 
/* 503 */     /**
/* 504 *|      * set value and close form
/* 505 *|      * @return {[type]} [description]
/* 506 *|      */
/* 507 */     ,onOkClick: function(){
/* 508 */         this.fireEvent('setvalue', this.value, this);
/* 509 */         this.close();
/* 510 */     }
/* 511 */ });
/* 512 */ 

;
/* Tag.js */

/* 1   */ Ext.namespace('CB.object.field.editor');
/* 2   */ 
/* 3   */ Ext.define('CB.object.field.editor.Tag', {
/* 4   */     extend: 'Ext.form.field.Tag'
/* 5   */ 
/* 6   */     ,xtype: 'CBObjectFieldEditorTag'
/* 7   */ 
/* 8   */     ,layout: 'border'
/* 9   */ 
/* 10  */     ,constructor: function(config) {
/* 11  */         this.objData = config.objData;
/* 12  */ 
/* 13  */         this.cfg = this.objData.fieldRecord
/* 14  */             ? Ext.apply({}, Ext.valueFrom(this.objData.fieldRecord.data.cfg, {}))
/* 15  */             : Ext.applyIf(
/* 16  */                 Ext.valueFrom(config.config, {})
/* 17  */                 ,{multiValued: false}
/* 18  */             );
/* 19  */ 
/* 20  */         this.detectStore();
/* 21  */ 
/* 22  */         this.callParent(arguments);
/* 23  */     }
/* 24  */ 
/* 25  */     ,initComponent: function(){
/* 26  */         Ext.apply(this, {
/* 27  */             listeners: {
/* 28  */                 scope: this
/* 29  */                 ,destroy: function() {
/* 30  */                     Ext.destroy(this.store);
/* 31  */                 }
/* 32  */             }
/* 33  */         });
/* 34  */ 
/* 35  */         this.callParent(arguments);
/* 36  */     }
/* 37  */ 
/* 38  */     /**
/* 39  *|      * detect store used, based on configuration
/* 40  *|      * @return store
/* 41  *|      */
/* 42  */     ,detectStore: function(){
/* 43  */         var source = Ext.valueFrom(this.cfg.source, 'tree');
/* 44  */ 
/* 45  */         switch(source){
/* 46  */             case 'users':
/* 47  */             case 'groups':
/* 48  */             case 'usersgroups':
/* 49  */                 this.store = CB.DB.usersGroupsSearchStore;
/* 50  */                 break;

/* Tag.js */

/* 51  */             default:
/* 52  */                 this.store = new Ext.data.DirectStore({
/* 53  */                     autoLoad: false //true
/* 54  */                     ,restful: false
/* 55  */                     ,remoteSort: true
/* 56  */                     ,model: 'FieldObjects'
/* 57  */                     ,pageSize: 200
/* 58  */                     ,proxy: {
/* 59  */                         type: 'direct'
/* 60  */                         ,paramsAsHash: true
/* 61  */                         ,api: {
/* 62  */                             read: CB_Browser.getObjectsForField
/* 63  */                         }
/* 64  */                         ,reader: {
/* 65  */                             type: 'json'
/* 66  */                             ,successProperty: 'success'
/* 67  */                             ,rootProperty: 'data'
/* 68  */                             ,messageProperty: 'msg'
/* 69  */                         }
/* 70  */                         ,listeners:{
/* 71  */                             load: function(proxy, obj, opt){
/* 72  */                                 for (var i = 0; i < obj.result.data.length; i++) {
/* 73  */                                     obj.result.data[i].date = date_ISO_to_local_date(obj.result.data[i].date);
/* 74  */                                 }
/* 75  */                             }
/* 76  */                         }
/* 77  */                     }
/* 78  */ 
/* 79  */                     ,sortInfo: {
/* 80  */                         field: 'name'
/* 81  */                         ,direction: 'ASC'
/* 82  */                     }
/* 83  */ 
/* 84  */                     ,listeners: {
/* 85  */                         scope: this
/* 86  */                         ,beforeload: function(store, o ){
/* 87  */                             var d = this.objData;
/* 88  */                             if(d){
/* 89  */                                 if(!Ext.isEmpty(d.fieldRecord)) {
/* 90  */                                     store.proxy.extraParams.fieldId = d.fieldRecord.get('id');
/* 91  */                                 }
/* 92  */                                 if(!Ext.isEmpty(d.objectId)) {
/* 93  */                                     store.proxy.extraParams.objectId = d.objectId;
/* 94  */                                 }
/* 95  */                                 if(!Ext.isEmpty(d.pidValue)) {
/* 96  */                                     store.proxy.extraParams.pidValue = d.pidValue;
/* 97  */                                 }
/* 98  */                                 if(!Ext.isEmpty(d.path)) {
/* 99  */                                     store.proxy.extraParams.path = d.path;
/* 100 */                                 }

/* Tag.js */

/* 101 */                                 store.proxy.extraParams.objFields = d.objFields;
/* 102 */                             }
/* 103 */                         }
/* 104 */                         ,load:  function(store, recs, options) {
/* 105 */                             Ext.each(
/* 106 */                                 recs
/* 107 */                                 ,function(r){
/* 108 */                                     r.set('iconCls', getItemIcon(r.data));
/* 109 */                                 }
/* 110 */                                 ,this
/* 111 */                             );
/* 112 */                         }
/* 113 */                     }
/* 114 */                 });
/* 115 */         }
/* 116 */ 
/* 117 */         //set an empty store if none detected
/* 118 */         if(Ext.isEmpty(this.store)) {
/* 119 */             this.store = new Ext.data.ArrayStore({
/* 120 */                 idIndex: 0
/* 121 */                 ,model: 'Generic'
/* 122 */                 ,data:  []
/* 123 */             });
/* 124 */         }
/* 125 */         if(Ext.isEmpty(this.store.getTexts)) {
/* 126 */             this.store.getTexts = getStoreNames;
/* 127 */         }
/* 128 */ 
/* 129 */         //set default sorting
/* 130 */         if(this.cfg.sort){
/* 131 */             var field = 'order'
/* 132 */                 ,dir = 'asc';
/* 133 */ 
/* 134 */             switch(this.cfg.sort){
/* 135 */                 case 'asc':
/* 136 */                     field = 'name';
/* 137 */                     break;
/* 138 */ 
/* 139 */                 case 'desc':
/* 140 */                     field = 'name';
/* 141 */                     dir = 'desc';
/* 142 */                     break;
/* 143 */             }
/* 144 */             this.store.sort(field, dir);
/* 145 */         }
/* 146 */ 
/* 147 */         return this.store;
/* 148 */     }
/* 149 */ 
/* 150 */     ,collapse: function() {

/* Tag.js */

/* 151 */         var ev = Ext.EventObject
/* 152 */             ,eventTime = ev.getTime();
/* 153 */ 
/* 154 */         switch(ev.type) {
/* 155 */             case 'mousedown':
/* 156 */                 //check if clicked inside the editor or picker
/* 157 */                 if(
/* 158 */                     !ev.within(this.getEl(), false, true) &&
/* 159 */                     (!this.picker  || (this.picker && !ev.within(this.picker.getEl(), false, true)))
/* 160 */                 ) {
/* 161 */                     delete this.preventEditComplete;
/* 162 */                 } else {
/* 163 */                     this.preventEditComplete = true;
/* 164 */                 }
/* 165 */                 break;
/* 166 */ 
/* 167 */             case 'keydown':
/* 168 */                 switch(ev.getKey()) {
/* 169 */ 
/* 170 */                     case ev.ESC: // doesnt work ok for esc (looses focus)
/* 171 */                                 // will investigate later, maybe dig into keyNav direction
/* 172 */                     case ev.ENTER:
/* 173 */                         if(this.isExpanded) {
/* 174 */                             this.collapsedTime = eventTime;
/* 175 */                             this.preventEditComplete = true;
/* 176 */ 
/* 177 */                         } else {
/* 178 */                             if(this.collapsedTime !== eventTime) {
/* 179 */                                 delete this.preventEditComplete;
/* 180 */                             }
/* 181 */                         }
/* 182 */                 }
/* 183 */ 
/* 184 */                 break;
/* 185 */         }
/* 186 */ 
/* 187 */         this.callParent(arguments);
/* 188 */     }
/* 189 */ });
/* 190 */ 

;
/* BoundListKeyNav.js */

/* 1  */ /**
/* 2  *|  * A specialized {@link Ext.util.KeyNav} implementation for navigating a {@link Ext.view.BoundList} using
/* 3  *|  * the keyboard. The up, down, pageup, pagedown, home, and end keys move the active highlight
/* 4  *|  * through the list. The enter key invokes the selection model's select action using the highlighted item.
/* 5  *|  */
/* 6  */ Ext.define('CB.view.BoundListKeyNav', {
/* 7  */     extend: 'Ext.view.BoundListKeyNav'
/* 8  */ 
/* 9  */     ,alias: 'view.navigation.CBboundlist'
/* 10 */ 
/* 11 */     /**
/* 12 *|      * @cfg {Ext.view.BoundList} boundList (required)
/* 13 *|      * The {@link Ext.view.BoundList} instance for which key navigation will be managed.
/* 14 *|      */
/* 15 */ 
/* 16 */     ,initKeyNav: function(view) {
/* 17 */         var me = this,
/* 18 */             field = me.view.pickerField;
/* 19 */ 
/* 20 */         // BoundLists must be able to function standalone with no bound field
/* 21 */         if (!view.pickerField) {
/* 22 */             return;
/* 23 */         }
/* 24 */ 
/* 25 */         if (!field.rendered) {
/* 26 */             field.on('render', Ext.Function.bind(me.initKeyNav, me, [view], 0), me, {single: true});
/* 27 */             return;
/* 28 */         }
/* 29 */ 
/* 30 */         me.keyNav = new Ext.util.KeyNav({
/* 31 */             target: field.inputEl
/* 32 */             ,forceKeyDown: true
/* 33 */         });
/* 34 */ 
/* 35 */         Ext.apply(
/* 36 */             field
/* 37 */             ,{
/* 38 */                 onKeyUp: Ext.Function.bind(this.onKeyUp, this)
/* 39 */                 ,onKeyDown: Ext.Function.bind(this.onKeyDown, this)
/* 40 */                 ,onKeyEnter: Ext.Function.bind(this.onKeyEnter, this)
/* 41 */                 ,onKeyTab: Ext.Function.bind(this.onKeyTab, this)
/* 42 */                 ,onKeyEsc: Ext.Function.bind(this.onKeyEsc, this)
/* 43 */                 ,setPosition: Ext.Function.bind(this.setPosition, this)
/* 44 */             }
/* 45 */         );
/* 46 */     }
/* 47 */ });
/* 48 */ 

;
/* View.js */

/* 1   */ Ext.namespace('CB.notifications');
/* 2   */ 
/* 3   */ Ext.define('CB.notifications.View', {
/* 4   */     extend: 'Ext.Panel'
/* 5   */ 
/* 6   */     ,alias: 'widget.CBNotificationsView'
/* 7   */ 
/* 8   */     ,border: false
/* 9   */     ,layout: 'fit'
/* 10  */ 
/* 11  */     ,initComponent: function(){
/* 12  */ 
/* 13  */         //define actions
/* 14  */         this.actions = {
/* 15  */             markAllAsRead: new Ext.Action({
/* 16  */                 iconCls: 'im-assignment'
/* 17  */                 ,itemId: 'markAllAsRead'
/* 18  */                 ,scale: 'medium'
/* 19  */                 ,text: L.MarkAllAsRead
/* 20  */                 ,scope: this
/* 21  */                 ,handler: this.onMarkAllAsReadClick
/* 22  */             })
/* 23  */             ,reload: new Ext.Action({
/* 24  */                 iconCls: 'im-refresh'
/* 25  */                 ,itemId: 'reload'
/* 26  */                 ,scale: 'medium'
/* 27  */                 ,tooltip: L.Refresh
/* 28  */                 ,scope: this
/* 29  */                 ,handler: this.onReloadClick
/* 30  */             })
/* 31  */ 
/* 32  */             ,preview: new Ext.Action({
/* 33  */                 itemId: 'preview'
/* 34  */                 ,scale: 'medium'
/* 35  */                 ,iconCls: 'im-preview'
/* 36  */                 ,scope: this
/* 37  */                 ,hidden: true
/* 38  */                 ,handler: this.onPreviewClick
/* 39  */             })
/* 40  */         };
/* 41  */ 
/* 42  */         this.defineStore();
/* 43  */ 
/* 44  */         //define toolbar
/* 45  */         this.tbar = new Ext.Toolbar({
/* 46  */             border: false
/* 47  */             ,style: 'background: #ffffff'
/* 48  */             ,defaults: {
/* 49  */                 scale: 'medium'
/* 50  */             }

/* View.js */

/* 51  */             ,items: [
/* 52  */                 this.actions.markAllAsRead
/* 53  */                 ,'->'
/* 54  */                 ,this.actions.reload
/* 55  */                 ,this.actions.preview
/* 56  */             ]
/* 57  */         });
/* 58  */ 
/* 59  */         Ext.apply(this, {
/* 60  */             items: [
/* 61  */                 this.getGridConfig()
/* 62  */             ]
/* 63  */             ,listeners: {
/* 64  */                 scope: this
/* 65  */                 ,activate: this.onActivateEvent
/* 66  */             }
/* 67  */         });
/* 68  */ 
/* 69  */         this.callParent(arguments);
/* 70  */ 
/* 71  */         this.grid = this.items.getAt(0);
/* 72  */         this.checkNotificationsTask = new Ext.util.DelayedTask(
/* 73  */             this.onCheckNotificationsTask
/* 74  */             ,this
/* 75  */         );
/* 76  */ 
/* 77  */         this.selectionDelayTask = new Ext.util.DelayedTask(
/* 78  */             this.onSelectionDelayTask
/* 79  */             ,this
/* 80  */         );
/* 81  */ 
/* 82  */         App.on('cbinit', this.onLogin, this, {delay: 3000, single: true});
/* 83  */     }
/* 84  */ 
/* 85  */     ,defineStore: function() {
/* 86  */         this.store = new Ext.data.DirectStore({
/* 87  */             autoLoad: false
/* 88  */             ,autoDestroy: true
/* 89  */             ,extraParams: {}
/* 90  */             ,pageSize: 200
/* 91  */             ,model: 'Notification'
/* 92  */             ,sorters: [{
/* 93  */                  property: 'action_id'
/* 94  */                  ,direction: 'DESC'
/* 95  */             }]
/* 96  */             ,proxy: new  Ext.data.DirectProxy({
/* 97  */                 paramsAsHash: true
/* 98  */                 ,directFn: CB_Notifications.getList
/* 99  */                 ,reader: {
/* 100 */                     type: 'json'

/* View.js */

/* 101 */                     ,successProperty: 'success'
/* 102 */                     ,idProperty: 'ids'
/* 103 */                     ,rootProperty: 'data'
/* 104 */                     ,messageProperty: 'msg'
/* 105 */                 }
/* 106 */             })
/* 107 */ 
/* 108 */             ,listeners: {
/* 109 */                 scope: this
/* 110 */                 ,load: this.onStoreLoad
/* 111 */             }
/* 112 */         });
/* 113 */     }
/* 114 */ 
/* 115 */     ,onStoreLoad: function(store, records, successful, eOpts) {
/* 116 */         var rd = store.proxy.reader.rawData;
/* 117 */ 
/* 118 */         if(rd && (rd.success === true)) {
/* 119 */             this.lastSeenActionId = rd.lastSeenActionId;
/* 120 */             this.updateSeenRecords();
/* 121 */         }
/* 122 */     }
/* 123 */ 
/* 124 */     ,updateSeenRecords: function() {
/* 125 */         var visible = this.getEl().isVisible(true);
/* 126 */         this.store.each(
/* 127 */             function(r) {
/* 128 */                 var seen = visible || (r.get('action_id') <= this.lastSeenActionId);
/* 129 */                 r.set('seen', seen);
/* 130 */             }
/* 131 */             ,this
/* 132 */         );
/* 133 */ 
/* 134 */         this.fireNotificationsUpdated();
/* 135 */     }
/* 136 */ 
/* 137 */     ,fireNotificationsUpdated: function() {
/* 138 */         var readRecs = this.store.queryBy('read', false, false, false, true)
/* 139 */             ,seenRecs = this.store.queryBy('seen', false, false, false, true)
/* 140 */             ,params = {
/* 141 */                 total: this.store.getCount()
/* 142 */                 ,unread: readRecs.getCount()
/* 143 */                 ,unseen: seenRecs.getCount()
/* 144 */             };
/* 145 */ 
/* 146 */         App.fireEvent('notificationsUpdated', params);
/* 147 */     }
/* 148 */ 
/* 149 */     ,getGridConfig: function() {
/* 150 */ 

/* View.js */

/* 151 */         var columns = [
/* 152 */             {
/* 153 */                 header: 'ID'
/* 154 */                 ,width: 80
/* 155 */                 ,sortable: false
/* 156 */                 ,dataIndex: 'ids'
/* 157 */                 ,hidden: true
/* 158 */             },{
/* 159 */                 header: L.Action
/* 160 */                 ,flex: 1
/* 161 */                 ,sortable: false
/* 162 */                 ,dataIndex: 'text'
/* 163 */                 ,renderer: this.actionRenderer
/* 164 */             }
/* 165 */         ];
/* 166 */ 
/* 167 */         var sm = new Ext.selection.RowModel({
/* 168 */            mode: 'SINGLE'
/* 169 */            ,allowDeselect: true
/* 170 */         });
/* 171 */ 
/* 172 */ 
/* 173 */         var rez = {
/* 174 */             xtype: 'grid'
/* 175 */             ,loadMask: false
/* 176 */             ,border: false
/* 177 */             ,bodyStyle: {
/* 178 */                 border: 0
/* 179 */             }
/* 180 */             ,store: this.store
/* 181 */             ,columns: columns
/* 182 */             ,selModel: sm
/* 183 */ 
/* 184 */             ,viewConfig: {
/* 185 */                 forceFit: true
/* 186 */                 ,loadMask: false
/* 187 */                 ,stripeRows: false
/* 188 */                 ,emptyText: L.NoData
/* 189 */             }
/* 190 */ 
/* 191 */             ,listeners:{
/* 192 */                 scope: this
/* 193 */                 ,rowclick: this.onRowClick
/* 194 */                 ,selectionchange: this.onSelectionChange
/* 195 */             }
/* 196 */ 
/* 197 */         };
/* 198 */ 
/* 199 */         return rez;
/* 200 */     }

/* View.js */

/* 201 */ 
/* 202 */     ,actionRenderer: function(v, m, r, ri, ci, s){
/* 203 */         var uid = r.get('user_id')
/* 204 */             ,rez = '<table cellpadding="0" cellspacing="0" border="0">' +
/* 205 */                 '<tr><td style="padding: 3px"><img class="i32" src="' +
/* 206 */             App.config.photoPath +
/* 207 */             uid + '.jpg?32=' +
/* 208 */             CB.DB.usersStore.getPhotoParam(uid) +
/* 209 */             '"></td><td style="padding-top: 3px" class="pl7 vaT notif">' + v + '</td></tr></table>'
/* 210 */             ;
/* 211 */ 
/* 212 */         m.tdCls = r.get('read') ? '': 'notification-record-unread';
/* 213 */ 
/* 214 */         return rez;
/* 215 */     }
/* 216 */ 
/* 217 */     ,onRowClick: function(grid, record, tr, rowIndex, e, eOpts) {
/* 218 */         var el = e.getTarget('.obj-ref');
/* 219 */         if(el) {
/* 220 */             App.openObjectWindow({
/* 221 */                 id: el.getAttribute('itemid')
/* 222 */                 ,template_id: el.getAttribute('templateid')
/* 223 */                 ,name: el.getAttribute('title')
/* 224 */             });
/* 225 */         }
/* 226 */ 
/* 227 */         if(this.lastSelectedRecord == record) {
/* 228 */             this.onSelectionChange(grid, [record], eOpts);
/* 229 */         }
/* 230 */     }
/* 231 */ 
/* 232 */     ,onSelectionChange: function (grid, selected, eOpts) {
/* 233 */         this.lastSelectedRecord = selected[0];
/* 234 */         //start 3 seconds delayed task to mark the notification as read
/* 235 */         this.selectionDelayTask.delay(3);
/* 236 */ 
/* 237 */         if(!Ext.isEmpty(selected)) {
/* 238 */             var d = selected[0].data;
/* 239 */ 
/* 240 */             this.fireEvent(
/* 241 */                 'selectionchange'
/* 242 */                 ,{
/* 243 */                     id: d.object_id
/* 244 */                     ,read: d.read
/* 245 */                 }
/* 246 */             );
/* 247 */         }
/* 248 */     }
/* 249 */ 
/* 250 */     ,onSelectionDelayTask: function() {

/* View.js */

/* 251 */         var recs = this.grid.getSelectionModel().getSelection();
/* 252 */ 
/* 253 */         if(Ext.isEmpty(recs) || (recs[0].get('read'))) {
/* 254 */             return;
/* 255 */         }
/* 256 */ 
/* 257 */         CB_Notifications.markAsRead(
/* 258 */             {
/* 259 */                 id: recs[0].get('id')
/* 260 */                 ,ids: recs[0].get('ids')
/* 261 */             }
/* 262 */             ,this.onMarkAsRead
/* 263 */             ,this
/* 264 */         );
/* 265 */     }
/* 266 */ 
/* 267 */     ,onMarkAsRead: function(r, e) {
/* 268 */         if(!r || (r.success !== true)) {
/* 269 */             return;
/* 270 */         }
/* 271 */ 
/* 272 */         var rec = this.store.findRecord('id', r.data.id);
/* 273 */         if(rec) {
/* 274 */             rec.set('read', true);
/* 275 */         }
/* 276 */ 
/* 277 */         this.fireNotificationsUpdated();
/* 278 */     }
/* 279 */ 
/* 280 */     ,onActivateEvent: function() {
/* 281 */         var fr = this.store.first()
/* 282 */             ,lastId = (fr && fr.get) ? fr.get('action_id') : 0;
/* 283 */ 
/* 284 */         this.grid.getView().refresh();
/* 285 */         this.grid.view.scrollTo(0, 0);
/* 286 */ 
/* 287 */         if (this.lastSeenActionId != lastId) {
/* 288 */             CB_Notifications.updateLastSeenActionId(
/* 289 */                 lastId
/* 290 */                 ,function(r, e) {
/* 291 */                     if(r && (r.success === true)) {
/* 292 */                         this.lastSeenActionId = lastId;
/* 293 */                         this.updateSeenRecords();
/* 294 */                     }
/* 295 */                 }
/* 296 */                 ,this
/* 297 */             );
/* 298 */         }
/* 299 */     }
/* 300 */ 

/* View.js */

/* 301 */     ,onLogin: function() {
/* 302 */         this.store.load();
/* 303 */ 
/* 304 */         this.checkNotificationsTask.delay(1000 * 60 * 1); //1 minute
/* 305 */ 
/* 306 */         //add listeners for object panel to toggle preview action
/* 307 */         var op = App.explorer.objectPanel;
/* 308 */ 
/* 309 */         this.actions.preview.setHidden(op.getCollapsed() === false);
/* 310 */ 
/* 311 */         op.on(
/* 312 */             'expand'
/* 313 */             ,function() {
/* 314 */                 this.actions.preview.setHidden(true);
/* 315 */             }
/* 316 */             ,this
/* 317 */         );
/* 318 */ 
/* 319 */         op.on(
/* 320 */             'collapse'
/* 321 */             ,function() {
/* 322 */                 this.actions.preview.setHidden(false);
/* 323 */             }
/* 324 */             ,this
/* 325 */         );
/* 326 */     }
/* 327 */ 
/* 328 */     ,onCheckNotificationsTask: function() {
/* 329 */         var rec = this.store.first()
/* 330 */             ,params= {};
/* 331 */         if(rec) {
/* 332 */             params.fromId = rec.get('action_id');
/* 333 */         }
/* 334 */ 
/* 335 */         CB_Notifications.getNew(
/* 336 */             params
/* 337 */             ,this.processGetNew
/* 338 */             ,this
/* 339 */         );
/* 340 */ 
/* 341 */         this.checkNotificationsTask.delay(1000 * 60 * 1); //1 min
/* 342 */     }
/* 343 */ 
/* 344 */     ,processGetNew: function(r, e) {
/* 345 */         if(!r || (r.success !== true)) {
/* 346 */             return;
/* 347 */         }
/* 348 */ 
/* 349 */         if(!Ext.isEmpty(r.data)) {
/* 350 */             var oldRec

/* View.js */

/* 351 */                 ,modelName = this.store.getModel().getName();
/* 352 */ 
/* 353 */             for (var i = 0; i < r.data.length; i++) {
/* 354 */                 oldRec = this.store.findRecord('ids', r.data[i].ids, 0, false, false, true);
/* 355 */                 if(oldRec) {
/* 356 */                     this.store.remove(oldRec);
/* 357 */                 }
/* 358 */ 
/* 359 */                 this.store.addSorted(
/* 360 */                     Ext.create(modelName, r.data[i])
/* 361 */                 );
/* 362 */             }
/* 363 */ 
/* 364 */             this.grid.getView().refresh();
/* 365 */             this.grid.view.scrollTo(0, 0);
/* 366 */ 
/* 367 */             if(this.getEl().isVisible(true)) {
/* 368 */                 this.onActivateEvent();
/* 369 */             } else {
/* 370 */                 this.updateSeenRecords();
/* 371 */             }
/* 372 */         }
/* 373 */ 
/* 374 */         if(r.lastSeenId && (r.lastSeenId > this.lastSeenActionId)) {
/* 375 */             this.lastSeenActionId = r.lastSeenId;
/* 376 */             this.updateSeenRecords();
/* 377 */         }
/* 378 */     }
/* 379 */ 
/* 380 */     /**
/* 381 *|      * handler for mark all as read button
/* 382 *|      * @param  object b
/* 383 *|      * @param  object e
/* 384 *|      * @return void
/* 385 *|      */
/* 386 */     ,onMarkAllAsReadClick: function(b, e) {
/* 387 */         CB_Notifications.markAllAsRead(
/* 388 */             this.onReloadClick
/* 389 */             ,this
/* 390 */         );
/* 391 */     }
/* 392 */ 
/* 393 */     ,onReloadClick: function(b, e) {
/* 394 */         this.store.reload();
/* 395 */     }
/* 396 */ 
/* 397 */     /**
/* 398 *|      * handler for preview toolbar button
/* 399 *|      * @param  button b
/* 400 *|      * @param  evente

/* View.js *|

/* 401 *|      * @return void
/* 402 *|      */
/* 403 */     ,onPreviewClick: function(b, e) {
/* 404 */         App.explorer.objectPanel.expand();
/* 405 */         this.actions.preview.hide();
/* 406 */     }
/* 407 */ });
/* 408 */ 

;
/* SettingsWindow.js */

/* 1   */ Ext.namespace('CB.notifications');
/* 2   */ 
/* 3   */ Ext.define('CB.notifications.SettingsWindow', {
/* 4   */     extend: 'Ext.Window'
/* 5   */ 
/* 6   */     ,alias: 'widget.CBNotificationsSettingsWindow'
/* 7   */ 
/* 8   */     ,border: false
/* 9   */     ,modal: true
/* 10  */     ,autoHeight: true
/* 11  */     ,autoWidth: true
/* 12  */     ,layout: 'fit'
/* 13  */     ,minWidth: 250
/* 14  */     ,minHeight: 150
/* 15  */     ,width: 300
/* 16  */ 
/* 17  */     ,initComponent: function(){
/* 18  */ 
/* 19  */         Ext.apply(this, {
/* 20  */             title: L.NotificationsSettings
/* 21  */             ,items: {
/* 22  */                 xtype: 'form'
/* 23  */                 ,forceLayout: true
/* 24  */                 ,bodyPadding: 10
/* 25  */                 ,defaults: {
/* 26  */                     labelAlign: 'top'
/* 27  */                 }
/* 28  */                 ,items: [
/* 29  */                     {
/* 30  */                         xtype: 'displayfield'
/* 31  */                         ,cls: 'fs20'
/* 32  */                         ,value: 'Push notifications'
/* 33  */                     },{
/* 34  */                         xtype: 'combo'
/* 35  */                         ,itemId: 'cbNotifyFor'
/* 36  */                         ,fieldLabel: 'Send me email notifications for'
/* 37  */                         ,anchor: '100%'
/* 38  */                         ,store: CB.DB.notifyFor
/* 39  */                         ,lazyRender: true
/* 40  */                         ,forceSelection: true
/* 41  */                         ,triggerAction: 'all'
/* 42  */                         ,queryMode: 'local'
/* 43  */                         ,editable: false
/* 44  */                         ,displayField: 'name'
/* 45  */                         ,valueField: 'id'
/* 46  */                         // ,value: 'mentioned'
/* 47  */                         ,listeners: {
/* 48  */                             scope: this
/* 49  */                             ,change: this.updateAvailability
/* 50  */                         }

/* SettingsWindow.js */

/* 51  */                     },{
/* 52  */                         xtype: 'displayfield'
/* 53  */                         ,cls: 'fs20 pt10'
/* 54  */                         ,itemId: 'dfTimings'
/* 55  */                         ,disabled: true
/* 56  */                         ,value: 'Push notifications timing'
/* 57  */                     },{
/* 58  */                         xtype: 'radiogroup'
/* 59  */                         ,itemId: 'rgTimings'
/* 60  */                         ,columns: 1
/* 61  */                         ,vertical: true
/* 62  */                         ,items: [
/* 63  */                             {
/* 64  */                                 boxLabel: 'Send instantly'
/* 65  */                                 ,name: 'rb'
/* 66  */                                 ,inputValue: 1
/* 67  */                             },{
/* 68  */                                 boxLabel: 'After being idle for:'
/* 69  */                                 ,name: 'rb'
/* 70  */                                 ,inputValue: 2
/* 71  */                                 ,checked: true
/* 72  */                             }
/* 73  */                         ]
/* 74  */                         ,listeners: {
/* 75  */                             scope: this
/* 76  */                             ,change: this.updateAvailability
/* 77  */                         }
/* 78  */                     },{
/* 79  */                         xtype: 'combo'
/* 80  */                         ,anchor: '100%'
/* 81  */                         ,itemId: 'cbTimings'
/* 82  */                         ,disabled: true
/* 83  */                         ,editable: false
/* 84  */                         ,store: CB.DB.idleTimings
/* 85  */                         ,lazyRender: true
/* 86  */                         ,forceSelection: true
/* 87  */                         ,triggerAction: 'all'
/* 88  */                         ,queryMode: 'local'
/* 89  */                         ,displayField: 'name'
/* 90  */                         ,valueField: 'id'
/* 91  */                         ,value: 2
/* 92  */                         ,listeners: {
/* 93  */                             scope: this
/* 94  */                             ,change: this.updateAvailability
/* 95  */                         }
/* 96  */                     }
/* 97  */                 ]
/* 98  */                 ,buttons: [
/* 99  */                     {
/* 100 */                         text: 'Ok'

/* SettingsWindow.js */

/* 101 */                         ,itemId: 'btnOk'
/* 102 */                         ,disabled: true
/* 103 */                         ,formBind: true
/* 104 */                         ,scope: this
/* 105 */                         ,handler: this.onOkClick
/* 106 */                     }
/* 107 */                 ]
/* 108 */             }
/* 109 */         });
/* 110 */ 
/* 111 */         this.callParent(arguments);
/* 112 */ 
/* 113 */         this.notifyCombo = this.down('[itemId="cbNotifyFor"]');
/* 114 */         this.timingsHeader = this.down('[itemId="dfTimings"]');
/* 115 */         this.timingsRadio = this.down('[itemId="rgTimings"]');
/* 116 */         this.timingsCombo = this.down('[itemId="cbTimings"]');
/* 117 */ 
/* 118 */         this.reload();
/* 119 */     }
/* 120 */ 
/* 121 */     ,reload: function() {
/* 122 */         CB_User.getNotificationSettings(
/* 123 */             this.processGetNotificationSettings
/* 124 */             ,this
/* 125 */         );
/* 126 */     }
/* 127 */ 
/* 128 */     ,processGetNotificationSettings: function(r, e) {
/* 129 */         if(!r || (r.success !== true)) {
/* 130 */             return;
/* 131 */         }
/* 132 */         var d = r.data;
/* 133 */ 
/* 134 */         this.notifyCombo.originalValue = d.notifyFor;
/* 135 */         this.notifyCombo.setValue(d.notifyFor);
/* 136 */ 
/* 137 */         this.timingsRadio.originalValue = d.delay;
/* 138 */         this.timingsRadio.setValue({'rb' : d.delay});
/* 139 */ 
/* 140 */         this.timingsCombo.originalValue = d.delaySize;
/* 141 */         this.timingsCombo.setValue(d.delaySize);
/* 142 */ 
/* 143 */         this.updateAvailability();
/* 144 */         var okb = this.down('[itemId="btnOk"]');
/* 145 */         Ext.Function.defer(okb.disable, 10, okb);
/* 146 */     }
/* 147 */ 
/* 148 */     ,updateAvailability: function() {
/* 149 */         var enableDelay = (this.notifyCombo.getValue() !== 'none')
/* 150 */             ,enableDelaySize = (this.timingsRadio.getValue().rb == 2);

/* SettingsWindow.js */

/* 151 */ 
/* 152 */         this.timingsHeader.setDisabled(!enableDelay);
/* 153 */ 
/* 154 */         if(enableDelay) {
/* 155 */             this.timingsRadio.setDisabled(false);
/* 156 */             var r = this.timingsRadio.items.getAt(0);
/* 157 */             if(r && r.el) {
/* 158 */                 r.unmask();
/* 159 */                 this.timingsRadio.items.getAt(1).unmask();
/* 160 */             }
/* 161 */         }  else {
/* 162 */             this.timingsRadio.setDisabled(true);
/* 163 */         }
/* 164 */ 
/* 165 */         this.timingsCombo.setDisabled(!enableDelay || !enableDelaySize);
/* 166 */ 
/* 167 */         this.down('[itemId="btnOk"]').setDisabled(!this.items.getAt(0).isDirty());
/* 168 */     }
/* 169 */ 
/* 170 */     ,onOkClick: function(b, e) {
/* 171 */         var rez = {
/* 172 */             notifyFor : this.notifyCombo.getValue()
/* 173 */             ,delay: this.timingsRadio.getValue().rb
/* 174 */             ,delaySize: this.timingsCombo.getValue()
/* 175 */         };
/* 176 */ 
/* 177 */         CB_User.setNotificationSettings(rez, this.close, this);
/* 178 */     }
/* 179 */ });
/* 180 */ 
