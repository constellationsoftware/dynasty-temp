Ext.define('DynastyDraft.view.StatusMask', {
    extend: 'Ext.LoadMask',
    alias: 'widget.statusmask',
    alternateClassName: 'Ext.ux.StatusMask',

    /**
     * Associates a status message to an Observable object's (or Ext.Element) event,
     * along with an action to take in conjunction with the event. Since the events
     * are bound using {@link #addManagedListener}, they are automatically removed
     * when this Component is destroyed.
     *
     * @param {Ext.util.Observable/Ext.Element} item The item to which to add a listener/listeners.
     * @param {Object/String} events The event name, or an object containing event name properties.
     * @param {Function} fn (optional) If the `ename` parameter was an event name, this is the handler function.
     * @param {Object} scope (optional) If the `ename` parameter was an event name, this is the scope (`this` reference)
     * in which the handler function is executed.
     * @param {Object} opt (optional) If the `ename` parameter was an event name, this is the
     * {@link Ext.util.Observable#addListener addListener} options.
     */
    bindStatusEvent: function(item, events, fn, opt) {
        
    }
});
