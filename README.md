# lidawake

Keep a Mac awake with the lid closed, even on battery, toggled from Raycast or the CLI.

It uses `pmset -a disablesleep`, since `caffeinate` and sleep assertions don't stop lid-close sleep on battery.

## Files

- `lid-awake.sh`: `on | off | toggle | status` (default: toggle). Also a Raycast script command.
- `lid-status.sh`: read-only Raycast inline command that shows the current state.
- `setup.sh`: one-time setup that installs a sudoers rule allowing only `pmset -a disablesleep 0|1` without a password.

## Setup

```sh
sudo ./setup.sh
```

In Raycast: Settings → Extensions → Script Commands → Add Directories, then pick this folder.

## Usage

```sh
./lid-awake.sh on
./lid-awake.sh off
./lid-awake.sh status
```

## Notes

- A closed laptop that stays awake in a bag gets hot and drains the battery. Turn it off when done.
- To remove the permission rule: `sudo rm /etc/sudoers.d/lid-awake`
