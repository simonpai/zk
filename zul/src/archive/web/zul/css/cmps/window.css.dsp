<%@ page contentType="text/css;charset=UTF-8" %>
<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>

.z-window-resize-proxy {
	position: absolute; 
	border: 1px dashed #1854C2;
	overflow: hidden;
	z-index: 50000;
	left: 0;
	top: 0;
	background-color: #D7E6F7;
	filter: alpha(opacity=50); <%-- IE --%>
	opacity: .5;
}
.z-window-move-ghost {
	position: absolute;
	background: #D7E6F7;
	overflow: hidden;
	filter: alpha(opacity=65) !important; <%-- IE --%>
	opacity: .65 !important;
	cursor: move !important;
}
.z-window-move-ghost dl {
	border: 1px solid #538BA2;
	margin: 0; padding: 0;
	overflow: hidden;  
	display: block;
	background: #D7E6F7;
	line-height: 0;
	font-size: 0;
}
.z-window-embedded, .z-window-modal, .z-window-overlapped, .z-window-popup, .z-window-highlighted {
	margin: 0; padding: 0; overflow: hidden; zoom: 1;
}
<%-- Top Left Corner --%>
.z-window-embedded-tl,
.z-window-modal-tl,
.z-window-highlighted-tl,
.z-window-overlapped-tl,
.z-window-popup-tl {
	background: transparent no-repeat 0 top;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-corner.png')});
	margin-right: 5px;
	height: 5px;
	font-size: 0;
	line-height: 0;
	zoom: 1;
}
.z-window-embedded-tl {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-corner.png')});
}
.z-window-popup-tl {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-pop-corner.png')});
}
<%-- Top Right Corner --%>
.z-window-embedded-tr,
.z-window-modal-tr,
.z-window-highlighted-tr,
.z-window-overlapped-tr,
.z-window-popup-tr {
	background: transparent no-repeat right -10px;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-corner.png')});
	position: relative;
	height: 5px;
	margin-right: -5px;
	font-size: 0;
	line-height:0;
	zoom: 1;
}
.z-window-embedded-tr {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-corner.png')});
}
.z-window-popup-tr {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-pop-corner.png')});
}
<%-- Header Left --%>
.z-window-embedded-hl,
.z-window-modal-hl,
.z-window-highlighted-hl,
.z-window-overlapped-hl,
.z-window-popup-hl {
	background: transparent no-repeat 0 0;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-hl.png')});
	padding-left: 6px;
	zoom: 1;
}
.z-window-embedded-hl{
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-hl.png')});
}
.z-window-popup-hl {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-pop-hl.png')});
}
<%-- Header Right --%>
.z-window-embedded-hr,
.z-window-modal-hr,
.z-window-highlighted-hr,
.z-window-overlapped-hr,
 .z-window-popup-hr {
	background: transparent no-repeat right 0;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-hr.png')});
	padding-right: 6px;
	zoom: 1;
}
.z-window-embedded-hr, .z-window-embedded-hr-noborder {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-hr.png')});
}
.z-window-popup-hr {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-pop-hr.png')});
}
<%-- Header Middle --%>
.z-window-embedded-hm,
.z-window-modal-hm,
.z-window-highlighted-hm,
.z-window-overlapped-hm,
.z-window-popup-hm {
	background: transparent repeat-x 0 0;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-hm.png')});
	overflow: hidden;
	zoom: 1;
}
.z-window-embedded-hm {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-hm.png')});
}
.z-window-popup-hm {
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-pop-hm.png')});
}
<%-- Header --%>
.z-window-modal-header, .z-window-popup-header, .z-window-highlighted-header,
	.z-window-overlapped-header, .z-window-embedded-header {
	overflow: hidden; zoom: 1; color: #222222; padding-bottom: 4px;
	font-family: ${fontFamilyC};
	font-size: ${fontSizeM}; font-weight: normal;
}
.z-window-modal-header, .z-window-popup-header, .z-window-highlighted-header,
	.z-window-overlapped-header {
	color: #FFFFFF;
}
.z-window-embedded-header a, .z-window-embedded-header a:visited, .z-window-embedded-header a:hover {
	color: #222222;
}
<%-- Caption and Toolbarbutton --%>
.z-window-modal-header a,
.z-window-modal-header a:visited,
.z-window-modal-header a:hover,
.z-window-modal-header .z-caption a,
.z-window-modal-header .z-caption a:visited,
.z-window-modal-header .z-caption a:hover,
.z-window-popup-header a,
.z-window-popup-header a:visited,
.z-window-popup-header a:hover,
.z-window-popup-header .z-caption a,
.z-window-popup-header .z-caption a:visited,
.z-window-popup-header .z-caption a:hover,
.z-window-highlighted-header a,
.z-window-highlighted-header a:visited,
.z-window-highlighted-header a:hover,
.z-window-highlighted-header .z-caption a,
.z-window-highlighted-header .z-caption a:visited,
.z-window-highlighted-header .z-caption a:hover,
.z-window-overlapped-header a,
.z-window-overlapped-header a:visited,
.z-window-overlapped-header a:hover,
.z-window-overlapped-header .z-caption a,
.z-window-overlapped-header .z-caption a:visited,
.z-window-overlapped-header .z-caption a:hover {
	color: #FFFFFF;
}
<%-- Body Content--%>
.z-window-embedded-cnt {
	margin: 0;
	padding: 3px;
	border: 1px solid #538BA2;
}
.z-window-embedded-cnt,
.z-window-embedded-body,
.z-window-overlapped-body,
.z-window-popup-body,
.z-window-highlighted-body,
.z-window-modal-body {
	overflow: hidden;
	zoom: 1;
}
.z-window-overlapped-cnt, .z-window-popup-cnt {
	margin: 0;
	padding: 4px;
	background: white;
	overflow: hidden;
	zoom: 1;
}
.z-window-popup-cnt {
	margin:0;
	padding: 2px;
	border: 1px solid #2c70a9;
}
.z-window-modal-cnt,
.z-window-highlighted-cnt,
.z-window-modal-cnt-noborder,
.z-window-highlighted-cnt-noborder,
.z-window-overlapped-cnt-noborder {
	margin: 0;
	padding: 2px;
	background: white;
	overflow: hidden;
	zoom: 1;
}
.z-window-modal-cnt-noborder,
.z-window-highlighted-cnt-noborder,
.z-window-embedded-cnt-noborder,
.z-window-overlapped-cnt-noborder,
.z-window-popup-cnt-noborder {
	border: 0;
	overflow: hidden;
	zoom: 1;
}
.z-window-popup-cnt-noborder {
	margin: 0;
	padding: 1px;
	background: white;
}
<%-- Center Left --%>
.z-window-modal-cl,
.z-window-highlighted-cl,
.z-window-overlapped-cl {
	background: transparent repeat-y 0 0;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-clr.png')});
	padding-left: 6px;
	zoom: 1;
}
<%-- Center Right --%>
.z-window-modal-cr,
.z-window-highlighted-cr,
.z-window-overlapped-cr {
	background: transparent repeat-y right 0;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-clr.png')});
	padding-right: 6px;
	zoom: 1;
}
<%-- Center Middle --%>
.z-window-modal-cm,
.z-window-highlighted-cm,
.z-window-overlapped-cm {
	padding: 0;
	margin: 0;
	border: 1px solid #0B5CA0;
	background: #5EABDB;
}
<%-- Bottom Left --%>
.z-window-modal-bl,
.z-window-highlighted-bl,
.z-window-overlapped-bl {
	background: transparent no-repeat 0 -5px;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-corner.png')});
	height: 5px;
	margin-right: 5px;
	zoom: 1;
}
<%-- Bottom Right --%>
.z-window-modal-br,
.z-window-highlighted-br,
.z-window-overlapped-br {
	background: transparent no-repeat right bottom;
	background-image: url(${c:encodeURL('~./zul/img/wnd2/wnd-ol-corner.png')});
	position: relative;
	height: 5px;
	margin-right: -5px;
	font-size: 0;
	line-height:0;
	zoom: 1;
}
<%-- Tools --%>
.z-window-embedded-tool,
.z-window-popup-tool,
.z-window-modal-tool,
.z-window-overlapped-tool,
.z-window-highlighted-tool {
	background: transparent no-repeat 0 0;
	background-image : url(${c:encodeURL('~./zul/img/panel/tool-btn-ol.gif')});
	height: 15px;
	width: 15px;
	overflow: hidden;
	float: right;
	cursor: pointer;
	margin-left: 2px;
}
.z-window-popup-tool {
	background-image : url(${c:encodeURL('~./zul/img/panel/tool-btn-pp.gif')});
}
.z-window-embedded-tool {
	background-image : url(${c:encodeURL('~./zul/img/panel/tool-btn.gif')});
}
.z-window-embedded-close, .z-window-modal-close, .z-window-overlapped-close,
	.z-window-popup-close, .z-window-highlighted-close {
	background-position: 0 0;
}
.z-window-embedded-close-over, .z-window-modal-close-over, .z-window-overlapped-close-over,
	.z-window-popup-close-over, .z-window-highlighted-close-over {
	background-position: -15px 0;
}
.z-window-embedded-minimize, .z-window-modal-minimize, .z-window-overlapped-minimize,
	.z-window-popup-minimize, .z-window-highlighted-minimize {
	background-position: 0 -15px;
}
.z-window-embedded-minimize-over, .z-window-modal-minimize-over, .z-window-overlapped-minimize-over,
	.z-window-popup-minimize-over, .z-window-highlighted-minimize-over {
	background-position: -15px -15px;
}
.z-window-embedded-maximize, .z-window-modal-maximize, .z-window-overlapped-maximize,
	.z-window-popup-maximize, .z-window-highlighted-maximize {
	background-position: 0 -30px;
}
.z-window-embedded-maximize-over, .z-window-modal-maximize-over, .z-window-overlapped-maximize-over,
	.z-window-popup-maximize-over, .z-window-highlighted-maximize-over {
	background-position: -15px -30px;
}
.z-window-embedded-maximized, .z-window-modal-maximized, .z-window-overlapped-maximized,
	.z-window-popup-maximized, .z-window-highlighted-maximized {
	background-position: 0 -45px;
}
.z-window-embedded-maximized-over, .z-window-modal-maximized-over, .z-window-overlapped-maximized-over,
	.z-window-popup-maximized-over, .z-window-highlighted-maximized-over {
	background-position: -15px -45px;
}
