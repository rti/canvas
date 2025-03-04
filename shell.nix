# Run with `nix-shell shell.nix`
{ pkgs ? import <nixpkgs>, ...}:

pkgs.mkShell {

  nativeBuildInputs = with pkgs; [
    pkg-config
    gobject-introspection
    rustc
    cargo
    cargo-tauri
    nodejs
  ];

  buildInputs = with pkgs;[
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    libz
    pango
    webkitgtk_4_1
    openssl
  ];

  shellHook = with pkgs; ''
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS;
    export GIO_MODULE_DIR="${glib-networking}/lib/gio/modules/";
  '';

}
