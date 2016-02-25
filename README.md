

<!-- saved from url=(0046)http://www.cs.uregina.ca/Links/class-info/205/ -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script>(function blockPopupsFunc(popupBlockMessage, showNotification, extensionId) {
    var stndz = {
        originalWindowOpen: window.open,
        originalDocumentCreateElement: document.createElement,
        originalDocumentCreateEvent: document.createEvent,
        lastCreatedAnchor: undefined,
        lastCreatedAnchorTime: undefined,
        allowed: false
    };

    var windowOpenBlockRegex = /mediaserver|directrev|tradeadexchange|liveadexchanger|interyield\.|ordingly\.com|peritas247\.info|goodbookbook\.com|word-my\.com|terraclicks|tracki112\.com|popped|ahtamsu\.ru|startnewtab\.com|onclickads\.net|europacash\.com|wordkeyhelper\.com|d1110e4\.se|buzzonclick\.com|adultadworld\.com/i;
    var windowOpenAllowRegex = /^http(s)?:\/\/([^\/]*\.)?(pinterest\.com|twitter\.com|paypal\.com|yahoo\.com|facebook\.com|linkedin\.com|salesforce\.com|amazon\.co|google\.co)/i;
    var windowOpenAllowHosts = /^http(s)?:\/\/([^\/]*\.)?(search\.yahoo\.com|linkedin\.com)/i;
    window.open = function() {
        var popupArguments = arguments;
        var openPopupFunc = function() {
            return stndz.originalWindowOpen.apply(window, popupArguments);
        };

        if (stndz.allowed)
            return openPopupFunc();

        var block = arguments[0] && windowOpenBlockRegex.test(arguments[0]);
        if (block) {
            showPopupNotification('ad-popup', arguments, openPopupFunc);
            return { };
        }

        var allow = arguments[0] && (windowOpenAllowRegex.test(arguments[0]) || windowOpenAllowHosts.test(window.location.href));
        if (allow) {
            return openPopupFunc();
        }

        var targetName = arguments.length >= 2 ? arguments[1] : null;
        if (targetName == '_parent' || targetName == '_self' || targetName == '_top')
            return openPopupFunc();

        if (!window.event)
            return openPopupFunc();

        try {
            var windowOpenUrl = new URL(arguments[0]);
            if (windowOpenUrl.host.indexOf(window.location.host) > -1 || (windowOpenUrl.host != "" && window.location.host.indexOf(windowOpenUrl.host) > -1))
                return openPopupFunc();
        } catch(e) { }

        var currentTargetValid = window.event &&
            window.event.currentTarget &&
            window.event.currentTarget !== window &&
            window.event.currentTarget !== document &&
            window.event.currentTarget !== document.body;

        var targetValid = window.event &&
            window.event.target &&
            window.event.target.tagName == 'A' &&
            window.event.target.href.indexOf('http') == -1;

        if (currentTargetValid || targetValid) {
            return openPopupFunc();
        }

        if (showNotification)
            showPopupNotification('not-user-initiated', arguments);

        return { };
    };

    window.stndzStopPopupBlocking = function(iframeGuid) {
        if (popupBlockMessage.iframeGuid == iframeGuid) {
            stndz.allowed = true;
        }
    };

    window.stndzResumePopupBlocking = function(iframeGuid) {
        if (popupBlockMessage.iframeGuid == iframeGuid) {
            stndz.allowed = false;
        }
    };

    document.createElement = function() {
        var element = stndz.originalDocumentCreateElement.apply(document, arguments);
        if (element.tagName == 'A') {
            stndz.lastCreatedAnchorTime = new Date();
            stndz.lastCreatedAnchor = element;
        }

        return element;
    };

    var anchorPopupsExcludedHosts = { 'sh.st': true };
    document.createEvent = function() {
        if (!stndz.allowed && arguments[0].toLocaleLowerCase().indexOf('mouse') > -1 && stndz.lastCreatedAnchorTime && new Date() - stndz.lastCreatedAnchorTime < 50) {
            if (anchorPopupsExcludedHosts[document.location.host]) {
                stndz.lastCreatedAnchor.target = "_top";
            } else if (windowOpenAllowRegex.test(stndz.lastCreatedAnchor.href) == false) {
                var anchor = stndz.lastCreatedAnchor;
                showPopupNotification('create-link', null, function() { anchor.click(); });
                return null;
            }
        }

        return stndz.originalDocumentCreateEvent.apply(document, arguments);
    };

    window.addEventListener("message", function(event) {
        switch (event.data.type) {
            case 'stndz-show-popup-notification':
                if (window !== window.top)
                    return;

                window.stndzPopupActionWindow = event.source;
                window.stndzPopupClicked = function(option) {
                    window.hidePopupNotification();
                    window.stndzPopupActionWindow.postMessage({type: 'stndz-popup-action', option: option}, event.origin);
                };

                if (window.popupNotificationOpen) {
                    window.highlightPopupNotification();
                    return;
                } else if (window.popupNotificationOpen === false) { // if it was previously opened just show it, the delegate to open the new window was created above
                    window.showPopupNotification();
                } else {
                    var notificationElement = createNotificationOnPage();

                    setTimeout(function() {
                        window.showPopupNotification();
                    }, 0);

                    window.showPopupNotification = function() {
                        window.popupNotificationOpen = true;

                        notificationElement.style.top = '0px';

                        var hidePopupNotificationId;
                        window.hidePopupNotification = function() {
                            window.popupNotificationOpen = false;
                            notificationElement.style.top = '-40px';
                            notificationElement.style.height = '30px';
                            clearTimeout(hidePopupNotificationId);
                        };

                        hidePopupNotificationId = setTimeout(window.hidePopupNotification, 30 * 1000);
                        notificationElement.onmouseover = function() {
                            clearTimeout(hidePopupNotificationId);
                        };
                    };

                    var helpOpen = false;
                    var originalBackground = notificationElement.style.background;
                    window.highlightPopupNotification = function() {
                        notificationElement.style.background = '#FFFBCC';
                        setTimeout(function() {
                            notificationElement.style.background = originalBackground;
                        }, 1000);

                        notificationElement.style.height = '120px';
                        helpOpen = true;
                    };

                    window.togglePopupNotificationHelp = function() {
                        notificationElement.style.height = helpOpen ? '30px' : '120px';
                        helpOpen = !helpOpen;
                    };
                }

                break;

            case 'stndz-popup-action':
                window.stndzPopupAction && window.stndzPopupAction(event.data.option);
                break;
        }
    }, false);

    function allowPopupsOnThisPage() {
        stndz.allowed = true;
    }

    function showPopupNotification(blockType, args, openPopupFunc) {
        if (!showNotification)
            return;

        window.stndzPopupAction = function(option) {
            if (option == 'once' || option == 'allow') {
                allowPopupsOnThisPage();
                popupBlockMessage.arguments = args;
                openPopupFunc && openPopupFunc();
            } else {
                showNotification = false;
            }

            popupBlockMessage.option = option;
            var stndzActivateFrame = document.getElementById("stndz-activate");
            var windowToPost = stndzActivateFrame ? stndzActivateFrame.contentWindow : window;
            windowToPost.postMessage(popupBlockMessage, '*');
        };

        window.top.postMessage({
            type: 'stndz-show-popup-notification',
            iframeGuid: popupBlockMessage.iframeGuid,
            blockType: blockType
        }, '*');
    }

    function createNotificationOnPage() {
        var style = document.createElement('style');
        style.textContent = '.stndz-popup-notification {' +
        'width: 670px;' +
        'height: 30px;' +
        'position: fixed;' +
        'overflow: hidden;' +
        'top: -40px;' +
        'margin: 0 auto;' +
        'z-index: 2147483647;' +
        'left: 0px;' +
        'right: 0px;' +
        'background: rgb(240, 240, 240);' +
        'border-radius: 0px 0px 5px 5px;' +
        'border: solid 1px #999999;' +
        'box-shadow: 0px 2px 5px #444444;' +
        'border-top: none; ' +
        'line-height: 31px;' +
        'font-size: 12px;' +
        'font-family: sans-serif;' +
        'color: #59595c;' +
        'text-align: center;' +
        'direction: ltr;' +
        'transition-duration: 500ms;}' +
        '.stndz-button {' +
        'padding: 3px 15px !important;' +
        'border: solid 1px #a4a6aa !important;' +
        'height: 25px !important;' +
        'border-radius: 5px !important;' +
        'background-color: #3058b0 !important;' +
        'background: linear-gradient(#f5f5f5, #dfdfdf) !important;' +
        'box-shadow: inset 0px 1px 0px #ffffff, inset 0 -1px 2px #acacac !important;' +
        'color: #555555 !important;' +
        'font-size: 12px !important;' +
        'line-height: 16px !important;' +
        'font-family: sans-serif !important;' +
        'text-align: center !important;' +
        'background-repeat: no-repeat !important;' +
        'text-decoration: none !important;}' +
        '.stndz-button:hover{' +
        'background: linear-gradient(#eeeeee, #d1d1d1) !important;' +
        'text-decoration: none !important;' +
        'color: #555555 !important;}';
        document.documentElement.appendChild(style);

        var div = document.createElement('div');
        div.setAttribute('class', 'stndz-popup-notification');
        div.innerHTML = '<img src="chrome-extension://' + extensionId + '/views/web_accessible/images/icon.png" style="top: 5px; left: 5px;height: 20px; display: initial;position: absolute;">' +
        '&nbsp;<b>Site Popup Blocked:</b>' +
        '&nbsp;&nbsp;<a href="javascript:void(0)" id="stndz-popup-allow-once" class="stndz-button">Allow once</a>' +
        '&nbsp;&nbsp;<a href="javascript:void(0)" id="stndz-popup-allow" class="stndz-button">Allow always</a>' +
        '&nbsp;&nbsp;<a href="javascript:void(0)" id="stndz-popup-block" class="stndz-button">Block always</a>' +
        '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="stndz-popup-help"><img src="chrome-extension://' + extensionId + '/views/web_accessible/images/help.png" style="opacity: 0.3; position: absolute; top: 7px; display: initial;right: 30px;" /></a>' +
        '&nbsp;<a href="javascript:void(0)" id="stndz-popup-close"><img src="chrome-extension://' + extensionId + '/views/web_accessible/images/close.png" style="opacity: 0.3; position: absolute; top: 7px; display: initial;right: 7px;" /></a>' +
        '<br /><div style="line-height: 22px; text-align: left; padding: 0px 5px 0px 5px; font-size: 11px;">The site tried to open a popup and Stands blocked it.' +
        '<br />if you don\'t trust this site you should click <b>"Block always"</b>, if you do click <b>"Allow always"</b>.' +
        '<br />If you\'re not sure click <b>"Allow once"</b> which will open the popup and pause popup blocking for the current page visit.' +
        '<br />You can always change your settings in the application window.</div>';
        document.body.appendChild(div);

        document.getElementById("stndz-popup-allow-once").onclick = function(event) { event.stopPropagation(); window.stndzPopupClicked("once") };
        document.getElementById("stndz-popup-allow").onclick = function(event) { event.stopPropagation(); window.stndzPopupClicked("allow") };
        document.getElementById("stndz-popup-block").onclick = function(event) { event.stopPropagation(); window.stndzPopupClicked("block") };
        document.getElementById("stndz-popup-help").onclick = function(event) { event.stopPropagation(); window.togglePopupNotificationHelp() };
        document.getElementById("stndz-popup-close").onclick = function(event) { event.stopPropagation(); window.hidePopupNotification(); };

        return div;
    }
})({"type":"popup-user-action","iframeGuid":"2L5GRGYA9xTSDtWjgWO3mvOjdBvthuNcnavx"},true, 'lgblnfidahcdcjddiepkckcfdhpknnjh');</script><style>iframe[id*="google_ads_iframe_"] { display: none !important; } </style><style type="text/css">ol{margin:0;padding:0}.c6{border-right-style:solid;padding:5pt 5pt 5pt 5pt;border-bottom-color:#000000;border-top-width:1pt;border-right-width:1pt;border-left-color:#000000;vertical-align:top;border-right-color:#000000;border-left-width:1pt;border-top-style:solid;border-left-style:solid;border-bottom-width:1pt;width:119.2pt;border-top-color:#000000;border-bottom-style:solid}.c7{border-right-style:solid;padding:5pt 5pt 5pt 5pt;border-bottom-color:#000000;border-top-width:1pt;border-right-width:1pt;border-left-color:#000000;vertical-align:top;border-right-color:#000000;border-left-width:1pt;border-top-style:solid;border-left-style:solid;border-bottom-width:1pt;width:159pt;border-top-color:#000000;border-bottom-style:solid}.c2{border-right-style:solid;padding:5pt 5pt 5pt 5pt;border-bottom-color:#000000;border-top-width:1pt;border-right-width:1pt;border-left-color:#000000;vertical-align:top;border-right-color:#000000;border-left-width:1pt;border-top-style:solid;border-left-style:solid;border-bottom-width:1pt;width:45.8pt;border-top-color:#000000;border-bottom-style:solid}.c3{border-right-style:solid;padding:5pt 5pt 5pt 5pt;border-bottom-color:#000000;border-top-width:1pt;border-right-width:1pt;border-left-color:#000000;vertical-align:top;border-right-color:#000000;border-left-width:1pt;border-top-style:solid;border-left-style:solid;border-bottom-width:1pt;width:144pt;border-top-color:#000000;border-bottom-style:solid}.c1{color:#000000;font-weight:bold;text-decoration:none;vertical-align:baseline;font-size:11pt;font-family:"Arial";font-style:normal}.c0{padding-top:0pt;padding-bottom:0pt;line-height:1.0;text-align:left;direction:ltr}.c11{background-color:#ffffff;max-width:468pt;padding:72pt 72pt 72pt 72pt}.c10{border-collapse:collapse;margin-right:auto}.c8{orphans:2;widows:2;direction:ltr}.c13{color:inherit;text-decoration:inherit}.c9{color:#1155cc;text-decoration:underline}.c5{height:0pt}.c12{height:11pt}.c4{font-weight:bold}.title{padding-top:0pt;color:#000000;font-size:26pt;padding-bottom:3pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}.subtitle{padding-top:0pt;color:#666666;font-size:15pt;padding-bottom:16pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}li{color:#000000;font-size:11pt;font-family:"Arial"}p{margin:0;color:#000000;font-size:11pt;font-family:"Arial"}h1{padding-top:20pt;color:#000000;font-size:20pt;padding-bottom:6pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h2{padding-top:18pt;color:#000000;font-size:16pt;padding-bottom:6pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h3{padding-top:16pt;color:#434343;font-size:14pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h4{padding-top:14pt;color:#666666;font-size:12pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h5{padding-top:12pt;color:#666666;font-size:11pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h6{padding-top:12pt;color:#666666;font-size:11pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;font-style:italic;orphans:2;widows:2;text-align:left}</style><style id="style-1-cropbar-clipper">/* Copyright 2014 Evernote Corporation. All rights reserved. */
.en-markup-crop-options {
    top: 18px !important;
    left: 50% !important;
    margin-left: -100px !important;
    width: 200px !important;
    border: 2px rgba(255,255,255,.38) solid !important;
    border-radius: 4px !important;
}

.en-markup-crop-options div div:first-of-type {
    margin-left: 0px !important;
}
</style></head><body class="c11"><p class="c8"><span class="c4">CS 205</span></p><p class="c8"><span class="c4">Introduction to Multimedia Systems</span></p><p class="c8"><span class="c4">Lab Outline (Winter 2016)<br><br>Lab Instructor: Trevor Tomesh (</span><span class="c4 c9"><a class="c13" href="mailto:tmtomesh@gmail.com">tmtomesh@gmail.com</a></span><span class="c4">, tomesh2t@uregina.ca)</span><span class="c4"><br>Location: CL 135 (UDML)</span></p><p class="c8 c12"><span class="c4"></span></p><p class="c8 c12"><span class="c4"></span></p><a href="http://www.cs.uregina.ca/Links/class-info/205/#" id="b78a754f77f81f00ce501effc5afdcbcda1d6227" name="b78a754f77f81f00ce501effc5afdcbcda1d6227"></a><a href="http://www.cs.uregina.ca/Links/class-info/205/#" id="0" name="0"></a><table cellpadding="0" cellspacing="0" class="c10"><tbody><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Lab</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Dates </span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Contents</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Text</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">0</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Jan. &nbsp;14 / Jan. 19</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Intro to UDML / Processing</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Reas &amp; Fry, pp. 7-14</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">1</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Jan 21 / Jan 26</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Processing and Text</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Reas &amp; Fry, pp. 83-86;</span></p><p class="c0"><span class="c1">Shiffman pp. 309-323</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">2</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Jan 28 / Feb 2</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Processing and Images</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Reas &amp; Fry, pp. 77-82;</span></p><p class="c0"><span class="c1">Shiffman pp. 255-274</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">3</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Feb 4 / Feb 9</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Photo Editing</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Shiffman pp. 255 - 274</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">NO LABS</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">4</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Feb 11 / Feb 23</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Digital Music</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">5</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">Feb 25 / March 1</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Processing and Sound</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Shiffman pp. 381-396</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">6</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">March 3 / March 8</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Processing and Animation</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Reas &amp; Fry 91-114;<br></span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">7</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">March 10 / March 15</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Movie Editing</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Shiffman pp.275 - 301</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">8</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">March 17 / March 22</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Remixing Videos</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">Shiffman pp.275-301</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">9</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">March 24 / March 29</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Web Multimedia (processing.js / html)</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">10</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">March 31 / April 5</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Video Games</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td></tr><tr class="c5"><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">11</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c0"><span class="c1">April 7 / April 12</span></p></td><td class="c7" colspan="1" rowspan="1"><p class="c0"><span class="c1">Digital Art Show</span></p></td><td class="c3" colspan="1" rowspan="1"><p class="c0"><span class="c1">---</span></p></td></tr></tbody></table><p class="c8 c12"><span class="c4"></span></p><p class="c8 c12"><span></span></p></body></html>
