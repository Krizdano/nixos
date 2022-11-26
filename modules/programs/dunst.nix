{pkgs, ...}: {

  services.dunst = {
    enable  = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(0, 300)";
        height = 300;
        indicate_hidden = "yes";
        shrink = "no";
        transparency = 0;
        offset = "30x20";
        origin = "top-right";
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        frame_color = "#aaaaaa";
        separator_color = "auto";
        sort = "yes";
        line_height = 0;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        alignment = "center";
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        browser = "usr/bin/env firefox";
        corner_radius = 5;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        close = "control+space";
      };
      urgency_low = {
        background = "#2b2b2b";
        foreground = "#ffffff";
        timeout = 5;
      };
      urgency_normal= {
        background = "#2b2b2b";
        foreground = "#ffffff";
        timeout = 5;
      };
      urgency_critical= {
        background = "#2b2b2b";
        foreground = "#ffffff";
        timeout = 5;
      };
    };
  };


}
