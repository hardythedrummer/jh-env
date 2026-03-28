{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Joey Hardy";
      init.defaultBranch = "main";
      core.editor = "code --wait";
      pull.rebase = true;
      rerere.enabled = true;
      alias = {
        co = "checkout";
        br = "branch";
        st = "status";
        lg = "log --oneline --graph --decorate -20";
      };
    };

    includes = [
      {
        condition = "gitdir:~/code/jh/";
        path = "~/.gitconfig-personal";
      }
      {
        condition = "gitdir:~/code/";
        path = "~/.gitconfig-work";
      }
    ];
  };

  home.file = {
    ".gitconfig-personal".source = ../../git/.gitconfig-personal;
    ".gitconfig-work".source = ../../git/.gitconfig-work;
  };
}
