{ theme }:

with theme.colors;

''
  @namespace url("http://www.w3.org/1999/xhtml");
  :root{ scrollbar-color:  rgb(19,26,33) rgb(41,52,61) }
  *{ scrollbar-width: thin }


  @-moz-document url("about:newtab"), url("about:home") {
    body {
      background-color: #${base01} !important;
    }

    .logo-and-wordmark {
      display: none !important;
    }

    .SnippetBaseContainer {
      display: none !important;
    }

    .search-handoff-button {
      border-radius: 15px !important;
      border-width: 4px !important;
      border-color: #${base01} !important;

      background-size: 0px !important;
      background-color: #${base00} !important;

      padding-inline-start: 10px !important;
      padding-inline-end: 10px !important;
    }

    .icon-settings {
      display: none !important;
    }

    .fake-textbox {
      text-align: center !important;
    }

    .search-wrapper input {
      background-color: #${base00} !important;
      border-radius: 0px !important;

      background-image: none !important;
      background-size: none !important;
      text-align: center !important;
      font-size: 17px !important;

      padding-inline-start: 10px !important;
      padding-inline-end: 10px !important;
    }

    .search-wrapper input:focus {
      text-align: left !important;
    }

    .body-wrapper {
      display: none !important;
    }
  }
''
