/* mount.js

	Purpose:
		
	Description:
		
	History:
		Sat Oct 18 19:24:38     2008, Created by tomyeh

Copyright (C) 2008 Potix Corporation. All Rights Reserved.

	This program is distributed under LGPL Version 2.1 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
*/

//define a package and returns the package info (used in WpdExtendlet)
function zkpi(nm, wv) {
	return zk.isLoaded(nm) ? null: {n: nm, p: zk.$package(nm, false, wv)};
}

//ZK JSP: page creation (backward compatible)
function zkpb(pguid, dtid, contextURI, updateURI, reqURI, props) {
	zkx([0, pguid,
		zk.copy(props, {dt: dtid, cu: contextURI, uu: updateURI, ru: reqURI}),[]]);
}
//ZK JSP (useless; backward compatible)
zkpe = zk.$void;

//Initializes with version and options
function zkver(ver, build, ctxURI, updURI, modVers, opts) {
	zk.version = ver;
	zk.build = build;
	zk.contextURI = ctxURI;
	zk.updateURI = updURI;

	for (var nm in modVers)
		zk.setVersion(nm, modVers[nm]);

	zk.feature = {standard: true};
	zkopt(opts);
}

//Define a mold
function zkmld(wgtcls, molds) {
	if (!wgtcls.superclass) {
		zk.afterLoad(function () {zkmld(wgtcls, molds);});
		return;
	}

	var ms = wgtcls.molds = {};
	for (var nm in molds) {
		var fn = molds[nm];
		ms[nm] = typeof fn == 'function' ? fn: fn[0].molds[fn[1]];
	}		
}

//Run Ajax-as-a-service's main
function zkamn(pkg, fn) {
	zk.load(pkg, function () {
		setTimeout(function(){
			zk.afterMount(fn);
		}, 20);
	});
}

(function () {
	var Widget = zk.Widget,
		_wgt_$ = Widget.$, //the original zk.Widget.$
		_crInfBL0 = [], _crInfBL1 = [], //create info for BL
		_crInfAU0 = [], //create info for AU
		_aftMounts = [], //afterMount
		_mntctx = {}, //the context
		_paci = {s: 0, e: -1, f0: [], f1: []}, //for handling page's AU responses
		_t0 = jq.now();

	//Issue of handling page's AU responses
	//1. page's AU must be processed after all zkx(), while they might be added
	//  before zkx (such as test/test.zhtml), or multiple zkx (such jspTags.jsp)
	//2. mount.js:_startCheck must be called after processing page's AU
	//  (otherwise, zksandbox will jump to #f1 causing additional step)
	//Note: it is better to block zAu but the chance to be wrong is low --
	//a timer must be started early and its response depends page's AU
	jq(function () {
		function _stateless() {
			var dts = zk.Desktop.all;
			for (var dtid in dts)
				if (dts[dtid].stateless) return true;
		}
		_paci.i = setInterval(function () {
			var stateless;
			if ((zk.booted && !zk.mounting) || (stateless = _stateless()))
				if (stateless || _paci.s == _paci.e) { //done
					clearInterval(_paci.i);
					var fs = _paci.f0.concat(_paci.f1);
					_paci = null;
					for (var f; f = fs.shift();)
						f();
				} else
					_paci.e = _paci.s;
		}, 25);
	});
	//run after page AU cmds
	zk._apac = function (fn, _which_) {
		if (_paci)
			return _paci[_which_ || "f1"].push(fn);
		zk.afterMount(fn); //it might happen if ZUML loaded later (with custom JS code)
	};

/** @partial zk
 */
//@{
	/** Adds a function that will be executed after the mounting is done. By mounting we mean the creation of peer widgets.
	 * <p>By mounting we mean the creation of the peer widgets under the
	 * control of the server. To run after the mounting of the peer widgets,
	 * <p>If the delay argument is not specified and no mounting is taking place,
	 * the function is executed with <code>setTimeout(fn, 0)</code>.
	 * @param Function fn the function to execute after mounted
	 * @param int delay (since 5.0.6) how many milliseconds to wait before execute if
	 * there is no mounting taking place. If omitted, 0 is assumed.
	 * If negative, the function is executed immediately (if no mounting is taking place).
	 * @return boolean true if this method has been called before return (delay must
	 * be negative, and no mounting); otherwise, undefined is returned.
	 * @see #mounting
	 * @see #afterLoad
	 * @see #afterAnimate
	 */
	//afterMount: function () {}
//@};
	zk.afterMount = function (fn, delay) { //part of zk
		if (fn)
			if (!jq.isReady)
				jq(function () {zk.afterMount(fn);}); //B3278524
			else if (zk.mounting)
				_aftMounts.push(fn); //normal
			else if (zk.loading)
				zk.afterLoad(fn);
			else if (delay < 0) {
				fn();
				return true; //called
			} else
				setTimeout(fn, delay);
	};

	function _curdt() {
		return _mntctx.curdt || (_mntctx.curdt = zk.Desktop.$());
	}
	//Load all required packages
	function mountpkg(infs) {
		var types = {};
		for (var j = infs.length; j--;) {
			var inf = infs[j];
			if (!inf.pked) { //mountpkg might be called multiple times before mount()
				inf.pked = true;
				getTypes(types, inf[0], inf[1]);
			}
		}

		for (var type in types) {
			var j = type.lastIndexOf('.');
			if (j >= 0)
				zk._load(type.substring(0, j), types[type]); //use _load for better performance
		}
	}
	//Loads package of a widget tree
	function getTypes(types, dt, wi) {
		var type = wi[0];
		if (type === 0) //page
			type = wi[2].wc;
		else if (type === 1) //1: zhtml.Widget
			wi[0] = type = "zhtml.Widget";
		if (type)
			types[type] = dt;

		for (var children = wi[3], j = children.length; j--;)
			getTypes(types, dt, children[j]);
	}
	//mount for browser loading
	function mtBL() {
		if (zk.loading)
			return zk.afterLoad(mtBL);

		var inf = _crInfBL0.shift();
		if (inf) {
			_crInfBL1.push([inf[0], create(inf[3]||inf[0], inf[1], true), inf[2], inf[4]]);
				//inf[0]: desktop used as default parent if no owner
				//inf[3]: owner passed from zkx
				//inf[2]: bindOnly
				//inf[4]: aucmds (if BL)
				//true: don't update DOM

			if (_crInfBL0.length)
				return run(mtBL);
		}

		mtBL0();
	}
	function mtBL0() {
		for (;;) {
			if (_crInfBL0.length)
				return; //another page started

			if (zk.loading)
				return zk.afterLoad(mtBL0);

			if (zk.ie && !jq.isReady) //3055849: ie6/ie7 has to wait until isReady (tonyq reported ie8 has similar issue)
				return jq(mtBL0);

			var inf = _crInfBL1.shift();
			if (!inf) break;

			var wgt = inf[1];
			if (inf[2])
				wgt.bind(inf[0]); //bindOnly
			else
				wgt.replaceHTML('#' + wgt.uuid, inf[0]);

			doAuCmds(inf[3]); //aucmds
		}

		mtBL1();
	}
	function mtBL1() {
		if (_crInfBL0.length || _crInfBL1.length)
			return; //another page started

		zk.booted = true;
		zk.mounting = false;
		doAfterMount(mtBL1);
		_paci && ++_paci.s;
		zk.endProcessing();

		zk.bmk.onURLChange();
		if (zk.pfmeter) {
			var dts = zk.Desktop.all;
			for (var dtid in dts)
				zAu._pfdone(dts[dtid], dtid);
		}
	}

	/* mount for AU */
	function mtAU() {
		if (zk.loading) {
			zk.afterLoad(mtAU);
			return;
		}

		try {
			var inf = _crInfAU0.shift(),
				filter, wgt;
			if (inf) {
				if (filter = inf[4][1]) //inf[4] is extra if AU
					Widget.$ = function (n, opts) {return filter(_wgt_$(n, opts));}
				try {
					wgt = create(null, inf[1]);
				} finally {
					if (filter) Widget.$ = _wgt_$;
				}
				inf[4][0](wgt); //invoke stub
			}
		} finally {
			if (_crInfAU0.length)
				run(mtAU); //loop back to check if loading
			else
				mtAU0();
		}
	}
	function mtAU0() {
		zk.mounting = false;
		doAfterMount(mtAU0);

		zAu._doCmds(); //server-push (w/ afterLoad) and _pfdone
		doAfterMount(mtAU0);
	}
	function doAfterMount(fnext) {
		for (var fn; fn = _aftMounts.shift();) {
			fn();
			if (zk.loading) {
				zk.afterLoad(fnext); //fn might load packages
				return true; //wait
			}
		}
	}

	function doAuCmds(cmds) {
		if (cmds && cmds.length)
			zk._apac(function () {
				for (var j = 0; j < cmds.length; j += 2)
					zAu.process(cmds[j], cmds[j + 1]);
			}, "f0");
	}

	/* create the widget tree. */
	function create(parent, wi, ignoreDom) {
		var wgt, stub, v,
			type = wi[0],
			uuid = wi[1],
			props = wi[2]||{};
		if (type === 0) { //page
			type = zk.cut(props, "wc")
			var cls = type ? zk.$import(type): zk.Page;
			(wgt = new cls({uuid: uuid}, zk.cut(props, "ct"))).inServer = true;
			if (parent) parent.appendChild(wgt, ignoreDom);
		} else {
			if ((stub = type == "#stub") || type == "#stubs") {
				if (!(wgt = _wgt_$(uuid) //use the original one since filter() might applied
				|| zAu._wgt$(uuid))) //search detached (in prev cmd of same AU)
					throw "Unknown stub "+uuid;
				var w = new Widget();
				zk._wgtutl.replace(wgt, w, stub);
					//to reuse wgt, we replace it with a dummy widget, w
					//if #stubs, we have to reuse the whole subtree (not just wgt), so don't move children
				wgt.unbind(); //reuse it as new widget
			} else {
				var cls = zk.$import(type);
				if (!cls)
					throw 'Unknown widget: ' + type;
				(wgt = new cls(zkac)).inServer = true;
					//zkac used as token to optimize the performance of zk.Widget.$init
				wgt.uuid = uuid;
				if (v = wi[4])
					wgt._mold = v;
			}
			if (parent) parent.appendChild(wgt, ignoreDom);

			//z$al: afterLoad
			if (v = zk.cut(props, "z$al"))
				zk.afterLoad(function () {
					for (var p in v)
						wgt.set(p, v[p](), true); //value must be func; fromServer
				});
		}

		for (var nm in props)
			wgt.set(nm, props[nm], true); //fromServer

		for (var j = 0, childs = wi[3], len = childs.length;
		j < len; ++j)
			create(wgt, childs[j]);
		return wgt;
	}

	/* run and delay if too busy, so progressbox has a chance to show. */
	function run(fn) {
		var t = jq.now(), dt = t - _t0;
		if (dt > 2500) { //huge page (the shorter the longer to load; but no loading icon)
			_t0 = t;
			dt >>= 6;
			setTimeout(fn, dt < 10 ? dt: 10); //breathe
				//IE optimize the display if delay is too short
		} else
			fn();
	}

  zk.copy(window, {
	//define a desktop
	zkdt: function (dtid, contextURI, updateURI, reqURI) {
		var dt = zk.Desktop.$(dtid);
		if (dt == null) {
			dt = new zk.Desktop(dtid, contextURI, updateURI, reqURI);
			if (zk.pfmeter) zAu._pfrecv(dt, dtid);
		} else {
			if (updateURI != null) dt.updateURI = updateURI;
			if (contextURI != null) dt.contextURI = contextURI;
			if (reqURI != null) dt.requestPath = reqURI;
		}
		_mntctx.curdt = dt;
		return dt;
	},

	//widget creations
	zkx: function (wi, extra, aucmds, js) { //extra is either delay (BL) or [stub, filter] (AU)
		zk.mounting = true;

		try {
			if (js) jq.globalEval(js);

			var mount = mtAU, infs = _crInfAU0, delay, owner;
			if (!extra || !extra.length) { //if 2nd argument not stub, it must be BL (see zkx_)
				delay = extra;
				if (wi) {
					extra = aucmds;
					aucmds = null;
				}
				mount = mtBL;
				infs = _crInfBL0;
			} //else assert(!aucmds); //no aucmds if AU

			if (wi) {
				if (wi[0] === 0) { //page
					var props = wi[2];
					zkdt(zk.cut(props, "dt"), zk.cut(props, "cu"), zk.cut(props, "uu"), zk.cut(props, "ru"));
					if (owner = zk.cut(props, "ow"))
						owner = Widget.$(owner);
				}

				infs.push([_curdt(), wi, _mntctx.bindOnly, owner, extra]);
					//extra is [stub-fn, filter] if AU,  aucmds if BL
				mountpkg(infs);
			}

			if (delay) setTimeout(mount, 0); //Bug 2983792 (delay until non-defer script evaluated)
			else run(mount);

			doAuCmds(aucmds);
		} catch (e) {
			zk.mounting = false;
			zk.error("Failed to mount: "+(e.message||e));
			setTimeout(function(){
				throw e;
			},0);				
		}
	},
	//widget creation called by au.js
	//args: [wi] (a single element array containing wi)
	zkx_: function (args, stub, filter) {
		_t0 = jq.now(); //so run() won't do unncessary delay
		args[1] = [stub, filter]; //assign stub as 2nd argument (see zkx)
		zkx.apply(this, args); //args[2] (aucmds) must be null
	},

	//Run AU commands (used only with ZHTML)
	zkac: function () {
		doAuCmds(arguments);
	},

	//mount and zkx (BL)
	zkmx: function () {
		zkmb();
		try {
			zkx.apply(window, arguments);
		} finally {
			zkme();
		}
	},

	//begin of mounting
	zkmb: function (bindOnly) {
		_mntctx.bindOnly = bindOnly;
		var t = 390 - (jq.now() - _t0);
		zk.startProcessing(t > 0 ? t: 0);
	},
	//end of mounting
	zkme: function () {
		_mntctx.curdt = null;
		_mntctx.bindOnly = false;
	}
  });

})(window);

//Event Handler//
jq(function() {
	var Widget = zk.Widget,
		_bfUploads = [],
		_reszInf = {},
		_subevts = { //additonal invocation
			onClick: 'doSelect_',
			onRightClick: 'doSelect_',
			onMouseOver: 'doTooltipOver_',
			onMouseOut: 'doTooltipOut_'
		};

	/** @partial zk
	 */
	zk.copy(zk, {
		/** Adds a function that will be executed when the browser is about to unload the document. In other words, it is called when window.onbeforeunload is called.
		 *
		 * <p>To remove the function, invoke this method by specifying remove to the opts argument.
<pre><code>zk.beforeUnload(fn, {remove: true});</code></pre>
		 *
		 * @param Function fn the function to execute.
		 * The function shall return null if it is OK to close, or a message (String) if it wants to show it to the end user for confirmation. 
		 * @param Map opts [optional] a map of options. Allowed vlaues:<br/>
		 * <ul>
		 * <li>remove: whether to remove instead of add.</li>
		 * </ul>
		 */
		beforeUnload: function (fn, opts) { //part of zk
			if (opts && opts.remove) _bfUploads.$remove(fn);
			else _bfUploads.push(fn);
		}
	});

	function _doEvt(wevt) {
		var wgt = wevt.target;
		if (wgt && !wgt.$weave) {
			var en = wevt.name,
				fn = _subevts[en];
			if (fn) {
				// Bug 3300935, disable tooltip for IOS
				if (!zk.ios || (fn != 'doTooltipOver_' && fn != 'doTooltipOut_')) {
					wgt[fn].call(wgt, wevt);
				}
			}
			if (!wevt.stopped)
				wgt['do' + en.substring(2) + '_'].call(wgt, wevt);
			if (wevt.domStopped)
				wevt.domEvent.stop();
		}
	}
	
	function _docMouseDown(evt, wgt, noFocusChange) {
		zk.clickPointer[0] = evt.pageX;
		zk.clickPointer[1] = evt.pageY;

		if (!wgt) wgt = evt.target;

		var target = evt.domTarget,
			body = document.body,
			old = zk.currentFocus;
		if ((target != body && target != body.parentNode) ||
				(evt.pageX < body.clientWidth && evt.pageY < body.clientHeight)) //not click on scrollbar
			Widget.mimicMouseDown_(wgt, noFocusChange); //wgt is null if mask
			
		_doEvt(evt);
		
		//Bug 2799334, 2635555 and 2807475: need to enforce a focus event (IE only)
		//However, ZK-354: if target is upload, we can NOT focus to it. Thus, focusBackFix was introduced
		if (old && zk.ie) {
			var n = jq(old)[0];
			if (n)
				setTimeout(function () {
					try {
						var cf = zk.currentFocus;
						if (cf != old && !n.offsetWidth && !n.offsetHeight) {
							zk.focusBackFix = true;
							cf.focus();
						}
					} catch (e) { //ignore
					} finally {
						delete zk.focusBackFix;
					}
				});
		}
	}

	function _docResize() {
		if (!_reszInf.time) return; //already handled

		var now = jq.now();
		if (zk.mounting || zk.loading || now < _reszInf.time || zk.animating()) {
			setTimeout(_docResize, 10);
			return;
		}

		_reszInf.time = null; //handled
		_reszInf.lastTime = now + 1000;
			//ignore following for a while if processing (in slow machine)

		zAu._onClientInfo();

		_reszInf.inResize = true;
		try {
			zWatch.fire('beforeSize'); //notify all
			zWatch.fire('onFitSize', null, {reverse:true}); //notify all
			zWatch.fire('onSize'); //notify all
			_reszInf.lastTime = jq.now() + 8;
		} finally {
			_reszInf.inResize = false;
		}
	}
	//Invoke the first root wiget's afterKeyDown_
	function _afterKeyDown(wevt) {
		var dts = zk.Desktop.all, Page = zk.Page;
		for (var dtid in dts)
			for (var wgt = dts[dtid].firstChild; wgt; wgt = wgt.nextSibling)
				if (wgt.$instanceof(Page)) {
					for (var w = wgt.firstChild; w; w = w.nextSibling)
						if (_afterKD(w, wevt))
							return;
				} else if (_afterKD(wgt, wevt))
					return; //handled
	}
	function _afterKD(wgt, wevt) {
		if (!wgt.afterKeyDown_)
			return; //handled
		wevt.target = wgt; //mimic as keydown directly sent to wgt
		return wgt.afterKeyDown_(wevt,true);
	}

	jq(document)
	.keydown(function (evt) {
		var wgt = Widget.$(evt, {child:true}),
			wevt = new zk.Event(wgt, 'onKeyDown', evt.keyData(), null, evt);
		if (wgt) {
			_doEvt(wevt);
			if (!wevt.stopped && wgt.afterKeyDown_) {
				wgt.afterKeyDown_(wevt);
				if (wevt.domStopped)
					wevt.domEvent.stop();
			}
		} else
			_afterKeyDown(wevt);

		if (evt.keyCode == 27
		&& (zk._noESC > 0 || zAu.shallIgnoreESC())) //Bug 1927788: prevent FF from closing connection
			return false; //eat
	})
	.keyup(function (evt) {
		var wgt = zk.keyCapture;
		if (wgt) zk.keyCapture = null;
		else wgt = Widget.$(evt, {child:true});
		_doEvt(new zk.Event(wgt, 'onKeyUp', evt.keyData(), null, evt));
	})
	.keypress(function (evt) {
		var wgt = zk.keyCapture;
		if (!wgt) wgt = Widget.$(evt, {child:true});
		_doEvt(new zk.Event(wgt, 'onKeyPress', evt.keyData(), null, evt));
	})
	.bind('zcontextmenu', function (evt) {
		//ios: zcontextmenu shall be listened first,
		//due to need stop other event (ex: click, mouseup) 
		
		zk.clickPointer[0] = evt.pageX;
		zk.clickPointer[1] = evt.pageY;

		var wgt = Widget.$(evt, {child:true});
		if (wgt) {
			if (zk.ie)
				evt.which = 3;
			var wevt = new zk.Event(wgt, 'onRightClick', evt.mouseData(), {}, evt);
			_doEvt(wevt);
			if (wevt.domStopped)
				return false;
		}
		return !zk.ie || evt.returnValue;
	})
	.bind('zmousedown', function(evt){
		var wgt = Widget.$(evt, {child:true});
		_docMouseDown(
			new zk.Event(wgt, 'onMouseDown', evt.mouseData(), null, evt),
			wgt);
	})
	.bind('zmouseup', function(evt){
		var e = zk.Draggable.ignoreMouseUp(), wgt;
		if (e === true)
			return; //ignore

		if (e != null) {
			_docMouseDown(e, null, true); //simulate mousedown

			//simulate focus if zk.Draggable invokes evt.stop
			if ((wgt = e.target) && wgt != zk.currentFocus
			&& !zk.Draggable.ignoreStop(wgt.$n()))
				try {wgt.focus();} catch (e) {}
				//Bug 3017606/2988327: don't invoke window.blur,or browser might be min (IE/FF)
		}

		wgt = zk.mouseCapture;
		if (wgt) zk.mouseCapture = null;
		else wgt = Widget.$(evt, {child:true});
		_doEvt(new zk.Event(wgt, 'onMouseUp', evt.mouseData(), null, evt));
	})
	.bind('zmousemove', function(evt){
		zk.currentPointer[0] = evt.pageX;
		zk.currentPointer[1] = evt.pageY;

		var wgt = zk.mouseCapture;
		if (!wgt) wgt = Widget.$(evt, {child:true});
		_doEvt(new zk.Event(wgt, 'onMouseMove', evt.mouseData(), null, evt));
	})
	.mouseover(function (evt) {
		if (zk.ios && zk.Draggable.ignoreClick()) return;
		zk.currentPointer[0] = evt.pageX;
		zk.currentPointer[1] = evt.pageY;

		_doEvt(new zk.Event(Widget.$(evt, {child:true}), 'onMouseOver', evt.mouseData(), {ignorable:1}, evt));
	})
	.mouseout(function (evt) {
		_doEvt(new zk.Event(Widget.$(evt, {child:true}), 'onMouseOut', evt.mouseData(), {ignorable:1}, evt));
	})
	.click(function (evt) {
		if (zk.Draggable.ignoreClick()) return;

		zjq._fixClick(evt);

		if (evt.which == 1)
			_doEvt(new zk.Event(Widget.$(evt, {child:true}),
				'onClick', evt.mouseData(), {}, evt));
			//don't return anything. Otherwise, it replaces event.returnValue in IE (Bug 1541132)
	})
	.bind('zdblclick', function (evt) {
		if (zk.Draggable.ignoreClick()) return;

		var wgt = Widget.$(evt, {child:true});
		if (wgt) {
			var wevt = new zk.Event(wgt, 'onDoubleClick', evt.mouseData(), {}, evt);
			_doEvt(wevt);
			if (wevt.domStopped)
				return false;
		}
	});

	zjq.fixOnResize(900); //IE6/7: it sometimes fires an "extra" onResize in loading

	
	var _sizeHandler = function(){
		if (zk.mounting || zk.skipResize)
			return;

		//Tom Yeh: 20051230:
		//1. In certain case, IE will keep sending onresize (because
		//grid/listbox may adjust size, which causes IE to send onresize again)
		//To avoid this endless loop, we ignore onresize a while if this method
		//was called
		//
		//2. IE keeps sending onresize when dragging the browser's border,
		//so we have to filter (most of) them out

		var now = jq.now();
		if ((_reszInf.lastTime && now < _reszInf.lastTime) || _reszInf.inResize)
			return; //ignore resize for a while (since onSize might trigger onsize)

		var delay = zk.ie ? 250: 50;
		_reszInf.time = now + delay - 1; //handle it later
		setTimeout(_docResize, delay);
	};
	
	if(zk.mobile)
		jq(window).bind("orientationchange", _sizeHandler);
	else
		jq(window).resize(_sizeHandler);

	jq(window).scroll(function () {
		zWatch.fire('onScroll'); //notify all
	})
	.unload(function () {
		zk.unloading = true; //to disable error message

		//20061109: Tom Yeh: Failed to disable Opera's cache, so it's better not
		//to remove the desktop.
		//Good news: Opera preserves the most udpated content, when BACK to
		//a cached page, its content. OTOH, IE/FF/Safari cannot.
		//Note: Safari/Chrome won't send rmDesktop when onunload is called
		var bRmDesktop = !zk.opera && !zk.keepDesktop;
		if (bRmDesktop || zk.pfmeter) {
			try {
				var dts = zk.Desktop.all;
				for (var dtid in dts)
					zAu._rmDesktop(dts[dtid], !bRmDesktop);
			} catch (e) { //silent
			}
		}
	});

	var _oldBfUnload = window.onbeforeunload;
	window.onbeforeunload = function () {
		if (!zk.skipBfUnload) {
			if (zk.confirmClose)
				return zk.confirmClose;

			for (var j = 0; j < _bfUploads.length; ++j) {
				var s = _bfUploads[j]();
				if (s) return s;
			}
		}

		if (_oldBfUnload) {
			var s = _oldBfUnload.apply(window, arguments);
			if (s) return s;
		}

		zk.unloading = true; //FF3 aborts ajax before calling window.onunload
		//Return nothing
	};

	zk.afterMount(function(){jq('script.z-runonce').remove();});
		//clean up the runonce script. otherwise, it might be run again if
		//the script element is moved
}); //jq()
