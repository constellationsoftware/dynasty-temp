Ext.data.JsonP.Ext_layout_container_Fit({"allMixins":[],"tagname":"class","deprecated":null,"singleton":false,"author":null,"alias":null,"superclasses":["Ext.Base","Ext.layout.Layout","Ext.layout.container.AbstractContainer","Ext.layout.container.Container","Ext.layout.container.AbstractFit","Ext.layout.container.Fit"],"mixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Alternate names</h4><div class='alternate-class-name'>Ext.layout.FitLayout</div><h4>Hierarchy</h4><div class='subclass first-child'><a href='#!/api/Ext.Base' rel='Ext.Base' class='docClass'>Ext.Base</a><div class='subclass '><a href='#!/api/Ext.layout.Layout' rel='Ext.layout.Layout' class='docClass'>Ext.layout.Layout</a><div class='subclass '><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='docClass'>Ext.layout.container.AbstractContainer</a><div class='subclass '><a href='#!/api/Ext.layout.container.Container' rel='Ext.layout.container.Container' class='docClass'>Ext.layout.container.Container</a><div class='subclass '><a href='#!/api/Ext.layout.container.AbstractFit' rel='Ext.layout.container.AbstractFit' class='docClass'>Ext.layout.container.AbstractFit</a><div class='subclass '><strong>Ext.layout.container.Fit</strong></div></div></div></div></div></div></pre><div class='doc-contents'><p>This is a base class for layouts that contain <strong>a single item</strong> that automatically expands to fill the layout's\ncontainer. This class is intended to be extended or created via the <code>layout: 'fit'</code>\n<a href=\"#!/api/Ext.container.Container-cfg-layout\" rel=\"Ext.container.Container-cfg-layout\" class=\"docClass\">Ext.container.Container.layout</a> config, and should generally not need to be created directly via the new keyword.</p>\n\n<p>Fit layout does not have any direct config options (other than inherited ones). To fit a panel to a container using\nFit layout, simply set <code>layout: 'fit'</code> on the container and add a single panel to it. If the container has multiple\npanels, only the first one will be displayed.</p>\n\n<pre class=\"inline-example\"><code>Ext.create('Ext.panel.Panel', {\n    title: 'Fit Layout',\n    width: 300,\n    height: 150,\n    layout:'fit',\n    items: {\n        title: 'Inner Panel',\n        html: 'This is the inner panel content',\n        bodyPadding: 20,\n        border: false\n    },\n    renderTo: Ext.getBody()\n});\n</code></pre>\n</div><div class='members'><div id='m-cfg'><div class='definedBy'>Defined By</div><h3 class='members-title'>Config options</h3><div class='subsection'><div id='cfg-bindToOwnerCtComponent' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-cfg-bindToOwnerCtComponent' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-cfg-bindToOwnerCtComponent' class='name expandable'>bindToOwnerCtComponent</a><span> : Boolean</span></div><div class='description'><div class='short'>Flag to notify the ownerCt Component on afterLayout of a change ...</div><div class='long'><p>Flag to notify the ownerCt Component on afterLayout of a change</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='cfg-bindToOwnerCtContainer' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-cfg-bindToOwnerCtContainer' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-cfg-bindToOwnerCtContainer' class='name expandable'>bindToOwnerCtContainer</a><span> : Boolean</span></div><div class='description'><div class='short'>Flag to notify the ownerCt Container on afterLayout of a change ...</div><div class='long'><p>Flag to notify the ownerCt Container on afterLayout of a change</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='cfg-defaultMargins' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.Fit' rel='Ext.layout.container.Fit' class='definedIn docClass'>Ext.layout.container.Fit</a><br/><a href='source/Fit.html#Ext-layout-container-Fit-cfg-defaultMargins' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.Fit-cfg-defaultMargins' class='name expandable'>defaultMargins</a><span> : Object</span></div><div class='description'><div class='short'>If the individual contained items do not have a margins\nproperty specified or margin specified via CSS, the default m...</div><div class='long'><p>If the individual contained items do not have a <tt>margins</tt>\nproperty specified or margin specified via CSS, the default margins from this property will be\napplied to each item.</p>\n\n\n<br><p>This property may be specified as an object containing margins\n\n\n<p>to apply in the format:</p></p>\n\n<pre><code>{\n    top: (top margin),\n    right: (right margin),\n    bottom: (bottom margin),\n    left: (left margin)\n}</code></pre>\n\n\n<p>This property may also be specified as a string containing\nspace-separated, numeric margin values. The order of the sides associated\nwith each value matches the way CSS processes margin values:</p>\n\n\n<div class=\"mdetail-params\"><ul>\n<li>If there is only one value, it applies to all sides.</li>\n<li>If there are two values, the top and bottom borders are set to the\nfirst value and the right and left are set to the second.</li>\n<li>If there are three values, the top is set to the first value, the left\nand right are set to the second, and the bottom is set to the third.</li>\n<li>If there are four values, they apply to the top, right, bottom, and\nleft, respectively.</li>\n</ul></div>\n\n\n<p>Defaults to:</p>\n\n\n<pre><code>{top:0, right:0, bottom:0, left:0}\n</code></pre>\n\n<p>Defaults to: <code>{top: 0, right: 0, bottom: 0, left: 0}</code></p></div></div></div><div id='cfg-itemCls' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-cfg-itemCls' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-cfg-itemCls' class='name expandable'>itemCls</a><span> : String</span></div><div class='description'><div class='short'>An optional extra CSS class that will be added to the container. ...</div><div class='long'><p>An optional extra CSS class that will be added to the container. This can be useful for adding\ncustomized styles to the container or any of its children using standard CSS rules. See\n<a href=\"#!/api/Ext.Component\" rel=\"Ext.Component\" class=\"docClass\">Ext.Component</a>.<a href=\"#!/api/Ext.Component-cfg-componentCls\" rel=\"Ext.Component-cfg-componentCls\" class=\"docClass\">componentCls</a> also.</p>\n\n\n<p></p></p>\n</div></div></div></div></div><div id='m-property'><div class='definedBy'>Defined By</div><h3 class='members-title'>Properties</h3><div class='subsection'><div id='property-self' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-property-self' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-property-self' class='name expandable'>self</a><span> : Ext.Class</span><strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Get the reference to the current class from which this object was instantiated. ...</div><div class='long'><p>Get the reference to the current class from which this object was instantiated. Unlike <a href=\"#!/api/Ext.Base-method-statics\" rel=\"Ext.Base-method-statics\" class=\"docClass\">statics</a>,\n<code>this.self</code> is scope-dependent and it's meant to be used for dynamic inheritance. See <a href=\"#!/api/Ext.Base-method-statics\" rel=\"Ext.Base-method-statics\" class=\"docClass\">statics</a>\nfor a detailed comparison</p>\n\n<pre><code>Ext.define('My.Cat', {\n    statics: {\n        speciesName: 'Cat' // My.Cat.speciesName = 'Cat'\n    },\n\n    constructor: function() {\n        alert(this.self.speciesName); / dependent on 'this'\n\n        return this;\n    },\n\n    clone: function() {\n        return new this.self();\n    }\n});\n\n\nExt.define('My.SnowLeopard', {\n    extend: 'My.Cat',\n    statics: {\n        speciesName: 'Snow Leopard'         // My.SnowLeopard.speciesName = 'Snow Leopard'\n    }\n});\n\nvar cat = new My.Cat();                     // alerts 'Cat'\nvar snowLeopard = new My.SnowLeopard();     // alerts 'Snow Leopard'\n\nvar clone = snowLeopard.clone();\nalert(Ext.getClassName(clone));             // alerts 'My.SnowLeopard'\n</code></pre>\n</div></div></div></div></div><div id='m-method'><h3 class='members-title'>Methods</h3><div class='subsection'><div class='definedBy'>Defined By</div><h4 class='members-subtitle'>Instance Methods</h3><div id='method-beforeLayout' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-method-beforeLayout' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-method-beforeLayout' class='name expandable'>beforeLayout</a>( <span class='pre'></span> )</div><div class='description'><div class='short'>Containers should not lay out child components when collapsed. ...</div><div class='long'><p>Containers should not lay out child components when collapsed.</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>undefined</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-callOverridden' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-callOverridden' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-callOverridden' class='name expandable'>callOverridden</a>( <span class='pre'>Array/Arguments args</span> ) : Object<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Call the original method that was previously overridden with override\n\nExt.define('My.Cat', {\n    constructor: functi...</div><div class='long'><p>Call the original method that was previously overridden with <a href=\"#!/api/Ext.Base-method-override\" rel=\"Ext.Base-method-override\" class=\"docClass\">override</a></p>\n\n<pre><code>Ext.define('My.Cat', {\n    constructor: function() {\n        alert(\"I'm a cat!\");\n\n        return this;\n    }\n});\n\nMy.Cat.override({\n    constructor: function() {\n        alert(\"I'm going to be a cat!\");\n\n        var instance = this.callOverridden();\n\n        alert(\"Meeeeoooowwww\");\n\n        return instance;\n    }\n});\n\nvar kitty = new My.Cat(); // alerts \"I'm going to be a cat!\"\n                          // alerts \"I'm a cat!\"\n                          // alerts \"Meeeeoooowwww\"\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>args</span> : Array/Arguments<div class='sub-desc'><p>The arguments, either an array or the <code>arguments</code> object</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Returns the result after calling the overridden method</p>\n</div></li></ul></div></div></div><div id='method-callParent' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-callParent' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-callParent' class='name expandable'>callParent</a>( <span class='pre'>Array/Arguments args</span> ) : Object<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Call the parent's overridden method. ...</div><div class='long'><p>Call the parent's overridden method. For example:</p>\n\n<pre><code>Ext.define('My.own.A', {\n    constructor: function(test) {\n        alert(test);\n    }\n});\n\nExt.define('My.own.B', {\n    extend: 'My.own.A',\n\n    constructor: function(test) {\n        alert(test);\n\n        this.callParent([test + 1]);\n    }\n});\n\nExt.define('My.own.C', {\n    extend: 'My.own.B',\n\n    constructor: function() {\n        alert(\"Going to call parent's overriden constructor...\");\n\n        this.callParent(arguments);\n    }\n});\n\nvar a = new My.own.A(1); // alerts '1'\nvar b = new My.own.B(1); // alerts '1', then alerts '2'\nvar c = new My.own.C(2); // alerts \"Going to call parent's overriden constructor...\"\n                         // alerts '2', then alerts '3'\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>args</span> : Array/Arguments<div class='sub-desc'><p>The arguments, either an array or the <code>arguments</code> object\nfrom the current method, for example: <code>this.callParent(arguments)</code></p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Returns the result from the superclass' method</p>\n</div></li></ul></div></div></div><div id='method-destroy' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.Layout' rel='Ext.layout.Layout' class='definedIn docClass'>Ext.layout.Layout</a><br/><a href='source/Layout.html#Ext-layout-Layout-method-destroy' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.Layout-method-destroy' class='name expandable'>destroy</a>( <span class='pre'></span> )<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Destroys this layout. ...</div><div class='long'><p>Destroys this layout. This is a template method that is empty by default, but should be implemented\nby subclasses that require explicit destruction to purge event handlers or remove DOM nodes.</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>undefined</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getLayoutItems' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-method-getLayoutItems' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-method-getLayoutItems' class='name expandable'>getLayoutItems</a>( <span class='pre'></span> ) : Ext.Component[]</div><div class='description'><div class='short'>Returns an array of child components either for a render phase (Performed in the beforeLayout method of the layout's\n...</div><div class='long'><p>Returns an array of child components either for a render phase (Performed in the beforeLayout method of the layout's\nbase class), or the layout phase (onLayout).</p>\n\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Component[]</span><div class='sub-desc'><p>of child components</p>\n</div></li></ul></div></div></div><div id='method-getRenderTarget' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-method-getRenderTarget' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-method-getRenderTarget' class='name expandable'>getRenderTarget</a>( <span class='pre'></span> ) : Ext.Element</div><div class='description'><div class='short'>Returns the element into which rendering must take place. ...</div><div class='long'><p>Returns the element into which rendering must take place. Defaults to the owner Container's target element.</p>\n\n\n<p>May be overridden in layout managers which implement an inner element.</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Element</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getRenderedItems' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.Container' rel='Ext.layout.container.Container' class='definedIn docClass'>Ext.layout.container.Container</a><br/><a href='source/Container3.html#Ext-layout-container-Container-method-getRenderedItems' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.Container-method-getRenderedItems' class='name expandable'>getRenderedItems</a>( <span class='pre'></span> ) : Array<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Returns all items that are rendered ...</div><div class='long'><p>Returns all items that are rendered</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Array</span><div class='sub-desc'><p>All matching items</p>\n</div></li></ul></div></div></div><div id='method-getTarget' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.AbstractContainer' rel='Ext.layout.container.AbstractContainer' class='definedIn docClass'>Ext.layout.container.AbstractContainer</a><br/><a href='source/AbstractContainer2.html#Ext-layout-container-AbstractContainer-method-getTarget' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.AbstractContainer-method-getTarget' class='name expandable'>getTarget</a>( <span class='pre'></span> ) : Ext.Element</div><div class='description'><div class='short'>Returns the owner component's resize element. ...</div><div class='long'><p>Returns the owner component's resize element.</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Element</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getVisibleItems' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.layout.container.Container' rel='Ext.layout.container.Container' class='definedIn docClass'>Ext.layout.container.Container</a><br/><a href='source/Container3.html#Ext-layout-container-Container-method-getVisibleItems' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.layout.container.Container-method-getVisibleItems' class='name expandable'>getVisibleItems</a>( <span class='pre'></span> ) : Array<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Returns all items that are both rendered and visible ...</div><div class='long'><p>Returns all items that are both rendered and visible</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Array</span><div class='sub-desc'><p>All matching items</p>\n</div></li></ul></div></div></div><div id='method-initConfig' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-initConfig' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-initConfig' class='name expandable'>initConfig</a>( <span class='pre'>Object config</span> ) : Object<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Initialize configuration for this class. ...</div><div class='long'><p>Initialize configuration for this class. a typical example:</p>\n\n<pre><code>Ext.define('My.awesome.Class', {\n    // The default config\n    config: {\n        name: 'Awesome',\n        isAwesome: true\n    },\n\n    constructor: function(config) {\n        this.initConfig(config);\n\n        return this;\n    }\n});\n\nvar awesome = new My.awesome.Class({\n    name: 'Super Awesome'\n});\n\nalert(awesome.getName()); // 'Super Awesome'\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>config</span> : Object<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>mixins The mixin prototypes as key - value pairs</p>\n</div></li></ul></div></div></div><div id='method-statics' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-statics' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-statics' class='name expandable'>statics</a>( <span class='pre'></span> ) : Ext.Class<strong class='protected-signature'>protected</strong></div><div class='description'><div class='short'>Get the reference to the class from which this object was instantiated. ...</div><div class='long'><p>Get the reference to the class from which this object was instantiated. Note that unlike <a href=\"#!/api/Ext.Base-property-self\" rel=\"Ext.Base-property-self\" class=\"docClass\">self</a>,\n<code>this.statics()</code> is scope-independent and it always returns the class from which it was called, regardless of what\n<code>this</code> points to during run-time</p>\n\n<pre><code>Ext.define('My.Cat', {\n    statics: {\n        totalCreated: 0,\n        speciesName: 'Cat' // My.Cat.speciesName = 'Cat'\n    },\n\n    constructor: function() {\n        var statics = this.statics();\n\n        alert(statics.speciesName);     // always equals to 'Cat' no matter what 'this' refers to\n                                        // equivalent to: My.Cat.speciesName\n\n        alert(this.self.speciesName);   // dependent on 'this'\n\n        statics.totalCreated++;\n\n        return this;\n    },\n\n    clone: function() {\n        var cloned = new this.self;                      // dependent on 'this'\n\n        cloned.groupName = this.statics().speciesName;   // equivalent to: My.Cat.speciesName\n\n        return cloned;\n    }\n});\n\n\nExt.define('My.SnowLeopard', {\n    extend: 'My.Cat',\n\n    statics: {\n        speciesName: 'Snow Leopard'     // My.SnowLeopard.speciesName = 'Snow Leopard'\n    },\n\n    constructor: function() {\n        this.callParent();\n    }\n});\n\nvar cat = new My.Cat();                 // alerts 'Cat', then alerts 'Cat'\n\nvar snowLeopard = new My.SnowLeopard(); // alerts 'Cat', then alerts 'Snow Leopard'\n\nvar clone = snowLeopard.clone();\nalert(Ext.getClassName(clone));         // alerts 'My.SnowLeopard'\nalert(clone.groupName);                 // alerts 'Cat'\n\nalert(My.Cat.totalCreated);             // alerts 3\n</code></pre>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Class</span><div class='sub-desc'>\n</div></li></ul></div></div></div></div><div class='subsection'><div class='definedBy'>Defined By</div><h4 class='members-subtitle'>Static Methods</h3><div id='method-addStatics' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-addStatics' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-addStatics' class='name expandable'>addStatics</a>( <span class='pre'>Object members</span> ) : Ext.Base<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Add / override static properties of this class. ...</div><div class='long'><p>Add / override static properties of this class.</p>\n\n<pre><code>Ext.define('My.cool.Class', {\n    ...\n});\n\nMy.cool.Class.addStatics({\n    someProperty: 'someValue',      // My.cool.Class.someProperty = 'someValue'\n    method1: function() { ... },    // My.cool.Class.method1 = function() { ... };\n    method2: function() { ... }     // My.cool.Class.method2 = function() { ... };\n});\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>members</span> : Object<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Base</span><div class='sub-desc'><p>this</p>\n</div></li></ul></div></div></div><div id='method-borrow' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-borrow' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-borrow' class='name expandable'>borrow</a>( <span class='pre'>Ext.Base fromClass, String/String[] members</span> ) : Ext.Base<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Borrow another class' members to the prototype of this class. ...</div><div class='long'><p>Borrow another class' members to the prototype of this class.</p>\n\n<pre><code>Ext.define('Bank', {\n    money: '$$$',\n    printMoney: function() {\n        alert('$$$$$$$');\n    }\n});\n\nExt.define('Thief', {\n    ...\n});\n\nThief.borrow(Bank, ['money', 'printMoney']);\n\nvar steve = new Thief();\n\nalert(steve.money); // alerts '$$$'\nsteve.printMoney(); // alerts '$$$$$$$'\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>fromClass</span> : Ext.Base<div class='sub-desc'><p>The class to borrow members from</p>\n</div></li><li><span class='pre'>members</span> : String/String[]<div class='sub-desc'><p>The names of the members to borrow</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Base</span><div class='sub-desc'><p>this</p>\n</div></li></ul></div></div></div><div id='method-create' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-create' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-create' class='name expandable'>create</a>( <span class='pre'></span> ) : Object<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Create a new instance of this Class. ...</div><div class='long'><p>Create a new instance of this Class.</p>\n\n<pre><code>Ext.define('My.cool.Class', {\n    ...\n});\n\nMy.cool.Class.create({\n    someConfig: true\n});\n</code></pre>\n\n<p>All parameters are passed to the constructor of the class.</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>the created instance.</p>\n</div></li></ul></div></div></div><div id='method-createAlias' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-createAlias' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-createAlias' class='name expandable'>createAlias</a>( <span class='pre'>String/Object alias, String/Object origin</span> )<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Create aliases for existing prototype methods. ...</div><div class='long'><p>Create aliases for existing prototype methods. Example:</p>\n\n<pre><code>Ext.define('My.cool.Class', {\n    method1: function() { ... },\n    method2: function() { ... }\n});\n\nvar test = new My.cool.Class();\n\nMy.cool.Class.createAlias({\n    method3: 'method1',\n    method4: 'method2'\n});\n\ntest.method3(); // test.method1()\n\nMy.cool.Class.createAlias('method5', 'method3');\n\ntest.method5(); // test.method3() -&gt; test.method1()\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>alias</span> : String/Object<div class='sub-desc'><p>The new method name, or an object to set multiple aliases. See\n<a href=\"#!/api/Ext.Function-method-flexSetter\" rel=\"Ext.Function-method-flexSetter\" class=\"docClass\">flexSetter</a></p>\n</div></li><li><span class='pre'>origin</span> : String/Object<div class='sub-desc'><p>The original method name</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>undefined</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getName' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-getName' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-getName' class='name expandable'>getName</a>( <span class='pre'></span> ) : String<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Get the current class' name in string format. ...</div><div class='long'><p>Get the current class' name in string format.</p>\n\n<pre><code>Ext.define('My.cool.Class', {\n    constructor: function() {\n        alert(this.self.getName()); // alerts 'My.cool.Class'\n    }\n});\n\nMy.cool.Class.getName(); // 'My.cool.Class'\n</code></pre>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'><p>className</p>\n</div></li></ul></div></div></div><div id='method-implement' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-implement' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-implement' class='name expandable'>implement</a>( <span class='pre'>Object members</span> )<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Add methods / properties to the prototype of this class. ...</div><div class='long'><p>Add methods / properties to the prototype of this class.</p>\n\n<pre><code>Ext.define('My.awesome.Cat', {\n    constructor: function() {\n        ...\n    }\n});\n\n My.awesome.Cat.implement({\n     meow: function() {\n        alert('Meowww...');\n     }\n });\n\n var kitty = new My.awesome.Cat;\n kitty.meow();\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>members</span> : Object<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>undefined</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-override' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.Base' rel='Ext.Base' class='definedIn docClass'>Ext.Base</a><br/><a href='source/Base3.html#Ext-Base-method-override' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.Base-method-override' class='name expandable'>override</a>( <span class='pre'>Object members</span> ) : Ext.Base<strong class='static-signature'>static</strong></div><div class='description'><div class='short'>Override prototype members of this class. ...</div><div class='long'><p>Override prototype members of this class. Overridden methods can be invoked via\n<a href=\"#!/api/Ext.Base-method-callOverridden\" rel=\"Ext.Base-method-callOverridden\" class=\"docClass\">callOverridden</a></p>\n\n<pre><code>Ext.define('My.Cat', {\n    constructor: function() {\n        alert(\"I'm a cat!\");\n\n        return this;\n    }\n});\n\nMy.Cat.override({\n    constructor: function() {\n        alert(\"I'm going to be a cat!\");\n\n        var instance = this.callOverridden();\n\n        alert(\"Meeeeoooowwww\");\n\n        return instance;\n    }\n});\n\nvar kitty = new My.Cat(); // alerts \"I'm going to be a cat!\"\n                          // alerts \"I'm a cat!\"\n                          // alerts \"Meeeeoooowwww\"\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>members</span> : Object<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Ext.Base</span><div class='sub-desc'><p>this</p>\n</div></li></ul></div></div></div></div></div></div></div>","subclasses":["Ext.layout.container.AbstractCard"],"code_type":"ext_define","linenr":1,"html_filename":"Fit.html","alternateClassNames":["Ext.layout.FitLayout"],"protected":false,"requires":["Ext.layout.container.Box"],"docauthor":null,"static":false,"members":{"event":[],"property":[{"deprecated":null,"tagname":"property","owner":"Ext.Base","protected":true,"static":false,"name":"self","required":null}],"method":[{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"beforeLayout","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":true,"static":false,"name":"callOverridden","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":true,"static":false,"name":"callParent","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.Layout","protected":true,"static":false,"name":"destroy","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"getLayoutItems","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"getRenderTarget","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.Container","protected":true,"static":false,"name":"getRenderedItems","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"getTarget","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.layout.container.Container","protected":true,"static":false,"name":"getVisibleItems","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":true,"static":false,"name":"initConfig","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":true,"static":false,"name":"statics","required":null}],"css_var":[],"css_mixin":[],"cfg":[{"deprecated":null,"tagname":"cfg","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"bindToOwnerCtComponent","required":null},{"deprecated":null,"tagname":"cfg","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"bindToOwnerCtContainer","required":null},{"deprecated":null,"tagname":"cfg","owner":"Ext.layout.container.Fit","protected":false,"static":false,"name":"defaultMargins","required":null},{"deprecated":null,"tagname":"cfg","owner":"Ext.layout.container.AbstractContainer","protected":false,"static":false,"name":"itemCls","required":null}]},"component":false,"xtypes":[],"inheritable":false,"private":false,"extends":"Ext.layout.container.AbstractFit","name":"Ext.layout.container.Fit","statics":{"event":[],"property":[],"method":[{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"addStatics","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"borrow","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"create","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"createAlias","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"getName","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"implement","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.Base","protected":false,"static":true,"name":"override","required":null}],"css_var":[],"cfg":[],"css_mixin":[]},"mixedInto":[],"href":"Fit.html#Ext-layout-container-Fit","uses":[],"filename":"/Users/nickpoulden/Projects/sencha/SDK/extjs/src/layout/container/Fit.js"});