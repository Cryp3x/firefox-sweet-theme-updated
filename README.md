![Screenshot of the theme](images/preview.png)

## Description

A dark and modern theme for firefox

This theme is supposed to work with current supported Firefox releases:

- Firefox 68.0
- Firefox 68 ESR
- Firefox 60 ESR
- Firefox 69.0 Beta
- Firefox 70.0 Nightly

***Firefox 60 ESR issues:***

*(Dark theme variant is broken in Firefox < 67).*

*<https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme#Browser_compatibility>*

## Installation

### Quick Copy Install (Recommended for Modern Firefox)

1. Go to `about:support` > Profile Directory > Open Directory.

2. Download this repo and copy the `firefox-sweet-theme` folder into `chrome/`:

   ```
   mkdir -p chrome
   # Copy firefox-sweet-theme/ into chrome/firefox-sweet-theme/
   ```

3. Edit `chrome/userChrome.css` (create if missing):

   ```
   @import "firefox-sweet-theme/userChrome.css";
   ```

4. In `about:config`, set:
   - `toolkit.legacyUserProfileCustomizations.stylesheets` = `true`

5. Restart Firefox.

### Native Vertical Tabs

1. In `about:config`, search "vertical tabs" or "sidebar vertical".
2. Set the pref (e.g., `sidebar.vertical_tabs.enabled`) to `true`.

The theme supports native vertical tabs with matching backgrounds and styles.

### Script Install (Legacy)

```sh
./scripts/install.sh
```

See options below.

## Uninstalling

1. Go to your firefox profile folder. (Go to about:support in Firefox > Application Basics > Profile Directory > Open Directory)

2. Remove the `chrome` folder.

## Enabling optional features

Open `chrome/firefox-sweet-theme/userChrome.css` with a text editor and follow instructions to enable extra features. Keep in mind this file might change in future versions and your configuration will be lost. You can copy the @imports you want to enable to a new file named `customChrome.css` directly in your `chrome/firefox-sweet-theme` directory if you want it to survive updates. Remember all @imports must be at the top of the file, before other statements.

Alternatively you can run installation script with `-g` flag to auto install GNOMISH features.

```sh
./scripts/install.sh -g
```

*Those features are not included by default, because can introduce bugs or Firefox functionalities lost.*

- **hide-single-tab.css** *GNOMISH*

 Hide the tab bar when only one tab is open.

 You should move the new tab button somewhere else for this to work, because by default it is on the tab bar too.

- **matching-autocomplete-width.css** *GNOMISH*

 Limit the URL bar's autocompletion popup's width to the URL bar's width.

- **system-icons.css**

 Use system theme icons instead of Adwaita icons included by theme.

- **symbolic-tab-icons.css**

 Make all tab icons look kinda like symbolic icons.

## Known bugs

### CSD have sharp corners

See upstream [bug](https://bugzilla.mozilla.org/show_bug.cgi?id=1408360).

### Icons color broken with system-icons.css

Icons might appear black where they should be white on some systems. I have no idea why, but you can adjust them directly in the `system-icons.css` file, look for `--gnome-icons-hack-filter` & `--gnome-window-icons-hack-filter` vars and play with css filters.

## Development

If you wanna mess around the styles and change something, you might find these
things useful.

To use the Inspector to debug the UI, open the developer tools (F12) on any
page, go to options, check both of those:

- Enable browser chrome and add-on debugging toolboxes
- Enable remote debugging

Now you can close those tools and press Ctrl+Alt+Shift+I to Inspect the browser
UI.

Also you can inspect any GTK3 application, for example type this into a terminal
and it will run Epiphany with the GTK Inspector, so you can check the CSS styles
of its elements too.

```sh
GTK_DEBUG=interactive epiphany
```

Feel free to use any parts of my code to develop your own themes, I don't force
any specific license on your code.

## Credits

Based on the awesome [gnome theme](https://github.com/rafaelmardojai/firefox-gnome-theme) by **[Rafael Mardojai CM](https://github.com/rafaelmardojai)**
