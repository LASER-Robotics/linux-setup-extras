# Tiago's Linux environment - Extra installs

| Ubuntu               | Architecture | Status                                                                                                                                                           |
| -------------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 22.04 Jammy          | AMD64        | [![Build Status](https://github.com/LASER-Robotics/linux-setup/workflows/Jammy/badge.svg)](https://github.com/LASER-Robotics/linux-setup/actions)                              |

## Summary

This repo contains the settings of Tiago's Linux work environment.

It could be summarized as follows:
* **ROS 2 - Humble Hawksbill**
* **tweaks** Ubuntu plus settings manager
* **chrome** Google Chrome browser
* **sublime** Sublime text
* **zoom** Zoom meeting app
* **dolphin** File manager
* **MS Teams** Teams for Linux
* **My tools** terminal file manager
  * **tlp** battery/power manager
  * **nativefier** webapp creator
   * nodejs
  
To clone and install everything run the following code. **BEWARE**, running this will **DELETE** your current .i3, tmux, vim, etc. dotfiles.

*PLEASE: Install it AFTER installing linux-setup environment: https://github.com/LASER-Robotics/linux-setup*

```bash
cd /tmp
echo "cd ~/git
git clone https://github.com/LASER-Robotics/linux-setup-extras.git
cd linux-setup-extras
./install.sh" > run.sh && source run.sh
```
**Calling install.sh repeatedly** will not cause an accumulation of code in your .bashrc, so feel free to update your configuration by rerunning it.

# Credits

I thank the following source for inspiration. It helped me to learn a lot:

* Tomas Baca, https://github.com/klaxalk

# Troubleshooting

It is possible and probable that after you update using ```git pull```, something might not work anymore.
This usually happens due to new programs, plugins, and dependencies that might not be satisfied anymore.
I suggest re-running **install.sh**, after each update.
