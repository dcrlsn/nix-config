{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.custom.programs.bambu-studio;
  isNvidia = builtins.elem "nvidia" config.services.xserver.videoDrivers;

  bambu-studio-wrapped = pkgs.symlinkJoin {
    name = "bambu-studio-wrapped";
    paths = [ pkgs.bambu-studio ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/bambu-studio \
        --set __GLX_VENDOR_LIBRARY_NAME mesa \
        --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json \
        --set MESA_LOADER_DRIVER_OVERRIDE zink \
        --set GALLIUM_DRIVER zink \
        --set WEBKIT_DISABLE_DMABUF_RENDERER 1 \
        --set VK_DEVICE_MEMORY_REPORT_EXTENSION_NAME VK_EXT_device_memory_report \
        --set ZINK_DESCRIPTOR_MODE lazy \
        --set MESA_SHADER_CACHE_DISABLE true \
        --set MESA_GL_VERSION_OVERRIDE 4.6 \
        --set MESA_GLSL_VERSION_OVERRIDE 460 \
        --set GALLIUM_HUD_VISIBLE false
    '';
  };

  bambuPkg = if cfg.nvidiaWorkaround then bambu-studio-wrapped else pkgs.bambu-studio;
in
{
  options.custom.programs.bambu-studio = {
    enable = lib.mkEnableOption "Bambu Studio";
    nvidiaWorkaround = lib.mkOption {
      type = lib.types.bool;
      default = isNvidia;
      description = "Wrap Bambu Studio with NVIDIA Zink compatibility flags";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bambuPkg
      gtk3
      glib
    ];
  };
}

