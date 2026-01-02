#
#  Orca due to nvidia's bullshit
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "orca-slicer" ''
      # Driver overrides
      export __GLX_VENDOR_LIBRARY_NAME=mesa
      export __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json
      export MESA_LOADER_DRIVER_OVERRIDE=zink
      export GALLIUM_DRIVER=zink
      export WEBKIT_DISABLE_DMABUF_RENDERER=1
      

      # Zink memory stuff to suppress the massive amount of errors... Thanks nvidia
      export VK_DEVICE_MEMORY_REPORT_EXTENSION_NAME=VK_EXT_device_memory_report
      export ZINK_DESCRIPTOR_MODE=lazy
      export MESA_SHADER_CACHE_DISABLE=true
      export MESA_GL_VERSION_OVERRIDE=4.6
      export MESA_GLSL_VERSION_OVERRIDE=460
      export GALLIUM_HUD_VISIBLE=false
      
      exec ${pkgs.orca-slicer}/bin/orca-slicer "$@"
    '')
    
    # GTK dependencies
    gtk3
    glib
  ];
}
