{...}: ''
  @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

  /* TABS: bottom - Firefox 65 and later - updated for 89+ */
  /* https://searchfox.org/mozilla-release/source/browser/themes/shared/tabs.inc.css */
  /* https://raw.githubusercontent.com/Aris-t2/CustomCSSforFx/master/classic/css/tabs/tabs_below_navigation_toolbar_fx89.css */
  /* https://developer.mozilla.org/en-US/docs/Tools/Browser_Toolbox */

  /* ROOT - VARS */
  /* you can adjust the CSS variables until it looks correct */
  /* you can use the Browser Toolbox to get the toolbar heights */

  .tab-label[selected="true"] {
    font-weight: bold;
  }

  *|*:root {
    --tab-toolbar-navbar-overlap: 0px !important;

    --tab-min-height: 40px !important;
    --tab-min-width:  60px !important;

    --tab-adjust:  0px; /* adjust tab bar - only for 68-73 */
    --tab-caption: 5px; /* caption buttons on tab bar */
  }

  /* TAB BAR - below nav-bar */
  #navigator-toolbox toolbar:not(#nav-bar):not(#toolbar-menubar) {-moz-box-ordinal-group:10 !important;}
  #TabsToolbar {-moz-box-ordinal-group:1000 !important;}

  #TabsToolbar {
    display: block !important;
    position: absolute !important;
    bottom: 0 !important;
    width:  50vw !important;
  }

  #tabbrowser-tabs {
    width: 100vw !important;
  }

  /* navigator-toolbox - PADDING */
  *|*:root:not([chromehidden*="toolbar"]) #navigator-toolbox {
    position: relative !important; /*89+*/
    padding-bottom: var(--tab-min-height) !important; /*ADJUST*/
    background-color: var(--toolbar-bgcolor) !important;
  }

  /* TabsToolbar with menubar and titlebar hidden - rules for Firefox 65-73 */
  *|*:root[tabsintitlebar]:not([inFullscreen="true"]):not([sizemode="maximized"]) #toolbar-menubar[autohide="true"] ~
   #TabsToolbar{
    bottom: var(--tab-adjust); /*ADJUST*/
  }

  /* TABS: height */
  #tabbrowser-tabs,
  #tabbrowser-tabs > .tabbrowser-arrowscrollbox,
  .tabbrowser-tabs[positionpinnedtabs] > .tabbrowser-tab[pinned] {
    min-height: var(--tab-min-height) !important;
    max-height: var(--tab-min-height) !important;
  }

  #TabsToolbar {
    width: 100% !important;
    height: var(--tab-max-height) !important;
    background-color: var(--toolbar-bgcolor) !important;
    color:            var(--toolbar-color) !important;
  /*  z-index: 1 !important; */
  }

  /* indicators *//*
  *|*:root[privatebrowsingmode=temporary] .private-browsing-indicator {
    position: absolute !important;
    display: block !important;
    right: 0px !important;
    bottom: 0px !important;
    width: 14px !important;
    pointer-events: none !important;
  }
  */
  .private-browsing-indicator {display: none !important;}
  .accessibility-indicator    {display: none !important;}

  /* Indicators - HIDE *//*
  *|*:root:not([accessibilitymode])             .accessibility-indicator    {display: none !important}
  *|*:root:not([privatebrowsingmode=temporary]) .private-browsing-indicator {display: none !important}
  */

  /* Drag Space */
  .titlebar-spacer[type="pre-tabs"],
  .titlebar-spacer[type="post-tabs"] {
    width: 20px !important;
  }

  /* Override vertical shifts when moving a tab */
  #navigator-toolbox[movingtab] > #titlebar > #TabsToolbar {
    padding-bottom: unset !important;
  }

  #navigator-toolbox[movingtab] #tabbrowser-tabs {
    padding-bottom: unset !important;
    margin-bottom: unset !important;
  }

  #navigator-toolbox[movingtab] > #nav-bar {
    margin-top: unset !important;
  }

  #TabsToolbar #firefox-view-button[open] > .toolbarbutton-icon, #tabbrowser-tabs:not([noshadowfortests]) .tab-background:is([selected], [multiselected]) {
    box-shadow: 0 0 4px rgb(0, 0, 0)
  }

  #TabsToolbar #firefox-view-button[open]:not(:focus-visible) > .toolbarbutton-icon:-moz-lwtheme, .tab-background[selected]:not([multiselected="true"]):-moz-lwtheme {
    outline: none !important;
  }

  .tab-background {
    border-radius: 4px;
  }

  #new-tab-button, #tabs-newtab-button {
    --toolbarbutton-inner-padding: calc((var(--tab-min-height) - 22px) / 2) !important;
  }

  #navigator-toolbox {
    border: none !important;
  }

  #new-tab-button > .toolbarbutton-icon, #tabs-newtab-button {
    width: calc(2 * var(--toolbarbutton-inner-padding) + 18px) !important;
    height: calc(2 * var(--toolbarbutton-inner-padding) + 18px) !important;
    margin-top: auto !important;
  }

  /* Hide window-controls and caption buttons on Tab Bar */
  #TabsToolbar #window-controls {display: none !important;}
  #TabsToolbar .titlebar-buttonbox-container {display: none !important;}
''
