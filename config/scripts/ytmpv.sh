#!/usr/bin/env bash
wl-paste | xargs mpv --ytdl-format= "bestvideo[height<=?720]+bestaudio/best";
 
