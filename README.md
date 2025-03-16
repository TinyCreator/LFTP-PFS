# LFTP-PFS 
Command-line tool to automate file synchronization

## Description
LFTP has a tool called mirror which allows copying a directory tree from a remote location to a local one, or vice versa. With this shell script, given the login parameters, you can save time navigating through your FTP server and reduce typing.<br>
PFS (this tool) covers both cases (local-to-remote and remote-to-local) so that any changes can be updated with a simple y. It also allows the user to save login parameters in a preferences file, reducing interaction.

## Requirements
- Debian Linux or a Debian-based distribution (it may run on other distributions, but this is the contemplated scenario).
- LFTP is installed, if not it can be installed with:

```bash
apt install lftp
```
- Active access to a FTP server.

## Usage
- Clone this repo somewhere where you have access to execute files (e.g: your personal directory).
- You can set the ´preferences.conf´ yourself, do it interactively or log in manually every time.
- Follow the process through your terminal for the active session. 

## LICENSE
This software is licensed under GPL-2.0 license
