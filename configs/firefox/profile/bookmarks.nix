{...}: {
  flake.configs.firefoxModules.profileModules.bookmarks = {...}: {
    force = true;
    settings = [
      {
        name = "toolbar";
        toolbar = true;
        bookmarks = [
          {
            name = "youtube";
            url = "https://www.youtube.com/";
          }
        ];
      }
    ];
  };
}
