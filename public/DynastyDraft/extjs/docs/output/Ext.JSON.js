Ext.data.JsonP.Ext_JSON({"allMixins":[],"tagname":"class","deprecated":null,"singleton":true,"author":null,"alias":null,"superclasses":[],"mixins":[],"html":"<div><div class='doc-contents'><p>Modified version of Douglas Crockford's JSON.js that doesn't\nmess with the Object prototype\nhttp://www.json.org/js.html</p>\n</div><div class='members'><div id='m-method'><div class='definedBy'>Defined By</div><h3 class='members-title'>Methods</h3><div class='subsection'><div id='method-decode' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.JSON' rel='Ext.JSON' class='definedIn docClass'>Ext.JSON</a><br/><a href='source/JSON3.html#Ext-JSON-method-decode' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.JSON-method-decode' class='name expandable'>decode</a>( <span class='pre'>String json, [Boolean safe]</span> ) : Object</div><div class='description'><div class='short'>Decodes (parses) a JSON string to an object. ...</div><div class='long'><p>Decodes (parses) a JSON string to an object. If the JSON is invalid, this function throws a SyntaxError unless the safe option is set.</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>json</span> : String<div class='sub-desc'><p>The JSON string</p>\n</div></li><li><span class='pre'>safe</span> : Boolean (optional)<div class='sub-desc'><p>Whether to return null or throw an exception if the JSON is invalid.</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>The resulting object</p>\n</div></li></ul></div></div></div><div id='method-encode' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.JSON' rel='Ext.JSON' class='definedIn docClass'>Ext.JSON</a><br/><a href='source/JSON3.html#Ext-JSON-method-encode' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.JSON-method-encode' class='name expandable'>encode</a>( <span class='pre'>Object o</span> ) : String</div><div class='description'><div class='short'>Encodes an Object, Array or other value ...</div><div class='long'><p>Encodes an Object, Array or other value</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>o</span> : Object<div class='sub-desc'><p>The variable to encode</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'><p>The JSON string</p>\n</div></li></ul></div></div></div><div id='method-encodeDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.JSON' rel='Ext.JSON' class='definedIn docClass'>Ext.JSON</a><br/><a href='source/JSON3.html#Ext-JSON-method-encodeDate' target='_blank' class='viewSource'>view source</a></div><a href='#!/api/Ext.JSON-method-encodeDate' class='name expandable'>encodeDate</a>( <span class='pre'>Date d</span> ) : String</div><div class='description'><div class='short'>Encodes a Date. ...</div><div class='long'><p>Encodes a Date. This returns the actual string which is inserted into the JSON string as the literal expression.\n<b>The returned value includes enclosing double quotation marks.</b></p>\n\n\n<p>The default return format is \"yyyy-mm-ddThh:mm:ss\".</p>\n\n\n<p>To override this:</p>\n\n\n<pre><code>Ext.JSON.encodeDate = function(d) {\n    return Ext.Date.format(d, '\"Y-m-d\"');\n};\n     </code></pre>\n\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>d</span> : Date<div class='sub-desc'><p>The Date to encode</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'><p>The string literal to use in a JSON string.</p>\n</div></li></ul></div></div></div></div></div></div></div>","subclasses":[],"code_type":"assignment","linenr":1,"html_filename":"JSON3.html","alternateClassNames":[],"protected":false,"requires":[],"docauthor":null,"static":false,"members":{"event":[],"property":[],"method":[{"deprecated":null,"tagname":"method","owner":"Ext.JSON","protected":false,"static":false,"name":"decode","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.JSON","protected":false,"static":false,"name":"encode","required":null},{"deprecated":null,"tagname":"method","owner":"Ext.JSON","protected":false,"static":false,"name":"encodeDate","required":null}],"css_var":[],"css_mixin":[],"cfg":[]},"component":false,"xtypes":[],"inheritable":false,"private":false,"extends":null,"name":"Ext.JSON","statics":{"event":[],"property":[],"method":[],"css_var":[],"cfg":[],"css_mixin":[]},"mixedInto":[],"href":"JSON3.html#Ext-JSON","uses":[],"filename":"/Users/nickpoulden/Projects/sencha/SDK/platform/core/src/misc/JSON.js"});