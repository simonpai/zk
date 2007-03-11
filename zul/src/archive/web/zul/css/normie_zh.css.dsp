<%@ page contentType="text/css;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/tld/web/core.dsp.tld" prefix="c" %>

html {height:100%}

<%-- paragraphs --%>
p, div, span, label, a, li, dt, dd, input, textarea, pre, body {
	font-family: "Verdana", Tahoma, Arial, serif;
	font-size: small; font-weight: normal;
}
body {
	margin: 2px 5px; padding: 0;
}
button {
	font-family: Tahoma, Arial, serif;
	font-size: x-small; font-weight: normal;
}
option {
	font-family: "Verdana", Tahoma, Arial, serif;
	font-size: x-small; font-weight: normal;
}
legend {
	font-family: Tahoma, Arial, serif;
	font-size: small; font-weight: normal;
}
hr {
	color: lightgray; background: lightgray;
	height: 1px;
}
code {
	font-family: "Lucida Console", "Courier New", Courier, mono;
	font-size: x-small;  font-weight: normal;
}
dfn {
	font-family: "Lucida Console", "Courier New", Courier, mono;
	font-size: x-small; font-style: normal;
}

th {
	font-family: Tahoma, Garamond, Century, Arial, serif;
	font-weight: bold; 
}

thead tr {
	font-family: Tahoma, Garamond, Century, Arial, serif;
	font-weight: bold;
}

img	{border: 0; hspace: 0; vspace: 0}

<%-- The hyperlink's style class. --%>
.link {cursor: hand; cursor: pointer;}

<%-- ZK --%>
<%-- groupbox caption --%>
.caption input, .caption td {
	font-size: x-small;
}
.caption td.caption {
	font-size: small;
}
.caption button {
	font-size: xx-small; font-weight: normal;
	padding-top: 0; padding-bottom: 0; margin-top: 0; margin-bottom: 0;
}
.caption a, .caption a:visited {
	font-size: x-small; font-weight: normal; color: black; background: none;
	text-decoration: none;
}

<%-- window title/caption --%>
div.embedded, div.modal, div.overlapped, div.popup, div.wndcyan {
	margin: 0; padding: 0;
}

div.wi-embedded, div.wi-embedded-none, div.wi-wndcyan {
	padding:2px; background: white;
}
div.wi-embedded, div.wi-wndcyan {
	border: 1px solid #aab;
}
div.wi-modal, div.wi-modal-none {
	padding:2px; background: #f0f0d8;
}
div.wi-overlapped, div.wi-overlapped-none {
	padding:2px; background: white;
}
div.wi-popup, div.wi-popup-none {
	padding:1px; background: white;
}
div.wi-modal, div.wi-overlapped {
	border: 2px solid #1854c2;
}
div.wi-popup {
	border: 1px solid #1854c2;
}

td.lwt-embedded, td.mwt-embedded, td.rwt-embedded,
td.lwt-popup, td.rwt-popup, td.mwt-popup,
td.lwt-modal, td.mwt-modal, td.rwt-modal,
td.lwt-overlapped, td.mwt-overlapped, td.rwt-overlapped,
td.lwt-wndcyan, td.mwt-wndcyan, td.rwt-wndcyan {
	font-size: small;
	padding-top: 4px; padding-bottom: 3px; margin-bottom: 2px;
	color: white;
}
td.lwt-embedded {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wte-l.png')}); background-repeat: no-repeat;
	width: 7px;
}
td.mwt-embedded {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wte-m.png')}); background-repeat: repeat-x;
}
td.rwt-embedded {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wte-r.png')}); background-repeat: no-repeat;
	width: 7px;
}
td.lwt-popup {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtp-l.png')}); background-repeat: no-repeat;
	width: 5px;
}
td.mwt-popup {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtp-m.png')}); background-repeat: repeat-x;
}
td.rwt-popup {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtp-r.png')}); background-repeat: no-repeat;
	width: 5px;
}

td.lwt-modal, td.lwt-overlapped {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wto-l.png')}); background-repeat: no-repeat;
	width: 7px;
}
td.mwt-modal, td.mwt-overlapped {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wto-m.png')}); background-repeat: repeat-x;
}
td.rwt-modal, td.rwt-overlapped {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wto-r.png')}); background-repeat: no-repeat;
	width: 7px;
}

td.lwt-wndcyan {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtcyan-l.png')}); background-repeat: no-repeat;
	width: 5px;
}
td.mwt-wndcyan {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtcyan-m.png')}); background-repeat: repeat-x;
}
td.rwt-wndcyan {
	background-image: url(${c:encodeURL('~./zul/img/wnd/wtcyan-r.png')}); background-repeat: no-repeat;
	width: 5px;
}

.title a, .title a:visited {
	color: white;
}
.caption a:hover, .title a:hover {
	text-decoration: underline;
}

div.modal_mask { <%-- don't change --%>
	position: absolute; z-index: 20000;
	top: 0; left: 0; width: 100%; height: 100%;
	opacity: .4; filter: alpha(opacity=40);
	background:transparent !important;
	background: #181818;
	background-image: url(${c:encodeURL('~./zul/img/modal-mask.png')}) !important; <%-- Moz... --%>
	background-image: none; background-repeat: repeat;
	display: none;
}

<%-- ZK separator --%>
div.hsep, div.hsep-bar {
	display: block; width: 100%; padding: 0; margin: 2pt 0; font-size: 0;
}
div.vsep, div.vsep-bar {
	display: inline; margin: 0 1pt; padding: 0;
}
div.hsep-bar {
	border-top: 1px solid #888;
}
div.vsep-bar {
	border-left: 1px solid #666; margin-left: 2pt;
}

td.vbox {
	margin: 0; padding-bottom: 0.4em;
}
td.hbox {
	margin: 0; padding-right: 0.6em;
}

<%-- ZK toolbar and toolbarbutton --%>
.toolbar {
	padding: 1px; background: threedface; border: 1px solid;
	border-color: threedhighlight threedshadow threedshadow threedhighlight;
}
.caption .toolbar, .caption .toolbarbutton {
	background: none; border: 0;
}

.toolbar a, .toolbar a:visited, .toolbar a:hover {
	font-family: Tahoma, Arial, Helvetica, sans-serif;
	font-size: x-small; font-weight: normal; color: black;
	background: threedface; border: 1px solid threedface;
	text-decoration: none;
}
.toolbar a:hover {
	border-color: threedhighlight threedshadow threedshadow threedhighlight;
}

.caption .toolbar a, .caption .toolbar a:visited, .caption .toolbar a:hover {
	background: none; border: 0; color: black;
}
.caption .toolbar a:hover {
	text-decoration: underline;
}
.title .toolbar a, .title .toolbar a:visited, .title .toolbar a:hover {
	background: none; border: 0; color: white;
}
.title a:hover {
	text-decoration: underline;
}

<%-- ZK tree, listbox, grid --%>
div.listbox, div.tree, div.grid, div.grid-no-striped { <%-- depends sclass. --%>
	background: threedface; border: 1px solid #7F9DB9;
}
div.tree-head, div.listbox-head, div.grid-head { <%-- always used. --%>
	background: threedface; border: 0; overflow: hidden; width: 100%;
}
div.listbox-paging th, div.grid-paging th {
	background: threedface;
}
div.tree-head th, div.listbox-head th, div.grid-head th, div.listbox-paging th, div.grid-paging th {
	overflow: hidden; border: 1px solid;
	border-color: threedhighlight threedshadow threedshadow threedhighlight;
	text-overflow: ellipsis; white-space: nowrap; padding: 2px;
	font-size: small; font-weight: normal;
}
div.listbox-head th.sort, div.grid-head th.sort, div.listbox-paging th.sort, div.grid-paging th.sort {
	cursor: hand; cursor: pointer; padding-right: 9px;
	background-image: url(${c:encodeURL('~./zul/img/sort/hint.png')});
	background-position: right;
	background-repeat: no-repeat;
}
div.listbox-head th.sort-asc, div.grid-head th.sort-asc, div.listbox-paging th.sort-asc, div.grid-paging th.sort-asc {
	cursor: hand; cursor: pointer; padding-right: 9px;
	background-image: url(${c:encodeURL('~./zul/img/sort/asc.png')});
	background-position: right;
	background-repeat: no-repeat;
}
div.listbox-head th.sort-dsc, div.grid-head th.sort-dsc, div.listbox-paging th.sort-dsc, div.grid-paging th.sort-dsc {
	cursor: hand; cursor: pointer; padding-right: 9px;
	background-image: url(${c:encodeURL('~./zul/img/sort/dsc.png')});
	background-position: right;
	background-repeat: no-repeat;
}

div.tree-body, div.listbox-body, div.grid-body, div.listbox-paging, div.grid-paging { <%-- always used. --%>
	background: window; border: 0; overflow: auto; width: 100%;
}
div.listbox-paging, div.grid-paging {
	height: 100%;
}
div.listbox-pgi, div.grid-pgi {
	border-top: 1px solid #AAB;
}
div.tree-body td, div.listbox-body td, div.listbox-paging td {
	cursor: hand; cursor: pointer; padding: 0 2px;
	font-size: small; font-weight: normal;
}
div.tree-body td, div.tree-head th {
	font-size: 12px; <%-- Too small if the spacing with 18px --%>
}

div.listbox-foot, tbody.listbox-foot, div.grid-foot, tbody.grid-foot, div.tree-foot, tbody.tree-foot { <%-- always used --%>
	background: threedface; border-top: 1px solid threedshadow;
}

tr.item, tr.item a, tr.item a:visited {
	font-size: small; font-weight: normal; color: black;
	text-decoration: none;
}
tr.item a:hover {
	text-decoration: underline;
}
tr.itemsel, tr.itemsel a, tr.itemsel a:visited {
	font-size: small; font-weight: normal;
	background: highlight; color: highlighttext;
	text-decoration: none;
}
tr.itemsel a:hover {
	text-decoration: underline;
}

tr.grid td.gc, tr.grid-od td.gc, tr.grid-no-striped td.gc, tr.grid-no-striped-od td.gc {
	background: #FFF; border-bottom: none; border-left: 1px solid #FFF;
	border-right: 1px solid #CCC; border-top: 1px solid #DDD; padding: 2px;
	font-size: small; font-weight: normal;
}
tr.grid-od td.gc {
	background: #E8EFEA;
}

<%-- ZK tab. --%>
.tab, .tab a, a.tab {
	font-family: Tahoma, Arial, Helvetica, sans-serif;
	font-size: x-small; font-weight: normal; color: #300030;
}
.tab a, .tab a:visited, a.tab, a.tab:visited {
	text-decoration: none;
}
.tab a:hover, a.tab:hover {
	text-decoration: underline;
}
.tabsel, .tabsel a, a.tabsel {
	font-family: Tahoma, Arial, Helvetica, sans-serif;
	font-size: x-small; font-weight: bold; color: #500060;
}
.tabsel a, .tabsel a:visited, a.tabsel, a.tabsel:visited {
	text-decoration: none;
}
.tabsel a:hover, a.tabsel:hover {
	text-decoration: underline;
}

tr.tabpanel td.tabpanel-hr, div.tabpanel-accordion, div.groupbox-3d { <%-- horz, accd, gb-3d --%>
	border-left: 1px solid #5C6C7C; border-right: 1px solid #5C6C7C; 
	border-bottom: 1px solid #5C6C7C; padding: 5px;
}
td.tabpanels { <%-- vert --%>
	border-top: 1px solid #5C6C7C; border-right: 1px solid #5C6C7C; 
	border-bottom: 1px solid #5C6C7C; padding: 5px;
}

<%-- ZK menu. --%>
div.menubar, div.menupopup, div.ctxpopup {
	cursor: hand; cursor: pointer; background: menu; padding: 1px;
}
div.menubar {
	border: 1px solid black;
}
div.menupopup, div.ctxpopup {
	display: block; position: absolute; z-index: 88000;
	border: 1px outset;
}
div.menubar td, div.menupopup td {
	white-space: nowrap;
}
div.menubar a, div.menubar a:visited, div.menubar a:hover, div.menupopup a, div.menupopup a:visited, div.menupopup a:hover {
	font-size: x-small; font-weight: normal; text-overflow: ellipsis;
	border: 1px solid menu; background: menu; color: menutext;
	text-decoration: none;
}
div.menubar a:hover {
	background: threedface;
	border-color: threedhighlight threedshadow threedshadow threedhighlight;
}
div.menupopup a:hover {
	background: highlight; color: highlighttext;
}
div.menupopup hr {
	border: 0; color: darkgray; background: darkgray;
}

<%-- Combobox and Datebox --%>
span.combobox, span.datebox, span.bandbox {
	border: 0; padding: 0; margin: 0; white-space: nowrap;
}
div.comboboxpp, div.bandboxpp { <%--hardcoded in DSP--%>
	display: block; position: absolute; z-index: 80000; overflow: auto;
	background: white; border: 1px solid black; padding: 2px;
	font-size: x-small;
}
.comboboxpp td { <%--label--%>
	white-space: nowrap; font-size: x-small; cursor: hand; cursor: pointer; 
}
.comboboxpp td span { <%--description--%>
	color: #888; font-size: xx-small; padding-left: 6px;
}

<%-- ZK error message box --%>
div.errbox {
	margin: 0; padding: 1px; border: 1px outset; cursor: hand; cursor: pointer;
	background: #E8E0D8; position: absolute; z-index: 70000;
}

div.progressmeter {
	border: 1px inset;
}

div.paging, div.paging a {
	font-size: x-small; color: #a30; font-weight: bold; background: window;
}
div.paging span {
	font-size: x-small; color: #555; font-weight: normal;
}
div.paging a, div.paging a:visited {
	color: #00a; font-weight: normal; text-decoration: underline;
}
div.paging a:hover {
	background: #DAE8FF;
}

<%-- ZK datebox and calendar--%>
div.dateboxpp { <%--hardcoded in DSP--%>
	display: block; position: absolute; z-index: 80000;
	background: white; border: 1px solid black; padding: 2px;
}

table.calendar {
	background: window; border: 1px solid #7F9DB9;
}
table.calyear {
	background: #eaf0f4; border: 1px solid;
	border-color: threedhighlight threedshadow threedshadow threedhighlight;
}
table.calday {
	border: 1px solid #ddd;
}
.calyear td {
	font-size: x-small; font-weight: bold; text-align: center;
	white-space: nowrap;
}
.calmon td, tr.calday td, tr.calday td a, tr.calday td a:visited {
	font-size: x-small; color: #35254F; text-align: center;
	cursor: hand; cursor: pointer; text-decoration: none;
}
.calday td {
	padding: 1px 3px;
}
.calday td a:hover {
	text-decoration: underline;
}
.calmon td.sel, tr.calday td.sel {
	background: #cddeee;
}
.caldmon td.dis, tr.calday td.dis {
	color: #888;
}
.caldow td {
	font-size: x-small; color: #333; font-weight: bold;
	padding: 1px 2px; background: #e8e8f0; text-align: center;
}

div.dateboxpp table.calyear {
	background: #d8e8f0;
}
