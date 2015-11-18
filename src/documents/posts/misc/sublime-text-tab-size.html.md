---
title: "Set Sublime Text Editor Tab Size for a File Type and Globally"
layout: "post"
tags: [sublime text,tab size,tips]
flags: post
---

As there is no single silver bullet, there is no single appropraite tab size. Each situation calls for a different tab size and tab representation.

Sometimes we need tab character to be included, sometimes we need tab character to be replaced by spaces.

## Setting Tab Preferences for a File Type

In this recipe I will show you how to set the tab size to a 4 spaces and replace tab with spaces. This is my preferred setting for Python files.

Go ahead and open or create a new Python file.

1. From the menu open `Preferences > Settings - More > Syntax Specific - User`. 
2. The `Python.sublime-settings` file is opened.
3. Modify the file:
    ```json
    {
        "tab_size": 4,
        "translate_tabs_to_spaces": true
    }
    ```
4. Save the `Python.sublime-settings` file

## Setting Tab Preferences Globally

In general I prefer to use two spaces for tabulation. It is possible that we define global Sublime Text editor tab settings.

1. From the menu open `Preferences > Settings - Default`.
2. The `Preferences.sublime-settings` file is opened.
3. Search for the `tab_size` and `translate_tabs_to__spaces` settings and modify them:
    ```json
    // The number of spaces a tab is considered equal to
    "tab_size": 2,

    // Set to true to insert spaces when tab is pressed
    "translate_tabs_to_spaces": true,
    ```

These are the default global settings. They are overridden by syntax specific settings. Earlier we set the tab settings for Python file. If we now open and edit a Python file, the tab_size will still be 4.
