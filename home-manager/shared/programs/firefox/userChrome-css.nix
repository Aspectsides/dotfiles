{ theme }:

with theme.colors;

/*
  Theme stolen and modified from (https://github.com/aadilayub/firefox-i3wm-theme)
*/

''
  :root {
  	--tab-active-bg-color: #${base02};		/* background color of an active tab */
  	--tab-inactive-bg-color: #${base00};		/* background color of an inactive tab */
  	--tab-active-fg-fallback-color: #${base06};	/* color of text in an active tab without a container */
  	--tab-inactive-fg-fallback-color: #${base05};	/* color of text in an inactive tab without a container */

  	/* try increasing if you encounter problems */
  	--urlbar-height-setting: 30px;
  	--tab-min-height: 40px !important;

  	/* I don't recommend you touch this unless you know what you're doing */
  	--arrowpanel-menuitem-padding: 2px !important;
  	--arrowpanel-border-radius: 0px !important;
  	--arrowpanel-menuitem-border-radius: 0px !important;
  	--toolbarbutton-border-radius: 0px !important;
  	--toolbarbutton-inner-padding: 0px 2px !important;
  } 

  /* --- GENERAL DEBLOAT ---------------------------------- */

  /* Bottom left page loading status or url preview */
  #statuspanel { display: none !important; }

  /* Hide dropdown that appears when you type in search bar */
  .autocomplete-history-popup, panel[type=autocomplete-richlistbox], panel[type=autocomplete] {
  	display: none !important;
  }

  /* --- DEBLOAT NAVBAR ----------------------------------- */

  #urlbar[breakout][breakout-extend] {
    top: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
    left: 0 !important;
    width: 100% !important;
  }

  #urlbar[breakout][breakout-extend] > #urlbar-input-container {
    height: var(--urlbar-height) !important;
    padding-block: 0px !important;
    padding-inline: 0px !important;
  }

  #urlbar[breakout][breakout-extend][breakout-extend-animate] > #urlbar-background {
    animation-name: none !important;
  }

  #urlbar[breakout][breakout-extend] > #urlbar-background {
    box-shadow: none !important;
  }

  #star-button-box {display: none !important;}

  #back-button { display: none; }
  #forward-button { display: none; }
  #reload-button { display: none; }
  #stop-button { display: none; }
  #home-button { display: none; }
  #library-button { display: none; }
  #fxa-toolbar-menu-button { display: none; }
  /* empty space before and after the url bar */
  #customizableui-special-spring1, #customizableui-special-spring2 { display: none; }

  /* --- STYLE NAVBAR ------------------------------------ */

  /* Move nav bar to the bottom */
  #nav-bar{
    position: fixed !important;
    bottom: 0px;
    display: -webkit-box;
    width: 100%;
    z-index: 1;
  }

  #nav-bar-customization-target{ -webkit-box-flex: 1; }

  /* remove padding between toolbar buttons */
  toolbar .toolbarbutton-1 { padding: 0 !important; }

  /* add padding to the right of the last button so that it doesn't touch the edge of the window */
  #PanelUI-menu-button {
  	padding: 0px 4px 0px 0px !important;
  }

  #nav-bar, #navigator-toolbox {
  	border-width: 0 !important;
  	--toolbar-field-focus-border-color: #${base00};
  }

  #urlbar-container {
  	--urlbar-container-height: var(--urlbar-height-setting) !important;
  	margin-left: 0 !important;
  	margin-right: 0 !important;
  	padding-top: 0 !important;
  	padding-bottom: 0 !important;
  	font-family: monospace;
  	font-size: 12px;
  }

  #urlbar {
  	--urlbar-height: var(--urlbar-height-setting) !important;
  	--urlbar-toolbar-height: var(--urlbar-height-setting) !important;
  	min-height: var(--urlbar-height-setting) !important;
    border-width: 0 !important;
  }

  #urlbar-background {
  	border-width: 0 !important;
  	border-radius: 0 !important;
  }

  #urlbar-input-container {
  	border-width: 0 !important;
  	margin-left: 0.5em !important;
  }

  #urlbar-input {
  	margin-left: 0.4em !important;
  	margin-right: 0.4em !important;
  }

  /* weird hack to keep pop-up menus from overlapping with navbar */
  #widget-overflow { margin: 0 !important; }
  #appMenu-popup { margin: 0 !important; }
  #customizationui-widget-panel { margin: 0 !important; }

  /* --- DEBLOAT URLBAR ----------------------------------- */

  #identity-box { display: none; }
  #pageActionButton { display: none; }
  #pocket-button { display: none; }
  #urlbar-zoom-button { display: none; }
  #tracking-protection-icon-container { display: none !important; }
  #reader-mode-button{ display: none !important; }
  #star-button { display: none; }

  /* this will remove the invisible box at the end of urlbar but also will
   * disable the Ctrl+D shortcut */
  /* #star-button-box { display: none; } */

  /* Go to arrow button at the end of the urlbar when searching */
  #urlbar-go-button { display: none; }

  /* remove container indicator from urlbar */
  #userContext-label, #userContext-indicator { display: none !important;}

  /* --- STYLE TAB TOOLBAR -------------------------------- */

  .tabbrowser-tab:only-of-type,
  .tabbrowser-tab[first-visible-tab="true"][last-visible-tab="true"]{
    visibility: collapse !important;
    min-height: 0 !important;
    height: 0;
    max-height: 0;
  }

  /* Center Tabs */
  .tab-label-container{
    display: grid;
    justify-content: safe center;
    align-items: safe center;
  }

  .tab-secondary-label{
    -moz-box-pack: center;
  }

  .tab-label,
  .tab-secondary-label{ overflow: hidden }

  .tabbrowser-tab[selected]:not(:hover) .tab-label-container:not([labeldirection="rtl"]),
  #tabbrowser-tabs:not([closebuttons="activetab"]) .tabbrowser-tab:not(:hover,[pinned]) .tab-label-container:not([labeldirection="rtl"]){
    margin-inline-end: 7px;
  }

  #tabbrowser-arrowscrollbox{
    --uc-scrollbox-pack: center;
  }
  #tabbrowser-arrowscrollbox[overflowing]{
    --uc-scrollbox-pack: start;
  }
  scrollbox[orient="horizontal"] {
    -moz-box-pack: var(--uc-scrollbox-pack,initial) !important;
  }


  #titlebar {
  	--proton-tab-block-margin: 0px !important;
  	--tab-block-margin: 0 !important;
  }

  #TabsToolbar, .tabbrowser-tab {
  	max-height: var(--tab-min-height) !important;
  	font-size: 12px !important;
  }

  /* Change color of normal tabs */
  tab:not([selected="true"]) {
  	background-color: var(--tab-inactive-bg-color) !important;
  	color: var(--identity-icon-color, var(--tab-inactive-fg-fallback-color)) !important;
	padding: 1px !important;
	border: 0px solid transparent !important;
  }

  tab {
  	font-family: monospace;
  	font-weight: bold;
  	border: none !important;
  }

  /* safari style tab width */
  .tabbrowser-tab[fadein] { max-width: 100vw !important; border: none }

  /* Hide close button on tabs */
  #tabbrowser-tabs .tabbrowser-tab .tab-close-button { display: none !important; }

  /* disable favicons in tab */
  .tab-icon-stack:not([pinned]) { display: none !important; }

  /* Narrow the gap between the favicon and the title */
  .tab-icon-image:not([pinned]) {
  	margin-inline-end: 6px !important;
  }

  /* Change the size of the favicon */
  .tab-icon-image {
  	width: 10px !important;
  	height: 10px !important;
    margin: 5px !important;
  }

  .tabbrowser-tab {
  	/* remove border between tabs */
  	padding-inline: 0px !important;
  	/* reduce fade effect of tab text */
  	--tab-label-mask-size: 1em !important;
  	/* fix pinned tab behaviour on overflow */
  	overflow-clip-margin: 0px !important;
  }

  /* Tab: selected colors */
  #tabbrowser-tabs .tabbrowser-tab[selected] .tab-content {
  	background: var(--tab-active-bg-color) !important;
  	color: var(--identity-icon-color, var(--tab-active-fg-fallback-color)) !important;
  	padding: 1px !important;
	border: 0px solid transparent !important;  
  }

  /* Tab: hovered colors */
  #tabbrowser-tabs .tabbrowser-tab:hover:not([selected]) .tab-content {
  	background: var(--tab-active-bg-color) !important;
  }

  /* hide window controls */
  .titlebar-buttonbox-container { display: none; }

  /* remove titlebar spacers */
  .titlebar-spacer { display: none !important; }

  /* disable tab shadow */
  #tabbrowser-tabs:not([noshadowfortests]) .tab-background:is([selected], [multiselected]) {
      box-shadow: none !important;
  }

  /* remove dark space between pinned tab and first non-pinned tab */
  #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs]) >
  #tabbrowser-arrowscrollbox >
  .tabbrowser-tab[first-visible-unpinned-tab] {
  	margin-inline-start: 0px !important;
  }

  /* remove dropdown menu button which displays all tabs on overflow */
  #alltabs-button { display: none !important }

  /* fix displaying of pinned tabs on overflow */
  #tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container { height: var(--tab-min-height) !important; }

  /* remove overflow scroll buttons */
  #scrollbutton-up, #scrollbutton-down { display: none !important; }

  /* --- AUTOHIDE URLBAR ---------------------------------- */

  /* hide urlbar unless focused */
  #nav-bar {
  	min-height: 0 !important;
  	max-height: 0 !important;
  	height: 0 !important;
  	--moz-transform: scaleY(0) !important;
  	transform: scaleY(0) !important;
  }

  /* show on focus */
  #nav-bar:focus-within {
  	--moz-transform: scale(1) !important;
  	transform: scale(1) !important;
  	max-height: var(--urlbar-height-setting) !important;
  	height: var(--urlbar-height-setting) !important;
  	min-height: var(--urlbar-height-setting) !important;
  }

  #navigator-toolbox:focus-within > .browser-toolbar {
  	transform: translateY(0);
  	opacity: 1;
  }

  /* show on hover */
  /* #titlebar:hover ~ .browser-toolbar,
  #nav-bar:hover,
  #nav-bar:hover + #PersonalToolbar {
  	transform: translateY(0);
  	opacity: 1;
  }

  #titlebar:hover~#nav-bar,
  #nav-bar:hover {
  	--moz-transform: scale(1) !important;
  	transform: scale(1) !important;
  	max-height: var(--urlbar-height-setting) !important;
  	height: var(--urlbar-height-setting) !important;
  	min-height: var(--urlbar-height-setting) !important;
  } */

''

