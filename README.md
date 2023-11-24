# rp_dLogger
`rp_dLogger` is a Discord logging utility designed for RedM servers. Its purpose is to provide server administrators with a simple and efficient way to log various server events directly to Discord channels via webhooks. Whether you want to keep track of player activity, server resource events, or in-game chat messages, rp_dLogger facilitates real-time notifications in your Discord server, keeping your team informed and up-to-date.

## Features
* **Real-time Discord Notifications**: Sends server event notifications to configured Discord channels through webhooks.
* **Customizable Event Triggers**: Choose which events to log, including player joins/leaves, chat messages, character creation, and more.
* **Flexible Configuration**: Easy to adjust settings for each event type via a single configuration file.
* **Color-Coded Embeds**: Enhance readability with color-coded Discord embeds for different event types.

## Configuration
The `config.lua` file is where you define settings for each type of event you want to log. Here's a brief overview of the configuration options available:

* **Webhooks**: Set individual webhook URLs for different types of logs.
* **onStart/onStop**: Toggle logging for resource start/stop events and customize messages.
* **onMessage**: Enable chat message logging with customizable embed settings.
* **onJoin/onLeave**: Configure join/leave notifications with optional player session time.
* **onCharacterCreate/onCharacterSelected**: Log character creation and selection events with detailed player information.

## Installation
1. Place `rp_dLogger` in your server's resources directory.
2. Configure `config.lua` with your desired settings and Discord webhook URLs.
3. Add ``ensure rp_dLogger`` to your `server.cfg` file.
4. Start your server, and the logger will begin sending events to Discord.
