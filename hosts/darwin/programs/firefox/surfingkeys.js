const {
    Clipboard,
    Front,
    Hints,
    RUNTIME,
    Visual,
    aceVimMap,
    addSearchAlias,
    addVimMapKey,
    cmap,
    getClickableElements,
    imap,
    imapkey,
    iunmap,
    map,
    mapkey,
    readText,
    removeSearchAlias,
    tabOpenLink,
    unmap,
    vmap,
    vmapkey,
    vunmap
} = api;

// Tab to the right
map('<ArrowRight>', 'R');

// Tab to the left
map('<ArrowLeft>', 'E');

// Disable on websites
map('<Ctrl-s>', '<Alt-s>');

// Navigate history
map('L', 'D');
map('H', 'S');

// Close tab
mapkey('<Ctrl-q>', '#3Close current tab', () => {
  RUNTIME('closeTab');
});

// Show only tabs from the current window
settings.omnibarTabsQuery = {currentWindow: true};

// Speed up scroll. The default is 70.
settings.scrollStepSize = 70;
settings.smoothScroll = false;
