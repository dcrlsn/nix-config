{ ... }:

let
  schemes = rec {
    default = tokyonight;

    tokyonight = {
      scheme = "Tokyo Night";
      hex = {
        bg = "1a1b26";
        bg_dark = "16161e";
        bg_highlight = "292e42";
        fg = "c0caf5";
        fg_dark = "a9b1d6";
        red = "f7768e";
        orange = "ff9e64";
        yellow = "e0af68";
        green = "9ece6a";
        teal = "73daca";
        cyan = "7dcfff";
        blue = "7aa2f7";
        purple = "bb9af7";
        magenta = "bb9af7";
        white = "c0caf5";
        black = "15161e";
        gray = "565f89";
        highlight = "e0af68";
        comment = "565f89";
        active = "7aa2f7";
        inactive = "414868";
        text = "a9b1d6";
      };
      rgb = {
        bg = "26, 27, 38";
        fg = "192, 202, 245";
        red = "247, 118, 142";
        orange = "255, 158, 100";
        yellow = "224, 175, 104";
        green = "158, 206, 106";
        teal = "115, 218, 202";
        cyan = "125, 207, 255";
        blue = "122, 162, 247";
        purple = "187, 154, 247";
        white = "192, 202, 245";
        black = "21, 22, 30";
        gray = "86, 95, 137";
        highlight = "224, 175, 104";
        comment = "86, 95, 137";
        active = "122, 162, 247";
        inactive = "65, 72, 104";
        text = "169, 177, 214";
      };
    };

    onedark = {
      scheme = "One Dark Pro";
      hex = {
        bg = "111111";
        fg = "abb2bf";
        red = "e06c75";
        orange = "d19a66";
        yellow = "e5c07b";
        green = "98c379";
        cyan = "56b6c2";
        blue = "61afef";
        purple = "c678dd";
        white = "abb2bf";
        black = "282c34";
        gray = "5c6370";
        highlight = "e2be7d";
        comment = "7f848e";
        active = "005577";
        inactive = "333333";
        text = "999999";
      };
      rgb = {
        bg = "17, 17, 17";
        fg = "171, 178, 191";
        red = "224, 108, 118";
        orange = "209, 154, 102";
        yellow = "229, 192, 123";
        green = "152, 195, 121";
        cyan = "86, 181, 194";
        blue = "97, 175, 223";
        purple = "197, 120, 221";
        white = "171, 178, 191";
        black = "40, 44, 52";
        gray = "92, 99, 112";
        highlight = "226, 191, 125";
        comment = "127, 132, 142";
        active = "0, 85, 119";
        inactive = "51, 51, 51";
        text = "153, 153, 153";
      };
    };

    doom = {
      scheme = "Doom One Dark";
      black = "000000";
      red = "ff6c6b";
      orange = "da8548";
      yellow = "ecbe7b";
      green = "95be65";
      teal = "4db5bd";
      blue = "6eaafb";
      dark-blue = "2257a0";
      magenta = "c678dd";
      violet = "a9a1e1";
      cyan = "6cdcf7";
      dark-cyan = "5699af";
      emphasis = "50536b";
      text = "dfdfdf";
      text-alt = "b2b2b2";
      fg = "abb2bf";
      bg = "282c34";
    };

    dracula = {
      scheme = "Dracula";
      base00 = "282936";
      base01 = "3a3c4e";
      base02 = "4d4f68";
      base03 = "626483";
      base04 = "62d6e8";
      base05 = "e9e9f4";
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2";
      base09 = "b45bcf";
      base0A = "00f769";
      base0B = "ebff87";
      base0C = "a1efe4";
      base0D = "62d6e8";
      base0E = "b45bcf";
      base0F = "00f769";
    };
  };
in
{
  _module.args.themeColors = schemes;
}
