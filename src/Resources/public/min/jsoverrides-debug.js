
/* Ajax.js */

/* 1  */ Ext.override(Ext.Ajax,{
/* 2  */ 
/* 3  */     initDisplayMsg: function() {
/* 4  */         this.displayMsgTimeout = 1500; //1.5sec
/* 5  */ 
/* 6  */         this.displayMsgTask = new Ext.util.DelayedTask(
/* 7  */             this.onDisplayMsgDelay
/* 8  */             ,this
/* 9  */             ,[]
/* 10 */             ,false
/* 11 */         );
/* 12 */         this.loadingMsgDiv = App.getNotificationDiv();
/* 13 */         this.loadingMsgDiv.update('<div class="content">' +  Ext.LoadMask.prototype.msg + '</div>');
/* 14 */     }
/* 15 */ 
/* 16 */     ,request: function(options) {
/* 17 */         var request = this.callParent(arguments);
/* 18 */ 
/* 19 */         if(request) {
/* 20 */             request.startTime = new Date();
/* 21 */         }
/* 22 */ 
/* 23 */         if(!this.displayMsgTask) {
/* 24 */             this.initDisplayMsg();
/* 25 */         }
/* 26 */ 
/* 27 */         this.displayMsgTask.delay(this.displayMsgTimeout);
/* 28 */ 
/* 29 */         return request;
/* 30 */     }
/* 31 */ 
/* 32 */     ,onDisplayMsgDelay: function() {
/* 33 */         var requests = this.requests
/* 34 */             ,id
/* 35 */             ,empty = true
/* 36 */             ,time = new Date()
/* 37 */             ,displayMsg = false;
/* 38 */ 
/* 39 */ 
/* 40 */         //check active requests
/* 41 */         for (id in requests) {
/* 42 */             if (requests.hasOwnProperty(id)) {
/* 43 */                 if(Ext.isEmpty(requests[id].timedout) &&
/* 44 */                     ((time - requests[id].startTime) < 6000) //skip failed requests
/* 45 */                 ) {
/* 46 */                     empty = false;
/* 47 */                     if(time - requests[id].startTime > this.displayMsgTimeout) {
/* 48 */                         displayMsg = true;
/* 49 */                     }
/* 50 */                 }

/* Ajax.js */

/* 51 */             }
/* 52 */         }
/* 53 */ 
/* 54 */         if(empty) {
/* 55 */             this.displayMsgTask.cancel();
/* 56 */             this.loadingMsgDiv.hide();
/* 57 */ 
/* 58 */         } else if(displayMsg) {
/* 59 */             this.displayMsgTask.delay(this.displayMsgTimeout);
/* 60 */ 
/* 61 */             this.loadingMsgDiv.show();
/* 62 */             this.loadingMsgDiv.getEl().fadeIn();
/* 63 */ 
/* 64 */             this.loadingMsgDiv.task.delay(3000);
/* 65 */         }
/* 66 */     }
/* 67 */ });
/* 68 */ 

;
/* Patches.js */

/* 1   */ Ext.define('Ext.patch,EXTJS16166', {
/* 2   */     override: 'Ext.view.View',
/* 3   */     compatibility: '5.1.0.107',
/* 4   */     handleEvent: function(e) {
/* 5   */         var me = this,
/* 6   */             isKeyEvent = me.keyEventRe.test(e.type),
/* 7   */             nm = me.getNavigationModel();
/* 8   */ 
/* 9   */         e.view = me;
/* 10  */ 
/* 11  */         if (isKeyEvent) {
/* 12  */             e.item = nm.getItem();
/* 13  */             e.record = nm.getRecord();
/* 14  */         }
/* 15  */ 
/* 16  */         // If the key event was fired programatically, it will not have triggered the focus
/* 17  */         // so the NavigationModel will not have this information.
/* 18  */         if (!e.item) {
/* 19  */             e.item = e.getTarget(me.itemSelector);
/* 20  */         }
/* 21  */         if (e.item && !e.record) {
/* 22  */             e.record = me.getRecord(e.item);
/* 23  */         }
/* 24  */ 
/* 25  */         if (me.processUIEvent(e) !== false) {
/* 26  */             me.processSpecialEvent(e);
/* 27  */         }
/* 28  */ 
/* 29  */         // We need to prevent default action on navigation keys
/* 30  */         // that can cause View element scroll unless the event is from an input field.
/* 31  */         // We MUST prevent browser's default action on SPACE which is to focus the event's target element.
/* 32  */         // Focusing causes the browser to attempt to scroll the element into view.
/* 33  */ 
/* 34  */         if (isKeyEvent && !Ext.fly(e.target).isInputField()) {
/* 35  */             if (e.getKey() === e.SPACE || e.isNavKeyPress(true)) {
/* 36  */                 e.preventDefault();
/* 37  */             }
/* 38  */         }
/* 39  */     }
/* 40  */ });
/* 41  */ 
/* 42  */ Ext.define('Ext.overrides.util.Collection', {
/* 43  */     override: 'Ext.util.Collection',
/* 44  */     compatibility: '5.1.0.107',
/* 45  */ 
/* 46  */     updateKey: function (item, oldKey) {
/* 47  */         var me = this,
/* 48  */             map = me.map,
/* 49  */             indices = me.indices,
/* 50  */             source = me.getSource(),

/* Patches.js */

/* 51  */             newKey;
/* 52  */ 
/* 53  */         if (source && !source.updating) {
/* 54  */             // If we are being told of the key change and the source has the same idea
/* 55  */             // on keying the item, push the change down instead.
/* 56  */             source.updateKey(item, oldKey);
/* 57  */         }
/* 58  */         // If there *is* an existing item by the oldKey and the key yielded by the new item is different from the oldKey...
/* 59  */         else if (map[oldKey] && (newKey = me.getKey(item)) !== oldKey) {
/* 60  */             if (oldKey in map || map[newKey] !== item) {
/* 61  */                 if (oldKey in map) {
/* 62  */                     //<debug>
/* 63  */                     if (map[oldKey] !== item) {
/* 64  */                         Ext.Error.raise('Incorrect oldKey "' + oldKey +
/* 65  */                                         '" for item with newKey "' + newKey + '"');
/* 66  */                     }
/* 67  */                     //</debug>
/* 68  */ 
/* 69  */                     delete map[oldKey];
/* 70  */                 }
/* 71  */ 
/* 72  */                 // We need to mark ourselves as updating so that observing collections
/* 73  */                 // don't reflect the updateKey back to us (see above check) but this is
/* 74  */                 // not really a normal update cycle so we don't call begin/endUpdate.
/* 75  */                 me.updating++;
/* 76  */ 
/* 77  */                 me.generation++;
/* 78  */                 map[newKey] = item;
/* 79  */                 if (indices) {
/* 80  */                     indices[newKey] = indices[oldKey];
/* 81  */                     delete indices[oldKey];
/* 82  */                 }
/* 83  */ 
/* 84  */                 me.notify('updatekey', [{
/* 85  */                     item: item,
/* 86  */                     newKey: newKey,
/* 87  */                     oldKey: oldKey
/* 88  */                 }]);
/* 89  */ 
/* 90  */                 me.updating--;
/* 91  */             }
/* 92  */         }
/* 93  */     }
/* 94  */ });
/* 95  */ 
/* 96  */ //VBox layout scroll restore issue
/* 97  */ Ext.define('My.override.VBoxLayoutFix', {
/* 98  */     override: 'Ext.layout.container.VBox',
/* 99  */     beginLayout: function(ownerContext) {
/* 100 */         var scrollable = this.owner.getScrollable();

/* Patches.js */

/* 101 */         if (scrollable) {
/* 102 */             this.lastScrollPosition = scrollable.getPosition();
/* 103 */         }
/* 104 */         this.callParent(arguments);
/* 105 */     },
/* 106 */     completeLayout: function(ownerContext) {
/* 107 */         var scrollable = this.owner.getScrollable();
/* 108 */         this.callParent(arguments);
/* 109 */         if (scrollable) {
/* 110 */             scrollable.scrollTo(this.lastScrollPosition);
/* 111 */         }
/* 112 */     }
/* 113 */ });
/* 114 */ 
/* 115 */ /* visual editors bug in chrome */
/* 116 */ if(Ext.isChrome && Ext.chromeVersion===43) {
/* 117 */     Ext.getBody().addCls('chrome-43');
/* 118 */ }
/* 119 */ 
/* 120 */ 

;
/* DayDropZone.js */

/* 1   */ Ext.namespace('Ext.calendar.view');
/* 2   */ 
/* 3   */ Ext.override(Ext.calendar.dd.DayDropZone, {
/* 4   */     //Override translations
/* 5   */ 
/* 6   */     // override methods that use time fromat to use user time format (App.timeFormat)
/* 7   */     onNodeOver: function(n, dd, e, data) {
/* 8   */         var dt,
/* 9   */             box,
/* 10  */             endDt,
/* 11  */             text = this.createText,
/* 12  */             curr,
/* 13  */             start,
/* 14  */             end,
/* 15  */             evtEl,
/* 16  */             dayCol;
/* 17  */         if (data.type === 'caldrag') {
/* 18  */             if (!this.dragStartMarker) {
/* 19  */                 // Since the container can scroll, this gets a little tricky.
/* 20  */                 // There is no el in the DOM that we can measure by default since
/* 21  */                 // the box is simply calculated from the original drag start (as opposed
/* 22  */                 // to dragging or resizing the event where the orig event box is present).
/* 23  */                 // To work around this we add a placeholder el into the DOM and give it
/* 24  */                 // the original starting time's box so that we can grab its updated
/* 25  */                 // box measurements as the underlying container scrolls up or down.
/* 26  */                 // This placeholder is removed in onNodeDrop.
/* 27  */                 this.dragStartMarker = n.el.parent().createChild({
/* 28  */                     style: 'position:absolute;'
/* 29  */                 });
/* 30  */                 this.dragStartMarker.setBox(n.timeBox);
/* 31  */                 this.dragCreateDt = n.date;
/* 32  */             }
/* 33  */             box = this.dragStartMarker.getBox();
/* 34  */             box.height = Math.ceil(Math.abs(e.xy[1] - box.y) / n.timeBox.height) * n.timeBox.height;
/* 35  */ 
/* 36  */             if (e.xy[1] < box.y) {
/* 37  */                 box.height += n.timeBox.height;
/* 38  */                 box.y = box.y - box.height + n.timeBox.height;
/* 39  */                 endDt = Ext.Date.add(this.dragCreateDt, Ext.Date.MINUTE, 30);
/* 40  */             }
/* 41  */             else {
/* 42  */                 n.date = Ext.Date.add(n.date, Ext.Date.MINUTE, 30);
/* 43  */             }
/* 44  */             this.shim(this.dragCreateDt, box);
/* 45  */ 
/* 46  */             curr = Ext.calendar.util.Date.copyTime(n.date, this.dragCreateDt);
/* 47  */             this.dragStartDate = Ext.calendar.util.Date.min(this.dragCreateDt, curr);
/* 48  */             this.dragEndDate = endDt || Ext.calendar.util.Date.max(this.dragCreateDt, curr);
/* 49  */ 
/* 50  */             dt = Ext.Date.format(this.dragStartDate, App.timeFormat + '-') + Ext.Date.format(this.dragEndDate, App.timeFormat);

/* DayDropZone.js */

/* 51  */         }
/* 52  */         else {
/* 53  */             evtEl = Ext.get(data.ddel);
/* 54  */             dayCol = evtEl.parent().parent();
/* 55  */             box = evtEl.getBox();
/* 56  */ 
/* 57  */             box.width = dayCol.getWidth();
/* 58  */ 
/* 59  */             if (data.type === 'eventdrag') {
/* 60  */                 if (this.dragOffset === undefined) {
/* 61  */                     this.dragOffset = n.timeBox.y - box.y;
/* 62  */                     box.y = n.timeBox.y - this.dragOffset;
/* 63  */                 }
/* 64  */                 else {
/* 65  */                     box.y = n.timeBox.y;
/* 66  */                 }
/* 67  */                 dt = Ext.Date.format(n.date, 'n/j ' + App.timeFormat);
/* 68  */                 box.x = n.el.getX();
/* 69  */ 
/* 70  */                 this.shim(n.date, box);
/* 71  */                 text = this.moveText;
/* 72  */             }
/* 73  */             if (data.type === 'eventresize') {
/* 74  */                 if (!this.resizeDt) {
/* 75  */                     this.resizeDt = n.date;
/* 76  */                 }
/* 77  */                 box.x = dayCol.getX();
/* 78  */                 box.height = Math.ceil(Math.abs(e.xy[1] - box.y) / n.timeBox.height) * n.timeBox.height;
/* 79  */                 if (e.xy[1] < box.y) {
/* 80  */                     box.y -= box.height;
/* 81  */                 }
/* 82  */                 else {
/* 83  */                     n.date = Ext.Date.add(n.date, Ext.Date.MINUTE, 30);
/* 84  */                 }
/* 85  */                 this.shim(this.resizeDt, box);
/* 86  */ 
/* 87  */                 curr = Ext.calendar.util.Date.copyTime(n.date, this.resizeDt);
/* 88  */                 start = Ext.calendar.util.Date.min(data.eventStart, curr);
/* 89  */                 end = Ext.calendar.util.Date.max(data.eventStart, curr);
/* 90  */ 
/* 91  */                 data.resizeDates = {
/* 92  */                     StartDate: start,
/* 93  */                     EndDate: end
/* 94  */                 };
/* 95  */                 dt = Ext.Date.format(start, App.timeFormat + '-') + Ext.Date.format(end, App.timeFormat);
/* 96  */                 text = this.resizeText;
/* 97  */             }
/* 98  */         }
/* 99  */ 
/* 100 */         data.proxy.updateMsg(Ext.util.Format.format(text, dt));

/* DayDropZone.js */

/* 101 */         return this.dropAllowed;
/* 102 */     }
/* 103 */ });
/* 104 */ 

;
/* DateRange.js */

/* 1 */ Ext.namespace('Ext.calendar.form.field');
/* 2 */ 
/* 3 */ Ext.override(Ext.calendar.form.field.DateRange, {
/* 4 */     //Override translations
/* 5 */     toText: L.to
/* 6 */     ,allDayText: L.AllDay
/* 7 */ });
/* 8 */ 

;
/* BoxLayout.js */

/* 1  */ Ext.namespace('Ext.calendar.view');
/* 2  */ 
/* 3  */ Ext.override(Ext.calendar.template.BoxLayout, {
/* 4  */     //Override translations
/* 5  */ 
/* 6  */     // override methods that use time fromat to use user time format (App.timeFormat)
/* 7  */     getTodayText : function(){
/* 8  */         var dt = Ext.Date.format(new Date(), 'l, F j, Y'),
/* 9  */             fmt,
/* 10 */             todayText = this.showTodayText !== false ? this.todayText : '',
/* 11 */             timeText = this.showTime !== false ? ' <span id="'+this.id+'-clock" class="ext-cal-dtitle-time">' +
/* 12 */                     Ext.Date.format(new Date(), App.timeFormat) + '</span>' : '',
/* 13 */             separator = todayText.length > 0 || timeText.length > 0 ? ' &mdash; ' : '';
/* 14 */ 
/* 15 */         if(this.dayCount == 1){
/* 16 */             return dt + separator + todayText + timeText;
/* 17 */         }
/* 18 */         fmt = this.weekCount == 1 ? 'D j' : 'j';
/* 19 */         return todayText.length > 0 ? todayText + timeText : Ext.Date.format(new Date(), fmt) + timeText;
/* 20 */     }
/* 21 */ });
/* 22 */ 

;
/* Day.js */

/* 1 */ Ext.namespace('Ext.calendar.view');
/* 2 */ 
/* 3 */ Ext.override(Ext.calendar.view.Day, {
/* 4 */     //Override translations
/* 5 */     todayText: L.Today
/* 6 */ });
/* 7 */ 

;
/* DayBody.js */

/* 1  */ Ext.namespace('Ext.calendar.view');
/* 2  */ 
/* 3  */ Ext.override(Ext.calendar.view.DayBody, {
/* 4  */     //Override translations
/* 5  */ 
/* 6  */     // override methods that use time fromat to use user time format (App.timeFormat)
/* 7  */ 
/* 8  */     // private
/* 9  */     getTemplateEventData: function(evt) {
/* 10 */         var selector = this.getEventSelectorCls(evt[Ext.calendar.data.EventMappings.EventId.name]),
/* 11 */             data = {},
/* 12 */             M = Ext.calendar.data.EventMappings;
/* 13 */ 
/* 14 */         this.getTemplateEventBox(evt);
/* 15 */ 
/* 16 */         data._selectorCls = selector;
/* 17 */         data._colorCls = 'ext-color-' + (evt[M.CalendarId.name] || '0') + (evt._renderAsAllDay ? '-ad': '');
/* 18 */         data._elId = selector + (evt._weekIndex ? '-' + evt._weekIndex: '');
/* 19 */         data._isRecurring = evt.Recurrence && !Ext.isEmpty(evt.Recurrence);
/* 20 */         data._isReminder = evt[M.Reminder.name] && !Ext.isEmpty(evt[M.Reminder.name]);
/* 21 */         var title = evt[M.Title.name];
/* 22 */         data.Title = (
/* 23 */             evt[M.IsAllDay.name]
/* 24 */             ? ''
/* 25 */             : Ext.Date.format(evt[M.StartDate.name], App.timeFormat + ' ')
/* 26 */         ) + Ext.valueFrom(title, '(No title)');
/* 27 */ 
/* 28 */         return Ext.applyIf(data, evt);
/* 29 */     }
/* 30 */ });
/* 31 */ 

;
/* Month.js */

/* 1  */ Ext.namespace('Ext.calendar.view');
/* 2  */ 
/* 3  */ Ext.override(Ext.calendar.view.Month, {
/* 4  */     //Override translations
/* 5  */     todayText: L.Today
/* 6  */ 
/* 7  */     // override methods that use time fromat to use user time format (App.timeFormat)
/* 8  */ 
/* 9  */     //private
/* 10 */     ,initClock: function() {
/* 11 */         if (Ext.fly(this.id + '-clock') !== null) {
/* 12 */             this.prevClockDay = new Date().getDay();
/* 13 */             if (this.clockTask) {
/* 14 */                 Ext.TaskManager.stop(this.clockTask);
/* 15 */             }
/* 16 */             this.clockTask = Ext.TaskManager.start({
/* 17 */                 run: function() {
/* 18 */                     var el = Ext.fly(this.id + '-clock'),
/* 19 */                     t = new Date();
/* 20 */ 
/* 21 */                     if (t.getDay() == this.prevClockDay) {
/* 22 */                         if (el) {
/* 23 */                             el.update(Ext.Date.format(t, App.timeFormat));
/* 24 */                         }
/* 25 */                     }
/* 26 */                     else {
/* 27 */                         this.prevClockDay = t.getDay();
/* 28 */                         this.moveTo(t);
/* 29 */                     }
/* 30 */                 },
/* 31 */                 scope: this,
/* 32 */                 interval: 1000
/* 33 */             });
/* 34 */         }
/* 35 */     }
/* 36 */ 
/* 37 */     // private
/* 38 */     ,getTemplateEventData: function(evt) {
/* 39 */         var M = Ext.calendar.data.EventMappings,
/* 40 */         selector = this.getEventSelectorCls(evt[M.EventId.name]),
/* 41 */         title = evt[M.Title.name];
/* 42 */ 
/* 43 */         return Ext.applyIf({
/* 44 */             _selectorCls: selector,
/* 45 */             _colorCls: 'ext-color-' + (evt[M.CalendarId.name] ?
/* 46 */             evt[M.CalendarId.name] : 'default') + (evt._renderAsAllDay ? '-ad': ''),
/* 47 */             _elId: selector + '-' + evt._weekIndex,
/* 48 */             _isRecurring: evt.Recurrence && !Ext.isEmpty(evt.Recurrence),
/* 49 */             _isReminder: evt[M.Reminder.name] && !Ext.isEmpty(evt[M.Reminder.name]),
/* 50 */             Title: (evt[M.IsAllDay.name]

/* Month.js */

/* 51 */                 ? ''
/* 52 */                 : Ext.Date.format(evt[M.StartDate.name], App.timeFormat + ' ')
/* 53 */             ) + Ext.valueFrom(title, '(No title)'),
/* 54 */             _operaLT11: this.operaLT11 ? 'ext-operaLT11' : ''
/* 55 */         },
/* 56 */         evt);
/* 57 */     }
/* 58 */ 
/* 59 */ });
/* 60 */ 

;
/* CalendarPanel.js */

/* 1  */ Ext.namespace('Ext.calendar');
/* 2  */ 
/* 3  */ Ext.override(Ext.calendar.CalendarPanel, {
/* 4  */     //Override translations
/* 5  */     todayText: L.Today
/* 6  */     ,dayText: L.Day
/* 7  */     ,weekText: L.Week
/* 8  */     ,monthText: L.Month
/* 9  */ });
/* 10 */ 

;
/* Store.js */

/* 1  */ Ext.namespace('Ext.data');
/* 2  */ 
/* 3  */ Ext.override(Ext.data.Store, {
/* 4  */     deleteIds: function(ids){
/* 5  */         var idx
/* 6  */             ,idProperty = (Ext.isEmpty(this.proxy) || Ext.isEmpty(this.proxy.reader))
/* 7  */                 ? 'id'
/* 8  */                 : Ext.valueFrom(
/* 9  */                     Ext.valueFrom(
/* 10 */                         this.proxy.reader.idProperty
/* 11 */                         ,this.proxy.reader.config.idProperty
/* 12 */                     )
/* 13 */                     ,'id'
/* 14 */                 );
/* 15 */ 
/* 16 */         if(Ext.isPrimitive(ids)) {
/* 17 */             ids = String(ids).split(',');
/* 18 */         }
/* 19 */ 
/* 20 */         if((this.getCount() > 0) && this.data) {
/* 21 */             for (var i = 0; i < ids.length; i++) {
/* 22 */                 idx = this.findExact(idProperty, String(ids[i]));
/* 23 */ 
/* 24 */                 if(idx < 0) {
/* 25 */                     idx = this.findExact(idProperty, parseInt(ids[i], 10));
/* 26 */                 }
/* 27 */ 
/* 28 */                 if(idx >= 0) {
/* 29 */                     this.removeAt(idx);
/* 30 */                 }
/* 31 */             }
/* 32 */         }
/* 33 */     }
/* 34 */ });
/* 35 */ 

;
/* CellEditing.js */

/* 1  */ /*
/* 2  *|     Overrides
/* 3  *| */
/* 4  */ 
/* 5  */ Ext.override(Ext.grid.plugin.CellEditing, {
/* 6  */ 
/* 7  */     //overriding onEditComplete method
/* 8  */     //used for CB.plugin.field.DropDownList to avoid canceling edit when popup list visible
/* 9  */ 
/* 10 */     onEditComplete : function(ed, value, startValue) {
/* 11 */         if(ed.field) {
/* 12 */             if(ed.field.preventEditComplete) {
/* 13 */                 delete ed.field.preventEditComplete;
/* 14 */                 return;
/* 15 */             }
/* 16 */         }
/* 17 */ 
/* 18 */         this.callParent(arguments);
/* 19 */     }
/* 20 */ });
/* 21 */ 

;
/* CellEditor.js */

/* 1  */ /*
/* 2  *|     Overrides
/* 3  *| */
/* 4  */ 
/* 5  */ Ext.override(Ext.grid.CellEditor, {
/* 6  */ 
/* 7  */     //overriding onEditComplete method
/* 8  */     //used for CB.plugin.field.DropDownList to avoid canceling edit when popup list visible
/* 9  */ 
/* 10 */     onEditComplete: function(remainVisible) {
/* 11 */         if(this.field) {
/* 12 */             if(this.field.preventEditComplete) {
/* 13 */                 // we dont delete the flag here
/* 14 */                 // it will be deleted by CellEditing plugin onEditComplete overriden method
/* 15 */                 // delete this.field.preventEditComplete;
/* 16 */ 
/* 17 */                 return;
/* 18 */             }
/* 19 */         }
/* 20 */ 
/* 21 */         this.callParent(arguments);
/* 22 */     }
/* 23 */ });
/* 24 */ 

;
/* GridPanel.js */

/* 1   */ /*
/* 2   *|     Overrides
/* 3   *| */
/* 4   */ 
/* 5   */ Ext.override(Ext.grid.GridPanel, {
/* 6   */ 
/* 7   */     getState: function(remainVisible) {
/* 8   */         var rez = {columns: {}}
/* 9   */             ,store = this.store
/* 10  */             ,cols = this.headerCt.getGridColumns()
/* 11  */             ,gs
/* 12  */             ,c
/* 13  */             ,di;
/* 14  */ 
/* 15  */         for(var i = 0; i < cols.length; i++){
/* 16  */             c = cols[i];
/* 17  */             di = c.dataIndex;
/* 18  */ 
/* 19  */             //hidden', 'sortable', 'locked', 'flex', 'width
/* 20  */             rez.columns[di] = {
/* 21  */                 idx: i
/* 22  */             };
/* 23  */ 
/* 24  */             if(c.width){
/* 25  */                 rez.columns[di].width = c.width;
/* 26  */             }
/* 27  */ 
/* 28  */             if(c.hidden){
/* 29  */                 rez.columns[di].hidden = true;
/* 30  */             }
/* 31  */ 
/* 32  */             if(c.sortable){
/* 33  */                 rez.columns[di].sortable = true;
/* 34  */             }
/* 35  */ 
/* 36  */             if(c.locked){
/* 37  */                 rez.columns[di].locked = true;
/* 38  */             }
/* 39  */ 
/* 40  */             if(c.flex){
/* 41  */                 rez.columns[di].flex = c.flex;
/* 42  */             }
/* 43  */ 
/* 44  */         }
/* 45  */ 
/* 46  */         if(store){
/* 47  */             var ss = store.getSorters().getAt(0);
/* 48  */ 
/* 49  */             if(ss && ss.getState){
/* 50  */                 rez.sort = ss.getState();

/* GridPanel.js */

/* 51  */             }
/* 52  */ 
/* 53  */             if(store.getGrouper){
/* 54  */                 rez.group = store.getGrouper();
/* 55  */                 if(rez.group) {
/* 56  */                     rez.group = rez.group.config;
/* 57  */                     rez.group.property = store.proxy.extraParams.sourceGroupField;
/* 58  */                 }
/* 59  */             }
/* 60  */         }
/* 61  */ 
/* 62  */         return rez;
/* 63  */     }
/* 64  */ 
/* 65  */     // ,applyState: function (state) {
/* 66  */     //     var me = this
/* 67  */     //         ,sorter = state.sort
/* 68  */     //         ,store = me.store
/* 69  */     //         ,columns = state.columns
/* 70  */     //         ,currentColumns = this.headerCt.getGridColumns()
/* 71  */     //         ,newColumns = [];
/* 72  */ 
/* 73  */     //     delete state.columns;
/* 74  */     //     clog('applying state', this, state, columns);
/* 75  */ 
/* 76  */     //     // Ensure superclass has applied *its* state.
/* 77  */     //     // Component saves dimensions (and anchor/flex) plus collapsed state.
/* 78  */     //     me.callParent(arguments);
/* 79  */ 
/* 80  */     //     //set stateId for received state based on column dataindex
/* 81  */     //     for (var i = currentColumns.length - 1; i >= 0; i--) {
/* 82  */     //         var di = currentColumns[i].dataIndex
/* 83  */     //             ,column = Ext.apply({}, currentColumns[i].initialConfig);
/* 84  */ 
/* 85  */     //         if(Ext.isDefined(columns[di])) {
/* 86  */     //             Ext.apply(column, columns[di]);
/* 87  */     //             column.width = Ext.valueFrom(column.width, column.flex);
/* 88  */     //             clog('apply column state', column, columns[di]);
/* 89  */     //             // currentColumns[i].applyColumnsState(columns[di]);
/* 90  */ 
/* 91  */     //             // this.columns[i].applyColumnsState(columns[di]);
/* 92  */     //             // columns[di].id = currentColumns[i].getStateId();
/* 93  */     //             // newColumns[columns[di].idx] = columns[di];
/* 94  */     //         }
/* 95  */     //         newColumns.push(column);
/* 96  */     //     }
/* 97  */ 
/* 98  */     //     clog('newColumns', newColumns);
/* 99  */     //     if (newColumns) {
/* 100 */     //         me.reconfigure(null, newColumns);

/* GridPanel.js */

/* 101 */     //     }
/* 102 */ 
/* 103 */     //     // Old stored sort state. Deprecated and will die out.
/* 104 */     //     if (sorter) {
/* 105 */     //         if (store.remoteSort) {
/* 106 */     //             // Pass false to prevent a sort from occurring.
/* 107 */     //             store.sort({
/* 108 */     //                 property: sorter.property,
/* 109 */     //                 direction: sorter.direction,
/* 110 */     //                 root: sorter.root
/* 111 */     //             }, null, false);
/* 112 */     //         } else {
/* 113 */     //             store.sort(sorter.property, sorter.direction);
/* 114 */     //         }
/* 115 */     //     }
/* 116 */     //     // New storeState which encapsulates groupers, sorters and filters.
/* 117 */     //     // else if (storeState) {
/* 118 */     //     //     store.applyState(storeState);
/* 119 */     //     // }
/* 120 */     // }
/* 121 */ });
/* 122 */ 

;
/* ViewDragZone.js */

/* 1  */ /*
/* 2  *|     Overrides for preventing nodes selection when start dragging node
/* 3  *| */
/* 4  */ 
/* 5  */ Ext.override(Ext.tree.ViewDragZone, {
/* 6  */     lastClickAt: null,
/* 7  */     b4MouseDown : function(e){
/* 8  */         var view = this.view
/* 9  */             ,sm = view.getSelectionModel();
/* 10 */         this.lastClickAt = e.getXY();
/* 11 */         if(sm) {
/* 12 */             view.suspendEvents(true);
/* 13 */             sm.suspendEvents(true);
/* 14 */         }
/* 15 */         this.callParent(arguments);
/* 16 */     }
/* 17 */ });
/* 18 */ 
/* 19 */ Ext.override(Ext.tree.ViewDragZone, {
/* 20 */     onMouseUp : function(e){
/* 21 */         var view = this.view
/* 22 */             ,sm = view.getSelectionModel();
/* 23 */         var loc = e.getXY();
/* 24 */         if(sm && (Ext.isEmpty(this.lastClickAt) || (this.lastClickAt[0] == loc[0] && this.lastClickAt[1] == loc[1]))) {
/* 25 */             sm.resumeEvents();
/* 26 */             view.resumeEvents();
/* 27 */         } else{
/* 28 */             sm.resumeEvents(true);
/* 29 */             view.resumeEvents(true);
/* 30 */         }
/* 31 */         this.callParent(arguments);
/* 32 */     }
/* 33 */ });
/* 34 */ 

;
/* Toolbar.js */

/* 1  */ /*
/* 2  *|     Overrides
/* 3  *| */
/* 4  */ 
/* 5  */ Ext.override(Ext.toolbar.Toolbar, {
/* 6  */ 
/* 7  */     hideInutilSeparators: function() {
/* 8  */         // return;
/* 9  */         var vi = []; //visible items
/* 10 */ 
/* 11 */         //collect all visible items
/* 12 */         this.items.each(
/* 13 */             function(i, idx, len){
/* 14 */                 if(i.isVisible()) {
/* 15 */                     vi.push(i);
/* 16 */                 }
/* 17 */             }
/* 18 */             ,this
/* 19 */         );
/* 20 */ 
/* 21 */         //now iterate the array and hide tbsplitters at the begining,
/* 22 */         //at the end, consecutive, before and after spacer.
/* 23 */         for (var i = 0; i < vi.length; i++) {
/* 24 */             if(vi[i].xtype === 'tbseparator') {
/* 25 */                 vi[i].setHidden(
/* 26 */                     (i === 0) || // at the begining
/* 27 */                     (i == (vi.length-1)) || // at the end
/* 28 */                     (vi[i+1].xtype === 'tbfill') || // before tbfill
/* 29 */                     (vi[i-1].xtype === 'tbfill') || // after tbfill
/* 30 */                     (vi[i-1].xtype === 'tbseparator') // after another tbseparator
/* 31 */                 );
/* 32 */             }
/* 33 */         }
/* 34 */     }
/* 35 */ });
/* 36 */ 

;
/* Collection.js */

/* 1  */ Ext.namespace('Ext.util');
/* 2  */ 
/* 3  */ //there are some situations when mixed collection has null defined "items" property
/* 4  */ //and results in error
/* 5  */ Ext.util.Collection.prototype._getAt = Ext.util.Collection.prototype.getAt;
/* 6  */ 
/* 7  */ Ext.util.Collection.prototype.getAt = function(index){
/* 8  */     if(Ext.isEmpty(this.items)){
/* 9  */         clog('Found MixedCollextion with empty "items" property', this);
/* 10 */         return 'null';
/* 11 */     }
/* 12 */     return this._getAt(index);
/* 13 */ };
/* 14 */ 

;
/* AbstractMixedCollection.js */

/* 1  */ Ext.namespace('Ext.util');
/* 2  */ 
/* 3  */ /*
/* 4  *|     Overrides for Mixed collection
/* 5  *| */
/* 6  */ 
/* 7  */ Ext.override(Ext.util.AbstractMixedCollection, {
/* 8  */     /**
/* 9  *|      * allow to get an item by itemId property while items added with addAll without id property
/* 10 *|      * @param {String/Number} key The key or index of the item.
/* 11 *|      * @return {Object}
/* 12 *|      */
/* 13 */     get: function(key){
/* 14 */         var rez = this.callParent(arguments);
/* 15 */ 
/* 16 */         if(Ext.isEmpty(rez) && Ext.isPrimitive(key)) {
/* 17 */             var idx = this.findIndex('itemId', key);
/* 18 */             if(idx > -1) {
/* 19 */                 rez = this.getAt(idx);
/* 20 */             }
/* 21 */         }
/* 22 */ 
/* 23 */         return rez;
/* 24 */     }
/* 25 */ 
/* 26 */     ,indexOfKey : function(key) {
/* 27 */         if (!this.map.hasOwnProperty(key)) {
/* 28 */             this.length = this.items.length;
/* 29 */ 
/* 30 */             return this.keys.indexOf(key);
/* 31 */         }
/* 32 */ 
/* 33 */         if (this.indexGeneration !== this.generation) {
/* 34 */             this.rebuildIndexMap();
/* 35 */         }
/* 36 */ 
/* 37 */         return this.indexMap[key];
/* 38 */     }
/* 39 */ });
/* 40 */ 

;
/* Format.js */

/* 1  */ Ext.namespace('Ext.util');
/* 2  */ 
/* 3  */ //improve stripTags function
/* 4  */ Ext.util.Format.stripTags = function (str, allow) {
/* 5  */     str = String(str);
/* 6  */     // making sure the allow arg is a string containing only tags in lowercase (<a><b><c>)
/* 7  */     allow = (((allow || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
/* 8  */ 
/* 9  */     var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi;
/* 10 */     var commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
/* 11 */     return str.replace(commentsAndPhpTags, '').replace(
/* 12 */         tags
/* 13 */         ,function ($0, $1) {
/* 14 */             return allow.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
/* 15 */         }
/* 16 */     );
/* 17 */ };
/* 18 */ 
