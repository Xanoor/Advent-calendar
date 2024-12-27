# Advent-calendar
<b>Advent calendar for FiveM</b>
> **⚠️ This is an old project, and it may no longer be compatible with the current version of ESX or FiveM. ⚠️**  
> **This project is no longer maintained and may not receive updates or support.**

## CONTENTS
* [Setup](#setup)
* [Requirements](#requirements)
* [Config](#config)
* [Usage](#usage)

# 🤖setup

<li>Drag and drop "calendar" folder in one of your ressources folder.</li>
<li>Add this in your server.cfg</li>


```
ensure calendar
```

<li>Create table in your database</li>


```sql
CREATE TABLE `calendar` (
	`identifier` VARCHAR(40) NOT NULL,
	`day` INT NOT NULL DEFAULT 0,

	PRIMARY KEY (`identifier`)
);
```

# 📃requirements

<li>Async</li>
<li>mysql-async</li>

# 💻config

<li><b>Text are modifiable in config.lua</b></li>
<li><b>ESX / no ESX (true / false) in config.lua</b></li>
<li><b>Rewards can be modifiable in config.lua</b></li>


# 💬usage

```
/calendar in F8 / chat to open calendar.
```
