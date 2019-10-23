#  Insighter

MacOS menu bar app that displays current and total number of spaces.

## Requirements

The following:

- yabai;
- fish (easily replaceable);
- jq (easily removable).

Tried parsing `~/Library/Preferences/com.apple.spaces.plist`, but ended querying `yabai` itself as it proved to be easier. Of course these dependencies are quite ugly, but it fits my requirements for the time being.
