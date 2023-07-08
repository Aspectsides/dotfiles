{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.firefox = {
    enable = true;
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
      then pkgs.firefox-bin
      else pkgs.firefox;
  };

  programs.firefox.profiles =
    let
      userChrome = with config.lib.base16.theme; ''
        :root {
          --srf-primary: #${base00-hex};
          --srf-secondary: #${base01-hex};
          --srf-text: #${base04-hex};
          --srf-accent: #${base0C-hex};
        }
        window,
        #main-window,
        #toolbar-menubar,
        #TabsToolbar,
        #PersonalToolbar,
        #navigator-toolbox,
        #sidebar-box {
          background-color: var(--srf-primary) !important;
          -moz-appearance: none !important;
          background-image: none !important;
          border: none !important;
          box-shadow: none !important;
        }
        ::selection {
          background-color: var(--srf-accent);
          color: var(--srf-primary);
        }
        :root {
          --tabs-border: transparent !important;
        }
        .tab-background {
          border: none !important;
          border-radius: 0!important;
          margin: 0!important;
          margin-left: -1.6px!important;
          padding: 0!important;
        }
        .tab-background[selected='true'] {
          -moz-appearance: none !important;
          background-image: none !important;
          background-color: var(--srf-secondary)!important;
        }
        .tabbrowser-tabs {
          border: none !important;
          opacity: 0 !important;
        }
        .tabbrowser-tab::before, .tabbrowser-tab::after{
          opacity: 0 !important;
          border-left: none !important;
        }
        .titlebar-placeholder {
          border: none !important;
        }
        .tab-line {
          display: none !important;
        }
        #back-button,
        #forward-button,
        #whats-new-menu-button,
        #star-button,
        #pocket-button,
        #save-to-pocket-button
        #pageActionSeparator,
        #pageActionButton,
        #reader-mode-button,
        #urlbar-zoom-button,
        #identity-box,
        #PanelUI-button,
        #tracking-protection-icon-container {
          display: none !important;
        }
        #context-navigation,
        #context-savepage,
        #context-pocket,
        #context-sendpagetodevice,
        #context-selectall,
        #context-viewsource,
        #context-inspect-a11y,
        #context-sendlinktodevice,
        #context-openlinkinusercontext-menu,
        #context-bookmarklink,
        #context-savelink,
        #context-savelinktopocket,
        #context-sendlinktodevice,
        #context-searchselect,
        #context-sendimage,
        #context-print-selection,
        #context_bookmarkTab,
        #context_moveTabOptions,
        #context_sendTabToDevice,
        #context_reopenInContainer,
        #context_selectAllTabs,
        #context_closeTabOptions {
          display: none !important;
        }
        #save-to-pocket-button {
          visibility: hidden !important;
        }
        .titlebar-spacer {
          display: none !important;
        }
        .tabbrowser-tab:not([pinned]) .tab-close-button {
          display: none !important;
        }
        .tabbrowser-tab:not([pinned]) .tab-icon-image {
          display: none !important;
        }
        #navigator-toolbox::after {
          border-bottom: 0px !important;
          border-top: 0px !important;
        }
        #nav-bar {
          background: var(--srf-secondary) !important;
          border: none !important;
          box-shadow: none !important;
          margin-top: 0px !important;
          border-top-width: 0px !important;
          margin-bottom: 0px !important;
          border-bottom-width: 0px !important;
        }
        #history-panel,
        #sidebar-search-container,
        #bookmarksPanel {
          background: var(--srf-primary) !important;
        }
        #search-box {
          -moz-appearance: none !important;
          background: var(--srf-primary) !important;
          border-radius: 6px !important;
        }
        #sidebar-search-container {
          background-color: var(--srf-primary) !important;
        }
        #sidebar-icon {
          display: none !important;
        }
        .sidebar-placesTree {
          color: var(--srf-text) !important;
        }
        #sidebar-switcher-target {
          color: var(--srf-text) !important;
        }
        #sidebar-header {
          background: var(--srf-primary) !important;
        }
        #sidebar-box {
          --sidebar-background-color: var(--srf-primary) !important;
        }
        #sidebar-splitter {
          border: none !important;
          opacity: 1 !important;
          background-color: var(--srf-primary) !important;
        }
        .urlbarView {
          display: none !important;
        }
        #urlbar-input-container {
          background-color: var(--srf-secondary) !important;
          border: 1px solid rgba(0, 0, 0, 0) !important;
        }
        #urlbar-container {
          margin-left: 8px !important;
        }
        #urlbar[focused='true'] > #urlbar-background {
          box-shadow: none !important;
        }
        .urlbarView-url {
          color: var(--srf-text) !important;
        }

      '';
      userContent = with config.lib.base16.theme; ''
        :root {
          scrollbar-width: none !important;
        }
        @-moz-document url(about:privatebrowsing) {
          :root {
            scrollbar-width: none !important;
          }
        }
         @-moz-document url("about:newtab"), url("about:home") {
          body {
            background-color: #${base01-hex} !important;
          }
          .search-wrapper .logo-and-wordmark .logo {
            background-image: url("https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png") !important;
            background-size: 100% !important;
            height: 250px !important;
            width: 500px !important;
          }
          .icon-settings,
          .body-wrapper,
          .SnippetBaseContainer,
          .search-handoff-button,
          .search-wrapper .logo-and-wordmark .wordmark,
          .search-wrapper .search-inner-wrapper,
          .search-wrapper input {
            display: none !important;
          }
        }
      '';
      
      settings = {
        "nglayout.initialpaint.delay" = "0";
        "nglayout.initialpaint.delay_in_oopif" = "0";
        "content.notify.interval" = "100000";
        "browser.startup.preXulSkeletonUI" = "false";

        /** EXPERIMENTAL ***/
        "layout.css.grid-template-masonry-value.enabled" = "true";
        "layout.css.animation-composition.enabled" = "true";
        "dom.enable_web_task_scheduling" = "true";

        /** GFX ***/
        "gfx.webrender.all" = "true";
        "gfx.webrender.precache-shaders" = "true";
        "gfx.webrender.compositor" = "true";
        "layers.gpu-process.enabled" = "true";
        "media.hardware-video-decoding.enabled" = "true";
        "gfx.canvas.accelerated" = "true";
        "gfx.canvas.accelerated.cache-items" = "32768";
        "gfx.canvas.accelerated.cache-size" = "4096";
        "gfx.content.skia-font-cache-size" = "80";
        "image.cache.size" = "10485760";
        "image.mem.decode_bytes_at_a_time" = "131072";
        "image.mem.shared.unmap.min_expiration_ms" = "120000";
        "media.memory_cache_max_size" = "1048576";
        "media.memory_caches_combined_limit_kb" = "2560000";
        "media.cache_readahead_limit" = "9000";
        "media.cache_resume_threshold" = "6000";

        /** BROWSER CACHE ***/
        "browser.cache.memory.max_entry_size" = "153600";

        /** NETWORK ***/
        "network.buffer.cache.size" = "262144";
        "network.buffer.cache.count" = "128";
        "network.http.max-connections" = "1800";
        "network.http.max-persistent-connections-per-server" = "10";
        "network.ssl_tokens_cache_capacity" = "32768";

        /****************************************************************************
         * SECTION: SECUREFOX                                                       *
        ****************************************************************************/
        /** TRACKING PROTECTION ***/
        "browser.contentblocking.category" = "strict";
        "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
        "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
        "privacy.query_stripping.strip_list" = "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
        "browser.uitour.enabled" = "false";
        "privacy.globalprivacycontrol.enabled" = "true";
        "privacy.globalprivacycontrol.functionality.enabled" = "true";

        /** OCSP & CERTS / HPKP ***/
        "security.OCSP.enabled" = "0";
        "security.remote_settings.crlite_filters.enabled" = "true";
        "security.pki.crlite_mode" = "2";
        "security.cert_pinning.enforcement_level" = "2";

        /** SSL / TLS ***/
         "security.ssl.treat_unsafe_negotiation_as_broken" = true;
         "browser.xul.error_pages.expert_bad_cert" = true;
         "security.tls.enable_0rtt_data" = false;
        
         /** DISK AVOIDANCE ***/
         "browser.cache.disk.enable" = false;
         "browser.privatebrowsing.forceMediaMemoryCache" = true;
         "browser.sessionstore.privacy_level" = 2;
        
         /** SHUTDOWN & SANITIZING ***/
         "privacy.history.custom" = true;
        
         /** SPECULATIVE CONNECTIONS ***/
         "network.http.speculative-parallel-limit" = 0;
         "network.dns.disablePrefetch" = true;
         "browser.urlbar.speculativeConnect.enabled" = false;
         "browser.places.speculativeConnect.enabled" = false;
         "network.prefetch-next" = false;
         "network.predictor.enabled" = false;
         "network.predictor.enable-prefetch" = false;
        
         /** SEARCH / URL BAR ***/
         "browser.search.separatePrivateDefault.ui.enabled" = true;
         "browser.urlbar.update2.engineAliasRefresh" = true;
         "browser.search.suggest.enabled" = false;
         "browser.urlbar.suggest.quicksuggest.sponsored" = false;
         "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
         "security.insecure_connection_text.enabled" = true;
         "security.insecure_connection_text.pbmode.enabled" = true;
         "network.IDN_show_punycode" = true;
        
         /** HTTPS-FIRST MODE ***/
         "dom.security.https_first" = true;
        
         /** PROXY / SOCKS / IPv6 ***/
         "network.proxy.socks_remote_dns" = true;
         "network.file.disable_unc_paths" = true;
         "network.gio.supported-protocols" = "";
        
         /** PASSWORDS AND AUTOFILL ***/
         "signon.formlessCapture.enabled" = false;
         "signon.privateBrowsingCapture.enabled" = false;
         "signon.autofillForms" = false;
         "signon.rememberSignons" = false;
         "editor.truncate_user_pastes" = false;
        
         /** ADDRESS + CREDIT CARD MANAGER ***/
         "extensions.formautofill.addresses.enabled" = false;
         "extensions.formautofill.creditCards.enabled" = false;
         "extensions.formautofill.heuristics.enabled" = false;
         "browser.formfill.enable" = false;
         
         # MIXED CONTENT + CROSS-SITE
         "network.auth.subresource-http-auth-allow" = 1;
         "pdfjs.enableScripting" = false;
         "extensions.postDownloadThirdPartyPrompt" = false;
         "permissions.delegation.enabled" = false;
        
         # HEADERS / REFERERS
         "network.http.referer.XOriginTrimmingPolicy" = 2;
        
         # CONTAINERS
         "privacy.userContext.ui.enabled" = true;
        
         # WEBRTC
         "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
         "media.peerconnection.ice.default_address_only" = true;
        
         # SAFE BROWSING
         "browser.safebrowsing.downloads.remote.enabled" = false;
        
         # MOZILLA
         "accessibility.force_disabled" = 1;
         "identity.fxaccounts.enabled" = false;
         "browser.tabs.firefox-view" = false;
         "permissions.default.desktop-notification" = 2;
         "permissions.default.geo" = 2;
         "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
         "geo.provider.ms-windows-location" = false; # WINDOWS
         "geo.provider.use_corelocation" = false; # MAC
         "geo.provider.use_gpsd" = false; # LINUX
         "geo.provider.use_geoclue" = false; # LINUX
         "permissions.manager.defaultsUrl" = "";
         "webchannel.allowObject.urlWhitelist" = "";
        
         # TELEMETRY
         "toolkit.telemetry.unified" = false;
         "toolkit.telemetry.enabled" = false;
         "toolkit.telemetry.server" = "data:,";
         "toolkit.telemetry.archive.enabled" = false;
         "toolkit.telemetry.newProfilePing.enabled" = false;
         "toolkit.telemetry.shutdownPingSender.enabled" = false;
         "toolkit.telemetry.updatePing.enabled" = false;
         "toolkit.telemetry.bhrPing.enabled" = false;
         "toolkit.telemetry.firstShutdownPing.enabled" = false;
         "toolkit.telemetry.coverage.opt-out" = true;
         "toolkit.coverage.opt-out" = true;
         "datareporting.healthreport.uploadEnabled" = false;
         "datareporting.policy.dataSubmissionEnabled" = false;
         "app.shield.optoutstudies.enabled" = false;
         "browser.discovery.enabled" = false;
         "breakpad.reportURL" = "";
         "browser.tabs.crashReporting.sendReport" = false;
         "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
         "captivedetect.canonicalURL" = "";
         "network.captive-portal-service.enabled" = false;
         "network.connectivity-service.enabled" = false;
         "default-browser-agent.enabled" = false;
         "app.normandy.enabled" = false;
         "app.normandy.api_url" = "";
         "browser.ping-centre.telemetry" = false;
         "browser.newtabpage.activity-stream.feeds.telemetry" = false;
         "browser.newtabpage.activity-stream.telemetry" = false;
        
         # PESKYFOX SECTION
         # MOZILLA UI
         "layout.css.prefers-color-scheme.content-override" = 2;
         "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
         "app.update.suppressPrompts" = true;
         "browser.compactmode.show" = true;
         "browser.privatebrowsing.vpnpromourl" = "";
         "extensions.getAddons.showPane" = false;
         "extensions.htmlaboutaddons.recommendations.enabled" = false;
         "browser.shell.checkDefaultBrowser" = false;
         "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
         "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
         "browser.preferences.moreFromMozilla" = false;
         "browser.tabs.tabmanager.enabled" = false;
         "browser.aboutwelcome.enabled" = false;
         "findbar.highlightAll" = true;
         "middlemouse.contentLoadURL" = false;
         "browser.privatebrowsing.enable-new-indicator" = false;
        
         # FULLSCREEN
         "full-screen-api.transition-duration.enter" = "0 0";
         "full-screen-api.transition-duration.leave" = "0 0";
         "full-screen-api.warning.delay" = -1;
         "full-screen-api.warning.timeout" = 0;
        
         # URL BAR
         "browser.urlbar.suggest.engines" = false;
         "browser.urlbar.suggest.topsites" = false;
         "browser.urlbar.suggest.calculator" = true;
         "browser.urlbar.unitConversion.enabled" = true;
        
         # NEW TAB PAGE
         "browser.newtabpage.activity-stream.feeds.topsites" = false;
         "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        
         # POCKET
         "extensions.pocket.enabled" = false;
        
         # DOWNLOADS
         "browser.download.useDownloadDir" = false;
         "browser.download.alwaysOpenPanel" = false;
         "browser.download.manager.addToRecentDocs" = false;
         "browser.download.always_ask_before_handling_new_types" = true;
        
         # PDF
         "browser.download.open_pdf_attachments_inline" = true;
        
         # TAB BEHAVIOR
         "browser.tabs.loadBookmarksInTabs" = true;
         "browser.bookmarks.openInTabClosesMenu" = false;
         "layout.css.has-selector.enabled" = true;
      };
    in
    {
      home = {
        id = 0;
        inherit settings;
        inherit userChrome;
        inherit userContent;
        extensions = with config.nur.repos.rycee.firefox-addons; [
          vimium-c
          nighttab
          ublock-origin
          bitwarden
        ];
      };
    };
}