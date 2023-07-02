{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.mbsync.enable = true;
  programs.password-store.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;
  programs.astroid = {
    enable = true;
    externalEditor = "foot nvim -c 'set ft=mail' '+set fileencoding=utf-8' '+set ff=unix' '+set enc=utf-8' '+set fo+=w' %1";
  };
  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
  };

  accounts.email = {
    maildirBasePath = ".local/share/mail";
    accounts = {
      "aspectsidesxyz" = {
        address = "aspectsidesxyz@gmail.com";
        userName = "aspectsidesxyz@gmail.com";
        realName = "Daniel Xu";
        primary = true;

        imap.host = "imap.gmail.com";
        smtp.host = "smtp.gmail.com";

        gpg = {
          key = "B8906B1FFA30D4B5312E6EC7B7D2D56C84ECA153";
          signByDefault = true;
        };
        signature = {
          text = ''
            Thanks,
            Daniel Xu
          '';
          showSignature = "append";
        };

        passwordCommand = "pass mail/aspectsidesxyz@gmail.com";

        msmtp.enable = true;
        notmuch.enable = true;
        astroid.enable = true;

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Bin" "[Gmail]/Starred" "[Gmail]/All Mail" ];
        };
      };
    };
  };
}
